vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = { space = '·', tab = '» ', trail = '×', nbsp = '␣' }

vim.g.mapleader = " "

vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')

vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/nvim-mini/mini.pairs" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

local function safe_setup(plugin, opts)
    local ok, module = pcall(require, plugin)
    if ok then
        module.setup(opts or {})
    end
end

safe_setup("mini.pick")
safe_setup("mini.pairs")
safe_setup("oil")

local ts_ok, ts = pcall(require, "nvim-treesitter.configs")
if ts_ok then
    ts.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "bash" },
        highlight = { enable = true },
        auto_install = true
    })
end
