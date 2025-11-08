call plug#begin()

" File Explorer
Plug 'preservim/NERDTree'

" fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" sensible defaults for vim
Plug 'tpope/vim-sensible'

" indentLine 
Plug 'Yggdroot/indentLine'

" auto bracket pairs and stuff
Plug 'jiangmiao/auto-pairs'

" lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

" csharp syntax and indent
Plug 'oranget/vim-csharp'

" debug (DAP)
Plug 'puremourning/vimspector'

" color schemes
Plug 'morhetz/gruvbox'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }

" status line 
Plug 'itchyny/lightline.vim'

" razor pages syntax highlighting
Plug 'jlcrochet/vim-razor'

" instant markdown
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}

call plug#end()

filetype plugin on

set number
set relativenumber
set clipboard=unnamedplus

let g:indentLine_setExpand = 0
let g:indentLine_color_gui = "#66576b"

" Set theme
set background=dark
colorscheme moonfly
"colorscheme catppuccin-mocha
let g:lightline = { 'colorscheme': 'moonfly' }
"let g:lightline = { 'colorscheme': 'catppuccin_mocha' }

" Set transparency AFTER colorscheme
hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

" NERDTree Shortcuts
nnoremap <c-n> :NERDTreeToggle<CR>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" change to current dir automatically 
:set autochdir

" set the getcwd() to make fzf remember the root dir
let g:vim_start_dir = getcwd()

command! -bang -nargs=* Files
  \ call fzf#vim#files(g:vim_start_dir, fzf#vim#with_preview(), <bang>0)


" File Type detection
autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform

" coc extensions
let g:coc_global_extensions = ['coc-json', 'coc-yaml', 'coc-sql', 'coc-pyright', 'coc-clangd', 'coc-snippets']

" coc shortcuts
" Use <C-space> to trigger completion
inoremap <silent><expr> <C-Space> coc#refresh()

" Go to definition
nnoremap <silent> gd <Plug>(coc-definition)

" Show hover documentation
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Scroll floating/hover window forward/backward
nnoremap <expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1, 3) : "\<C-f>"
nnoremap <expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0, 3) : "\<C-b>"

" Scroll floating/hover window in insert mode
inoremap <expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1, 3) : "\<Right>"
inoremap <expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0, 3) : "\<Left>"

" Rename symbol
nnoremap <leader>rn <Plug>(coc-rename)

" Format buffer
nnoremap <leader>f :call CocAction('format')<CR>

" Code actions
nnoremap <leader>ca <Plug>(coc-codeaction)

" Navigate diagnostics
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <leader>ih :CocCommand document.toggleInlayHint<CR>

inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" vimspector shortcuts
nmap <F5> :call vimspector#Launch()<CR>
nmap <F9> :call vimspector#ToggleBreakpoint()<CR>
nmap <F10> :call vimspector#StepOver()<CR>
nmap <F11> :call vimspector#StepInto()<CR>
nmap <F12> :call vimspector#Reset()<CR>
