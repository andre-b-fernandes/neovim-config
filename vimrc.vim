
let g:denops#deno = '/Users/fernandoandrefernandes/.deno/bin/deno'

call plug#begin('~/.local/share/nvim/plugged')
Plug 'folke/lazy.nvim'
" Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/ddu.vim'
" Plug 'zchee/deoplete-jedi'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'machakann/vim-highlightedyank'
Plug 'tmhedberg/SimpylFold'
Plug 'morhetz/gruvbox'
Plug 'roxma/nvim-yarp'
Plug 'vim-denops/denops.vim'
Plug 'vim-denops/denops-helloworld.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'f-person/git-blame.nvim'
" Use release branch (recommended)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
Plug 'Vigemus/iron.nvim'
Plug 'hat0uma/csvview.nvim'
" If you have nodejs
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'williamboman/mason.nvim'
" Plug 'nvim-java/lua-async-await'
" Plug 'nvim-java/nvim-java-refactor'
" Plug 'nvim-java/nvim-java-core'
" Plug 'nvim-java/nvim-java-test'
" Plug 'nvim-java/nvim-java-dap'
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-jdtls'
Plug 'MunifTanjim/nui.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" Plug 'nvim-java/nvim-java'

call plug#end()


let mapleader = ","

" let g:jedi#goto_command = "<leader>d"
" let g:jedi#goto_assignments_command = "<leader>g"
" let g:jedi#goto_stubs_command = "<leader>s"
" let g:jedi#goto_definitions_command = ""
" let g:jedi#documentation_command = "K"
" let g:jedi#usages_command = "<leader>n"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#rename_command = "<leader>r"
" let g:jedi#rename_command_keep_name = "<leader>R"
" let g:jedi#use_splits_not_buffers = "right"
let g:airline_theme='dark_minimal'

" set highlight duration time to 1000 ms, i.e., 1 second
let g:highlightedyank_highlight_duration = 1000



nnoremap <Leader>b :NERDTreeToggle<ENTER>



:set number
colorscheme gruvbox
syntax enable
set background=dark " use dark mode
" set background=light " uncomment to use light mode
"
"
nnoremap <Leader>i :new term://zsh<ENTER>

nnoremap <Leader>k :vertical resize +3<ENTER>
nnoremap <Leader>l :vertical resize -3<ENTER>

nnoremap <Leader>h :resize +3<ENTER>
nnoremap <Leader>j :resize -3<ENTER>

nnoremap <Leader>p :Telescope find_files find_command=rg,--ignore,--hidden,--files<ENTER>
nnoremap <Leader>f :Telescope live_grep find_command=rg,--ignore,--hidden,--files<ENTER>



let g:gitblame_enabled = 0
let g:gitblame_message_template = '<summary> • <date> • <author> • <sha>'
let g:gitblame_message_when_not_committed = 'Oh please, commit this !'
let g:gitblame_highlight_group = "Question"


nmap <expr> <silent> <C-d> <SID>select_current_word()
function! s:select_current_word()
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc


