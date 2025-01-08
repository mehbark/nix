''
" TODO: really, really need to fix the whole path completion thing, i can see it but not actually do it
let mapleader = ";"
let maplocalleader = ";;"

let g:ConqueGdb_GdbExe = 'arm-none-eabi-gdb'

" call plug#begin('~/.config/nvim/plugged')
" " Using master branch
" call plug#end()


"===== Code Completion ====="
" autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" tab to select
" and don't hijack my enter key
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

"===== Compilation Error Navigation ====="
nmap <silent> <C-k> <Plug>(coc-diagnostic-next-error)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)


"===== Key bindings ====="
map <C-b> :BufExplorer<CR> " Explore buffers
map <C-K> :bnext<CR> " Next buffer!
map <C-J> :bprev<CR> " Prev buffer!
map <C-c> :Commentary<CR> " Toggle comment on this line

map <leader>w :w<cr>
map <leader>q :q<cr>

" mehbark added this, bracket and braces and stuff completion
" https://coderwall.com/p/h1dv0g/completion-for-parentheses-braces-and-brackets-in-vim
" inoremap { {}<left>
" inoremap {{ {
" inoremap {} {}
" inoremap {<cr> {<cr>}<esc>O
" inoremap [ []<left>
" inoremap [[ [
" inoremap [] []
" inoremap ( ()<left>
" inoremap (( (
" inoremap () ()
" inoremap " ""<left>
" inoremap "" ""

"===== Airline ====="
set ttimeoutlen=50
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
" let g:airline_left_sep=""
" let g:airline_right_sep=""
" let g:airline#extensions#whitespace#checks = [ 'indent' ]

" Map f4 to switch header/source for c projects
map <F4> :A<CR>

" remove trailing white spaces when saving
autocmd BufWritePre * :%s/\s\+$//e

" OCaml settings
filetype indent on
filetype plugin on

au BufRead,BufNewFile *.ml,*.mli compiler ocaml

" different color schemes depending on the file type
set t_Co=256
syntax enable
" colorscheme gruvbox


"===== NERDTree ====="
"Auto close if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Open nerd tree if no cl argument supplied
" function! StartUp()
"     if 0 == argc()
"         NERDTree .
"     end
" endfunction
" let g:NERDTreeWinPos = 'right'

" autocmd VimEnter * call StartUp()

"toggle on Ctrl+n
map <C-n> :NERDTreeToggle <cr>

" let g:NERDTreeWinSize=60


"===== Rust ====="
autocmd FileType rust nnoremap <buffer> <C-f> :RustFmt<CR>
let g:rustfmt_autosave = 1
let g:rustfmt_command = "rustfmt"
au BufNewFile,BufRead *.rs setlocal colorcolumn=100
let g:ycm_rust_src_path = '~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'


"===== Nvim Behaviour ====="
" Changes regular vim behaviours
" Set so the files auto updates when changed on disk
set autoread

" No swap files
set backupdir-=.
set backupdir^=~/tmp,/tmp

" Fold the code
set foldmethod=syntax
" activate the folder
set foldcolumn=1
" automatically fold larger files, for small ones, it doesn't matter
autocmd! BufReadPost * :if line('$') < 200 | set foldlevel=99 | else | set foldlevel=1 |endif
" Relative line numbers in normal mode, absolute in insert (mainly for reading errors easier)
set number

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber


"===== Persistent Undo ====="
" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile


"===== Close current buffer ====="
nnoremap <C-x> :BW<cr>


"===== Typo fixes ====="
"Fix common typos when saving and exiting
command WQ wq
command Wq wq
command W  w
command Q  q


"===== Misc ====="
set nocompatible
" Dont update view in scripts, 10000 times speedup
set lazyredraw
" set Colour support so airline works
set t_Co=256
" set mouse activated
set mouse=a
set clipboard=unnamedplus
" Include stdlib dirs for 'gf' command. Also include all subdir in
" workingfolder
let &path.="src/include,/usr/include/AL,.**"
" Search for tags file, from current directory until home directory
set tags=./tags;$HOME


"===== Terminal ====="
" Set exiting term mode to esc esc
tnoremap <esc><esc> <C-\><C-n>


set incsearch
set ignorecase
set smartcase
set tabstop=4 shiftwidth=4 expandtab
set wrap linebreak nolist  " list disables line break
" indicate where the 80 chars wide is
set cc=100
set textwidth=0
set wrapmargin=0
" set spell spelllang=en_us
set number
set relativenumber
set langmenu=en_US
let $LANG = 'en_US'
set cursorline
" retain undo history in buffers
set hidden
" set so the files auto updates when changed on disk
set autoread
" Better default for yanking
:map Y y$
" Set yank highlight to something reasonable
let g:highlightedyank_highlight_duration = 150


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"==== Haskell
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"==== Coc settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use tab for trigger completion with characters ahead and navigate.
"" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" if has('patch8.1.1068')
"   " Use `complete_info` if your (Neo)Vim version supports it.
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

let g:sexp_insert_after_wrap = 0

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

let g:airline#extensions#coc#enabled = 1
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function',''')}

" hopefully this fixes the weird thing with the working directory being a
" parent directory
" it hasn't, yet
set autochdir

" Mappings using CoCList:
" Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" / Coc settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"===== nix ====="
autocmd FileType nix :set shiftwidth=2
''
