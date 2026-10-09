-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Patch vim highlights query to remove "tab" keyword that older vim parsers don't support
local function patch_vim_highlights()
  local site_query = vim.fn.stdpath("data") .. "/site/queries/vim/highlights.scm"
  if vim.fn.filereadable(site_query) == 1 then
    local lines = vim.fn.readfile(site_query)
    local changed = false
    for i, line in ipairs(lines) do
      if line:match('^%s*"tab"%s*$') then
        lines[i] = nil
        changed = true
        break
      end
    end
    if changed then
      vim.fn.writefile(vim.tbl_filter(function(l) return l ~= nil end, lines), site_query)
    end
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = patch_vim_highlights,
})
