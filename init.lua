-- Set leader key before loading plugins
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
  -- Git integration
  {
     "tpope/vim-fugitive",
  },
  -- File explorer
  {
    "preservim/nerdtree",
    keys = {
      { "<Leader>b", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
    },
  },

  -- Completion framework
  {
    "Shougo/deoplete.nvim",
    build = ":UpdateRemotePlugins",
  },
  "Shougo/ddu.vim",

  -- Status line
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    config = function()
      vim.g.airline_theme = 'dark_minimal'
    end,
  },
  "vim-airline/vim-airline-themes",

  -- Commenting
  "scrooloose/nerdcommenter",

  -- Highlight yanked text
  {
    "machakann/vim-highlightedyank",
    config = function()
      vim.g.highlightedyank_highlight_duration = 1000
    end,
  },

  -- Folding
  "tmhedberg/SimpylFold",

  -- Colorscheme
  {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme gruvbox")
      vim.opt.background = "dark"
    end,
  },

  -- Denops
  "roxma/nvim-yarp",
  {
    "vim-denops/denops.vim",
    config = function()
      vim.g['denops#deno'] = '/Users/fernandoandrefernandes/.deno/bin/deno'
    end,
  },
  "vim-denops/denops-helloworld.vim",

  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<Leader>p", ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", desc = "Find files" },
      { "<Leader>f", ":Telescope live_grep<CR>", desc = "Live grep" },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end
      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          disable = { "c", "rust" },
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },

  -- Git blame
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 0
      vim.g.gitblame_message_template = '<summary> • <date> • <author> • <sha>'
      vim.g.gitblame_message_when_not_committed = 'Oh please, commit this !'
      vim.g.gitblame_highlight_group = "Question"
    end,
  },

  -- COC (Conquer of Completion)
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      -- COC multi-cursor word selection
      vim.keymap.set('n', '<C-d>', function()
        if vim.b.coc_cursors_activated then
          return '*<Plug>(coc-cursors-word):nohlsearch<CR>'
        else
          return '<Plug>(coc-cursors-word)'
        end
      end, { expr = true, silent = true })
    end,
  },

  -- REPL integration
  {
    "Vigemus/iron.nvim",
    cmd = { "IronRepl", "IronRestart", "IronFocus", "IronHide" },
    config = function()
      local ok, iron = pcall(require, "iron.core")
      if not ok then
        return
      end
      iron.setup({
        config = {
          scratch_repl = true,
          repl_definition = {
            sh = {
              command = { "zsh" }
            },
            python = {
              command = { "python" },
              format = require("iron.fts.common").bracketed_paste_python
            }
          },
          repl_open_cmd = require('iron.view').split.vertical.botright(50),
        },
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_paragraph = "<space>sp",
          send_until_cursor = "<space>su",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        highlight = {
          italic = true
        },
        ignore_blank_lines = true,
      })

      -- Iron keymaps
      vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
      vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
      vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
      vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
    end,
  },

  -- CSV viewer
  {
    "hat0uma/csvview.nvim",
    ft = { "csv" },
    config = function()
      local ok, csvview = pcall(require, "csvview")
      if ok then
        csvview.setup()
      end
    end,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npx --yes yarn install",
    ft = { "markdown" },
  },

  -- LSP and completion
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
    config = function()
      local ok, mason = pcall(require, "mason")
      if ok then
        mason.setup()
      end
    end,
  },

  "neovim/nvim-lspconfig",
  "mfussenegger/nvim-dap",
  "mfussenegger/nvim-jdtls",
  "MunifTanjim/nui.nvim",

  -- Completion plugins
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/vim-vsnip",
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/vim-vsnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        window = {},
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' },
        })
      })
    end,
  },

  -- Claude Code
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = function()
      require("claudecode").setup({
        terminal = {
          split_side = "right",
          split_width_percentage = 0.35,
        },
      })

      -- Add terminal mode keybindings for all terminal windows
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        callback = function()
          local opts = { buffer = true, silent = true }
          vim.keymap.set('t', '<C-w>h', [[<C-\><C-n><C-w>h]], vim.tbl_extend('force', opts, { desc = "Go to left window" }))
          vim.keymap.set('t', '<C-w>j', [[<C-\><C-n><C-w>j]], vim.tbl_extend('force', opts, { desc = "Go to lower window" }))
          vim.keymap.set('t', '<C-w>k', [[<C-\><C-n><C-w>k]], vim.tbl_extend('force', opts, { desc = "Go to upper window" }))
          vim.keymap.set('t', '<C-w>l', [[<C-\><C-n><C-w>l]], vim.tbl_extend('force', opts, { desc = "Go to right window" }))
          vim.keymap.set('t', '<C-w><C-w>', [[<C-\><C-n><C-w>w]], vim.tbl_extend('force', opts, { desc = "Cycle windows" }))
        end,
      })
    end,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Function to get LSP capabilities (lazy-loaded)

-- LSP Configuration
local map = function(type, key, value)
  vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true })
end

local custom_attach = function(client, bufnr)
  print("LSP started.")

  -- LSP keymaps
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  map('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  map('n', '<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  map('n', '<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  map('n', '<leader>ah', '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', '<leader>an', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('n', '<leader>ee', '<cmd>lua vim.diagnostic.open_float()<CR>')
  map('n', '<leader>ar', '<cmd>lua vim.lsp.buf.rename()<CR>')
  map('n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<CR>')
  map('n', '<leader>ai', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
  map('n', '<leader>ao', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')

  -- Diagnostic navigation
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
end

-- Function to detect Python virtual environment
local function get_python_path(workspace)
  -- Check for common venv locations
  local venv_paths = {
    workspace .. '/.venv/bin/python',
    workspace .. '/venv/bin/python',
    workspace .. '/env/bin/python',
    workspace .. '/.env/bin/python',
  }

  for _, path in ipairs(venv_paths) do
    if vim.fn.executable(path) == 1 then
      return path
    end
  end

  -- Check VIRTUAL_ENV environment variable (for activated venvs)
  local venv = os.getenv('VIRTUAL_ENV')
  if venv then
    return venv .. '/bin/python'
  end

  -- Check CONDA_PREFIX for conda environments
  local conda = os.getenv('CONDA_PREFIX')
  if conda then
    return conda .. '/bin/python'
  end

  -- Fall back to system python
  return vim.fn.exepath('python3') or vim.fn.exepath('python')
end

-- Auto-start LSP servers when opening files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function(args)
    local root_dir = vim.fs.root(args.buf, { 'pyproject.toml', 'poetry.lock', '.git' })
    local python_path = get_python_path(root_dir or vim.fn.getcwd())

    vim.lsp.start({
      name = 'pyright',
      cmd = { "/Users/fernandoandrefernandes/.nvm/versions/node/v20.15.1/bin/pyright-langserver", "--stdio" },
      root_dir = root_dir,
      capabilities = capabilities,
      on_attach = custom_attach,
      settings = {
        python = {
          pythonPath = python_path,
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        }
      },
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'elixir', 'eelixir' },
  callback = function(args)
    vim.lsp.start({
      name = 'elixirls',
      cmd = { "/Users/fernandoandrefernandes/.vscode/extensions/jakebecker.elixir-ls-0.24.2/elixir-ls-release/language_server.sh" },
      root_dir = vim.fs.root(args.buf, { 'mix.exs', '.git' }),
      capabilities = capabilities,
      on_attach = custom_attach,
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'objc', 'objcpp' },
  callback = function(args)
    vim.lsp.start({
      name = 'clangd',
      cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
      root_dir = vim.fs.root(args.buf, { '.clangd', 'compile_commands.json', '.git' }),
      capabilities = capabilities,
      on_attach = custom_attach,
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function(args)
    vim.lsp.start({
      name = 'jdtls',
      cmd = { '/Users/fernandoandrefernandes/jdt-language-server-1.46.0-202502271940/bin/jdtls' },
      root_dir = vim.fs.root(args.buf, { 'gradlew', '.git', 'mvnw' }),
      capabilities = capabilities,
      on_attach = custom_attach,
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function(args)
    vim.lsp.start({
      name = 'lua_ls',
      cmd = { 'lua-language-server' },
      root_dir = vim.fs.root(args.buf, { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' }),
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
      on_attach = custom_attach,
    })
  end,
})

-- General settings
vim.opt.number = true
vim.cmd("syntax enable")

-- Configure diagnostics
vim.diagnostic.config({
  virtual_text = true,  -- Show diagnostic messages inline
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
  underline = true,     -- Underline problematic code
  update_in_insert = false,  -- Don't update diagnostics while typing
  severity_sort = true,      -- Sort by severity
  float = {
    border = "rounded",
    source = "always",  -- Show source of diagnostic
    header = "",
    prefix = "",
  },
})

-- Additional keymaps
vim.keymap.set('n', '<Leader>i', ':new term://zsh<CR>', { desc = "Open terminal" })
vim.keymap.set('n', '<Leader>k', ':vertical resize +3<CR>', { desc = "Increase vertical size" })
vim.keymap.set('n', '<Leader>l', ':vertical resize -3<CR>', { desc = "Decrease vertical size" })
vim.keymap.set('n', '<Leader>h', ':resize +3<CR>', { desc = "Increase horizontal size" })
vim.keymap.set('n', '<Leader>j', ':resize -3<CR>', { desc = "Decrease horizontal size" })
