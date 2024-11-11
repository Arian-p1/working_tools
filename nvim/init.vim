set termguicolors
luafile ~/.config/nvim/lua/init.lua

syntax on

" sessions
noremap <F1> :w <cr>
noremap <F2> :Gitsigns <cr>
noremap <F3> :set foldmethod=indent <cr>
noremap <F4> :q! <cr>
noremap <F5> :terminal <cr>
noremap <F7> :DiffviewOpen <cr>
noremap <F9> :DapToggleBreakpoint <cr>
noremap <F10> :DapContinue <cr>


au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w

set t_Co=256
set nocursorline
set title
set bs=2
set noautoindent
set ruler
set shortmess=aoOTI
set nocompatible
set showmode
set splitbelow
set showcmd
set showmatch
set tabstop=2
set shiftwidth=2
set expandtab
set cinoptions=(0,m1,:1
set tw=80
set formatoptions=tcqro2
set smartindent
set laststatus=2
set guicursor=a:blinkon3
set nomodeline
set softtabstop=2
set showtabline=1
set scrolloff=4
set hlsearch
set incsearch
set ignorecase
set smartcase
set foldmethod=marker
set ttyfast
set history=10000
set hidden
set number
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview
set noswapfile
set foldlevelstart=0
set wildmenu
set wildmode=list:longest,full
set wrap
set autoread
set conceallevel=2
set concealcursor=vin

let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
" colapse
" set foldmethod=indent
" set foldnestmax=10
" set foldenable
" set foldlevel=2

nmap <silent> <C-l> :bnext <CR>
nmap <silent> <C-h> :BB <CR>

let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'
let g:hexmode_xxd_options = '-g 1'
set clipboard+=unnamedplus
"set splitright
set guifont=Hasklig\ Medium:h12
highlight! link tomlKey Red
highlight! link tomlBoolean Blue
highlight! link tomlString Green
highlight! link tomlTable Red
highlight! link tomlTableArray Purple
set nu rnu
set noautoindent
noremap <C-m> :nohlsearch<cr>
noremap <C-e> :Oil<cr>
noremap <C-space> :Telescope <cr>
noremap <Space>b :Telescope buffers <cr>
noremap <Space>f :Telescope find_files <cr>
noremap <Space>d :Telescope diagnostics <cr>
noremap <Space>r :Telescope lsp_references <cr>
noremap <Space>m :Telescope marks <CR>
noremap <Space>s :Telescope live_grep <cr>
noremap <Space>g :Gitsigns preview_hunk <cr>
nnoremap <silent>L :BufferLineCycleNext<CR>
nnoremap <silent>H :BufferLineCyclePrev<CR>
noremap <C-s> :split<cr>
noremap <C-v> :vsplit<cr>
nnoremap <M-l> :vertical res +3<CR>
nnoremap <M-h> :vertical res -3<CR>
nnoremap <M-k> :horizontal res +3<CR>
nnoremap <M-j> :horizonta res -3<CR>
tnoremap <Esc> <C-\><C-n>
" highlight! NormalFloat ctermbg=black ctermfg=white
" highlight! Pmenu ctermbg=black
" highlight! PmenuSel ctermbg=white
let g:code_action_menu_window_border = 'single'
let g:code_action_menu_show_details = v:true
let g:code_action_menu_show_diff = v:true
let g:code_action_menu_show_action_kind = v:false
nmap   <C-RightMouse>         <Plug>(VM-Mouse-Cursor)
nmap   <M-C-RightMouse>      <Plug>(VM-Mouse-Column)
nnoremap <C-\> :lua vim.lsp.buf.definition()<CR>
" cursor
highlight CursorWord gui=none guibg=#625c53

let g:lightline={ 'enable': {'statusline': 1, 'tabline': 0} }

colorscheme leet

