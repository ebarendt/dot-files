-- Ruby LSP setup for the monorepo.
--
-- ruby-lsp's built-in RuboCop addon runs inside its composed bundle
-- (platform/.ruby-lsp/Gemfile.lock), which eval_gemfiles the project Gemfile
-- and therefore already loads the `rubocop-mt` path gem and honors
-- `.rubocop.yml`'s `plugins: - rubocop-mt`. Verified: ruby-lsp emits
-- `Custom/*` (rubocop-mt) diagnostics out of the box.
--
-- So we let ruby-lsp handle RuboCop and DISABLE the standalone Mason rubocop
-- LSP, which runs in an isolated gem env and can't find rubocop-mt
-- (`cannot load such file -- rubocop-mt`) and would also duplicate diagnostics.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rubocop = { enabled = false },
      },
    },
  },
  -- Format Ruby with ruby-lsp (LSP) instead of conform -> Mason rubocop.
  -- ruby-lsp runs RuboCop in its composed bundle, so autocorrect uses
  -- rubocop-mt too. Removing conform's `ruby` formatter makes LazyVim fall
  -- back to the LSP formatter for Ruby files. (eruby/ERB still uses conform.)
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.ruby = nil
    end,
  },
}
