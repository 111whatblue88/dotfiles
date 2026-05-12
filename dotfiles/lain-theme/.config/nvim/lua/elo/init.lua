require("elo.remap")
vim.cmd("TransparentEnable")

vim.cmd("colorscheme lain")

vim.o.tabstop = 2 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting

vim.opt.relativenumber = true
vim.opt.number = true

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- nvim tree setup

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.map.on_attach.default(bufnr)

  -- custom mappings
  vim.keymap.set("n", "<leader>e", api.tree.change_root_to_parent,        opts("Up"))
end


---@type nvim_tree.config
local config = {
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}

require("nvim-tree").setup(config)









-- Defined in init.lua

vim.lsp.config('clangd', {
  capabilities = {
    offsetEncoding = { "utf-8", "utf-16" },
      textDocument = {
        completion = {
        editsNearCursor = true
      }
    }
  },

  cmd = { 'clangd' },

  root_markers = { '.clangd', 'compile_commands.json' },

  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
})

vim.o.autocomplete = true

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
    end
  end,
  
})

vim.opt.complete:append('o')

vim.opt.completeopt = { 'menuone', 'noinsert', "preview", "noselect" }

vim.o.pumheight = 5

vim.lsp.enable('clangd')




