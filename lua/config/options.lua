-- init
vim.loader.enable()

-- explore
vim.cmd("let g:netrw_liststyle = 3")

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- encoding
-- vim.opt.encoding = "utf-8"
-- vim.scriptencoding = "utf-8"

-- options
vim.g.autoformat = true
vim.g.editorconfig = true
vim.g.markdown_recommended_style = 0

-- lsp
vim.g.ai_cmp = true
vim.g.deprecation_warnings = false
vim.g.root_lsp_ignore = { "copilot" }

-- snacks
vim.g.snacks_animate = true

-- lualine
vim.g.trouble_lualine = true
vim.g.lualine_info_extras = true

-- lazydev
vim.g.lazydev_enabled = true

-- lazyvim
vim.g.lazyvim_cmp = "auto" -- nvim-cmp, blink.cmp
vim.g.lazyvim_picker = "auto" -- snacks, fzf, telescope
vim.g.lazyvim_explorer = "auto" -- snacks, neo-tree
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

-- spell checking
-- opt.spell = true
-- opt.spelllang = { "en" }

-- options
opt.autowrite = true
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 99
opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.jumpoptions = "view"
opt.laststatus = 3
opt.linebreak = true
opt.list = true
opt.mouse = "a"
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.ruler = false
opt.scrolloff = 10
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = vim.g.vscode and 1000 or 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false

-- display
opt.title = true
opt.hlsearch = true
opt.smarttab = true
opt.background = "dark"
opt.signcolumn = "yes"

-- cmd
opt.cmdheight = 0
opt.showcmd = false

-- cursor
opt.cursorlineopt = "number"
opt.guicursor = "i:ver25-blinkon1,ci:ver25-blinkon1,c:ver25-blinkon1"

-- mouse
opt.mousemodel = "extend"

-- splits
-- opt.splitkeep = "cursor"
opt.inccommand = "split"
opt.path:append({ "**" })

-- backup
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- formatting
opt.formatoptions:append({ "r" })

-- backspacing & indentation when wrapping
opt.autoindent = true
opt.breakindent = true
opt.backspace = { "start", "eol", "indent" }

-- file/project specific
opt.wildignore:append({ "*/node_modules/*" })

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
  opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  opt.foldmethod = "expr"
  opt.foldtext = ""
else
  opt.foldmethod = "indent"
  opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end
