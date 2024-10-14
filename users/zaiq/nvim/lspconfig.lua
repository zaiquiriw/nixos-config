require'lspconfig'.nixd.setup{
  cmd = { "nixd" },
    settings = {
      nixd = {
        nixpkgs = {
          expr = "import <nixpkgs> { }",
        },
        formatting = {
          command = { "nixfmt" },
        },
        options = {
          nixos = {
            expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
          },
          home_manager = {
            expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options',
          },
        },
      },
    },
}

-- LSP configuration
require('lspconfig').lua_ls.setup{}
require('lspconfig').rust_analyzer.setup{}

-- Telescope configuration
require('telescope').setup{}

-- Treesitter configuration
require('nvim-treesitter.configs').setup{
  highlight = { enable = true },
}

-- Lualine configuration
require('lualine').setup{
  options = { theme = 'gruvbox' }
}

-- vim-tmux navigator config
vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', { silent = true })
vim.keymap.set('n', '<C-\\>', ':TmuxNavigatePrevious<CR>', { silent = true })

-- Window Management
vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.equalalways = false
require('windows').setup()

-- Colorscheme
vim.cmd('colorscheme gruvbox')

-- Completion setup
local cmp = require('cmp')
cmp.setup{
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
