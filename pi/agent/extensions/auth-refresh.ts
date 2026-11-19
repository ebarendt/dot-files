// Auth refresh (port of the opencode auth-refresh plugin): when a model request fails
// because the AWS SSO credentials expired, offer to run `mt auth` (or $OC_REFRESH_AUTH)
// in the terminal, then optionally continue the session. /auth-refresh runs it manually.
import { spawnSync } from "node:child_process";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";

const EXPIRED =
  /Token is expired|aws sso login|credential chain failed|Could not load credentials|returned expired credentials|ExpiredToken|security token included in the request is expired|no credentials for \[/i;
const COOLDOWN = 30_000; // ignore repeat failures right after a dialog closes

const command = () => process.env.OC_REFRESH_AUTH?.trim() || "mt auth";

export default function (pi: ExtensionAPI) {
  let expired = false;
  let busy = false;
  let quietUntil = 0;

  // Hand the terminal to the command while the TUI is stopped.
  const run = (ctx: ExtensionContext) =>
    ctx.ui.custom<{ ok: boolean; detail: string }>((tui, _theme, _kb, done) => {
      tui.stop();
      process.stdout.write(`\n$ ${command()}\n`);
      const out = spawnSync(process.env.SHELL || "/bin/sh", ["-c", command()], {
        stdio: "inherit",
        env: process.env,
        timeout: 5 * 60_000,
      });
      tui.start();
      tui.requestRender(true);
      done({ ok: out.status === 0, detail: out.error?.message ?? `exit ${out.status}` });
      return { render: () => [], invalidate: () => {} };
    });

  const signIn = async (ctx: ExtensionContext) => {
    const result = await run(ctx);
    if (!result.ok) ctx.ui.notify(`Sign-in failed: \`${command()}\` (${result.detail})`, "error");
    return result.ok;
  };

  const offer = async (ctx: ExtensionContext) => {
    if (busy || Date.now() < quietUntil || ctx.mode !== "tui") return;
    busy = true;
    try {
      const CONTINUE = "Sign in and continue";
      const SIGN_IN = "Sign in";
      const choice = await ctx.ui.select(`AWS sign-in expired. Run \`${command()}\`?`, [CONTINUE, SIGN_IN, "Not now"]);
      if (choice !== CONTINUE && choice !== SIGN_IN) return;
      if (!(await signIn(ctx))) return;
      if (choice === CONTINUE) {
        ctx.ui.notify("Signed in. Continuing.", "info");
        pi.sendUserMessage("Continue.", ctx.isIdle() ? undefined : { deliverAs: "followUp" });
      } else {
        ctx.ui.notify("Signed in. Send your message again.", "info");
      }
    } catch (e) {
      ctx.ui.notify(`Auth refresh: ${String(e)}`, "error");
    } finally {
      busy = false;
      quietUntil = Date.now() + COOLDOWN;
    }
  };

  // Only look at failed assistant messages, so a prompt quoting the error doesn't trigger it.
  pi.on("message_end", async (event) => {
    const m: any = event.message;
    if (m.role === "assistant" && m.stopReason === "error" && EXPIRED.test(m.errorMessage ?? "")) expired = true;
  });

  pi.on("agent_settled", async (_event, ctx) => {
    if (!expired) return;
    expired = false;
    void offer(ctx); // don't block settle handlers on the dialog
  });

  pi.registerCommand("auth-refresh", {
    description: `Refresh AWS credentials with \`${command()}\``,
    handler: async (_args, ctx) => {
      if (ctx.mode !== "tui") return ctx.ui.notify("auth-refresh needs the TUI", "error");
      if (await signIn(ctx)) ctx.ui.notify("Signed in.", "info");
    },
  });
}
