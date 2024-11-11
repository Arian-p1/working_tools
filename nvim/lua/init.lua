local plugins = {
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    config = function()
      require("monokai-pro").setup()
      vim.cmd([[colorscheme monokai-pro-classic]])
    end
  },
  "tjdevries/colorbuddy.nvim",
  {
  'Tsuzat/NeoSolarized.nvim',
  lazy = false, -- Ensure it loads during startup
  priority = 1000, -- Load it before other plugins
  config = function()
    vim.cmd [[ colorscheme NeoSolarized ]]
  end
  },
  "sbdchd/neoformat",
  "MunifTanjim/nui.nvim",
  "itchyny/vim-cursorword",
  "qpkorr/vim-bufkill",
  "mg979/vim-visual-multi",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "kethku/vim-floaterm",
  "tamago324/nlsp-settings.nvim",
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
    } -- this is equalent to setup({}) function
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "yuttie/comfortable-motion.vim",
  {
    'BartSte/nvim-project-marks',
    lazy = false,
    config = function()
        require('projectmarks').setup({
          shadafile = '.marks',
          mappings = true,
          message = 'Waiting for mark...'
      })
    end
  },
  {'akinsho/git-conflict.nvim', branch = "v1.3.0", config = true},
  "lewis6991/gitsigns.nvim",
  "sindrets/diffview.nvim",
  "mfussenegger/nvim-dap",
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"} },
  "folke/neodev.nvim",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "mfussenegger/nvim-lint",
  {
    "L3MON4D3/LuaSnip",
    build = vim.fn.has "win32" ~= 0 and "make install_jsregexp" or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "benfowler/telescope-luasnip.nvim",
    },
    config = function(_, opts)
      if opts then require("luasnip").config.setup(opts) end
      vim.tbl_map(
        function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
        { "vscode", "snipmate", "lua" }
      )
    end,
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {'kevinhwang91/nvim-ufo', dependencies = {"kevinhwang91/promise-async"}},
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "rust", "cpp", "go", "bash", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
  },
  "theHamsta/nvim-dap-virtual-text",
  {
  'stevearc/oil.nvim',
  opts = {
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
    },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.2.0", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  "rcarriga/nvim-notify",
  {
    "j-hui/fidget.nvim",
    tag = "v1.0.0",
    opts = {
      -- options
    },
  },
}

local opts = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
require("lazy").setup(plugins, opts)
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "rust_analyzer",
    "bashls",
    "cssls",
    "gopls",
    "html",
    "htmx",
    "pyright",
    "tailwindcss",
    "templ"
  },
})
require("dapui").setup()
require("neodev").setup({
  library = {
    enabled = true,
    plugins = { "nvim-dap-ui" },
    types = true
  },
})
require("nvim-dap-virtual-text").setup()
require("notify").setup()
require('Comment').setup()

local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--lsp
local nvim_lsp = require'lspconfig'
local configs = require('lspconfig/configs')

local on_attach = function(client)
    require'completion'.on_attach(client)
end
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require('lspconfig')['gopls'].setup{
  -- on_attach = on_attach,
  flags = lsp_flags,
}

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

require'lspconfig'.htmx.setup{}

require('lspconfig')['clangd'].setup{
  -- on_attach = on_attach,
  flags = lsp_flags,
  default_config = {
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' };
  };
}

require('lspconfig')['pyright'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
    venvPath = vim.fn.getcwd() .. "/.venv",
  },
}

require('lspconfig')['bashls'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require('lspconfig')['templ'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require('lspconfig')['rust_analyzer'].setup {
on_attach = on_attach,
flags = lsp_flags,
  -- Server-specific settings...
  settings = {
      ["rust-analyzer"] = {
          imports = {
              granularity = {
                  group = "module",
              },
              prefix = "self",
          },
          cargo = {
              buildScripts = {
                  enable = true,
              },
          },
          procMacro = {
              enable = true
          },
      }
  }
}
require('lspconfig')['solargraph'].setup {
  cmd = {"solargraph", "stdio"},
  filetypes = {"ruby"},
  root_dir = function(fname)
    return vim.loop.cwd()
  end,
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true,
      flags = {
        debounce_text_changes = 150
      },
      initializationOptions = {
        formatting = true
      }
    }
  },
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
               {virtual_text = true, signs = true, update_in_insert = true})

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end, { 'i', 's' }),
['<S-Tab>'] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)


local nlspsettings = require("nlspsettings")

nlspsettings.setup({
  config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
  local_settings_dir = ".nlsp-settings",
  local_settings_root_markers_fallback = { '.git' },
  append_default_schemas = true,
  loader = 'json'
})
function on_attach(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local global_capabilities = vim.lsp.protocol.make_client_capabilities()
global_capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  capabilities = global_capabilities,
})
--vim-devicons
local cmd = vim.cmd
cmd  "set encoding=UTF-8"

--telescop
local telescope = require('telescope')

telescope.setup {

    pickers = {

        find_files = {

            hidden = true

        }

    }
}
local tactions = require('telescope.actions')
-- This is your opts table
require("telescope").setup {
  defaults = {
    -- ...
    -- layout_config = {
    --   preview_width = 0.6,  -- Adjust the width of the previewer
    --   preview_height = 0.5,  -- Adjust the height of the previewer
    -- },
  },
}

local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

dap.adapters.c = {
    type = "executable",
    command = "/usr/bin/lldb-vscode", -- adjust as needed
    name = "lldb",
}

dap.adapters.rust = {
    type = "executable",
    command = "/usr/bin/lldb-vscode", -- adjust as needed
    name = "lldb",
}

dap.adapters.rust = {
  type = "executable",
  command = "gdb",
  name = "gdb",
  args = { "-i", "dap" }
}

dap.adapters.c = {
  type = "executable",
  command = "gdb",
  name = "gdb",
  args = { "-i", "dap" }
}

dap.adapters.go = {
  type = 'executable';
  command = 'node';
  args = {os.getenv('HOME') .. '/dev/golang/vscode-go/dist/debugAdapter.js'};
}

require("dap.ext.vscode").load_launchjs(vim.fn.getcwd() .. "/.vscode/launch.json", {})

require('gitsigns').setup()

local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  -- Add other linters you need here
}

vim.keymap.set("n", "<space>l", function()
  lint.try_lint()
end, { desc = "Trigger Snyk linting for current file" })


local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end

local luasnip = prequire('luasnip')
local cmp = prequire("cmp")

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_next_item()
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
    elseif check_back_space() then
        return t "<Tab>"
    else
        cmp.complete()
    end
    return ""
end
_G.s_tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        return t "<S-Tab>"
    end
    return ""
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-e>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-e>", "<Plug>luasnip-next-choice", {})

vim.filetype.add({ extension = { templ = "templ" } })



local ok_status, NeoSolarized = pcall(require, "NeoSolarized")

if not ok_status then
  return
end

NeoSolarized.setup {
  style = "dark", -- or "light"
  transparent = false,
  terminal_colors = true, -- Configure terminal colors
  enable_italics = true, -- Enable italics
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { bold = true },
    variables = {},
    string = { italic = true },
    underline = true, -- Global underline
    undercurl = true, -- Global undercurl
  },
  on_highlights = function(highlights, colors)
    -- Custom highlights
  end,
}

vim.cmd [[
   try
        colorscheme NeoSolarized
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
        set background=dark
    endtry
]]

