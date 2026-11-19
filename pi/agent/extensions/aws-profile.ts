// Default the AWS profile pi uses for Bedrock, without needing it in the shell.
// An AWS_PROFILE already set in the environment wins.
//
// opencode-bedrock is a credential_process wrapper around the `mt auth` creds for
// demo_ClaudeCodeBedrock (see ~/.aws/config). The AWS SDK caches ~/.aws/credentials
// for the life of the process, so using demo_ClaudeCodeBedrock directly would keep
// the expired keys after `mt auth`; the credential_process re-reads them on every request.
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

process.env.AWS_PROFILE ??= "opencode-bedrock";

export default function (_pi: ExtensionAPI) {}
