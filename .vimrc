set nocompatible              " be iMproved, required
set hidden

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"------------------------------------------------------------------------------
" let Vundle manage Vundle, required
" Notes:
" For the plugins to setup, I will do it step by step just like I am building
" a new software application.
"
"	(1) NERDTree					- Done
"	(2) vim-airline					- In progress
"	(3) vim-airline-themes			- Done
"	(4) vim-buffer					- Done
"	(5) ctrlp						- Done
"	(6) tabline						- Done
"	(7) powerline					- Done
"	(8) syntastic					- Done
"	(9) vim-devicons				- Done
"	(10) vim-nerdtree-syntax-height	- Done
"	(11) vim-ctrlspace				- Done
"	(12) fugitive					- Done
"	(13) cursormode					- Pending
"	(14) gitgutter					- In progress
"	(15) vim-signify				- Pending
"------------------------------------------------------------------------------
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mkitt/tabline.vim'
Plugin 'bling/vim-bufferline'
Plugin 'powerline/powerline'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-ctrlspace/vim-ctrlspace'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'vheon/vim-cursormode'

Plugin 'lifepillar/vim-solarized8'
Plugin 'morhetz/gruvbox'

call vundle#end()            " required

syntax on
filetype plugin indent on    " required

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

set background=dark
colorscheme solarized8

"------------------------------------------------------------------------------
" PLUGIN: NERDTree Configurations
"------------------------------------------------------------------------------

" Autocommands "
"--------------"
autocmd vimenter * NERDTree

" When we launch Vim without a file to edit
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Auto-start NERDTree when we open a directory in Vim "
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Let's close Vim entirely when NERDTree is the only window left open. We will
" keep this autocommands here in case I feel like using it in the future. "
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
" b:NERDTree.isTabTree()) | q | endif

" NERDTree File highlighting "
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

" Time for some NERDTree Settings "
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeShowHidden = 1
let g:NERDTreeMouseMode = 2

" Mapping shortcut keys to toggle the NERDTree "
map <C-t> :NERDTreeToggle<CR>

"------------------------------------------------------------------------------
" PLUGIN: Airline Themes
" List of working themes for Vim includes:
"   (1) 
"------------------------------------------------------------------------------
let g:airline_theme='murmur'
"let g:airline_solarized_bg='dark'

"------------------------------------------------------------------------------
" PLUGIN: Airline Configurations
"------------------------------------------------------------------------------ 
function! AirlineInit()
	let g:airline_section_a = airline#section#create(['mode'])
	let g:airline_section_b = airline#section#create_left(['hunks'])
	let g:airline_section_c = airline#section#create(['%f'])
	let g:airline_section_x = airline#section#create(['branch', 'ffenc'])
	let g:airline_section_y = airline#section#create(['filetype'])
endfunction
autocmd VimEnter * call AirlineInit()
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_inactive_collapse=1
let g:airline_inactive_alt_sep=1

"------------------------------------------------------------------------------
" PLUGIN: Fugitive Configurations (Airline Extensions)
"------------------------------------------------------------------------------
let g:airline#extensions#fugitiveline#enabled = 1

"------------------------------------------------------------------------------
" PLUGIN: GitGutter Configuration (Airline Extensions)
"------------------------------------------------------------------------------
let g:gitgutter_enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 0
let g:airline#extensions#hunks#hunk_symbols = [ '+', '~', '-' ]

"------------------------------------------------------------------------------
" PLUGIN: Powerline Configurations (Airline Extensions)
"------------------------------------------------------------------------------
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
     let g:airline_symbols = {}
endif

let g:airline_left_sep = ''                                                                                                                                                     
let g:airline_right_sep = ''                                                                                                                                                    
let g:airline_symbols.branch = '⎇'

"------------------------------------------------------------------------------
" PLUGIN: Tabline Configurations (Airline Extensions)
"------------------------------------------------------------------------------
let g:tablineclosebutton = 1
let g:airline#extensions#tabline#close_symbol = 'X'
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 2  " splits and tab number
let g:airline#extensions#tabline#overflow_marker = '…'

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

"------------------------------------------------------------------------------
" PLUGIN: Ctrlspace Configurations (Airline Extensions)
"------------------------------------------------------------------------------
let g:CtrlSpaceDefaultMappingKey = "<C-space>"
let g:airline#extensions#ctrlspace#enabled = 1
let g:CtrlSpaceStatuslineFunction = "airline#extensions#ctrlspace#statusline()"

if has("gui_running")
	let g:CtrlSpaceSymbols = { "File": "◯", "CTab": "▣", "Tabs": "▢"  }
endif

if executable("ag")
	let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

hi link CtrlSpaceNormal	  PMenu
hi link CtrlSpaceSelected PMenuSel
hi link CtrlSpaceSearch	  IncSearch
hi link CtrlSpaceStatus	  StatusLine

"------------------------------------------------------------------------------
" PLUGIN: Bufferline Configurations (Airline Extensions)
"------------------------------------------------------------------------------
let g:airline#extensions#bufferline#enabled = 1

"------------------------------------------------------------------------------
" PLUGIN: Syntastic Configurations (Airline Extensions)
"------------------------------------------------------------------------------
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#syntastic#error_symbol = '⛔'
let airline#extensions#syntastic#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#syntastic#warning_symbol = '⚠'
let airline#extensions#syntastic#stl_format_warn = '%W{[%w(#%fw)]}'

"------------------------------------------------------------------------------
" PLUGIN: Ctrlp Configurations (Airline Extensions)
"------------------------------------------------------------------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:airline#extensions#ctrlp#color_template = 'insert'

"------------------------------------------------------------------------------
" PLUGIN: vim-nerdtree-syntax-highlighting
"------------------------------------------------------------------------------
set guifont=Hasklug\ Nerd\ Font\ 11

"I borrowed this crazy code from vim-tomorrow-theme colorschemes

" Returns an approximate grey index for the given grey level
fun! s:grey_number(x)
  if &t_Co == 88
    if a:x < 23
      return 0
    elseif a:x < 69
      return 1
    elseif a:x < 103
      return 2
    elseif a:x < 127
      return 3
    elseif a:x < 150
      return 4
    elseif a:x < 173
      return 5
    elseif a:x < 196
      return 6
    elseif a:x < 219
      return 7
    elseif a:x < 243
      return 8
    else
      return 9
    endif
  else
    if a:x < 14
      return 0
    else
      let l:n = (a:x - 8) / 10
      let l:m = (a:x - 8) % 10
      if l:m < 5
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" Returns the actual grey level represented by the grey index
fun! s:grey_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 46
    elseif a:n == 2
      return 92
    elseif a:n == 3
      return 115
    elseif a:n == 4
      return 139
    elseif a:n == 5
      return 162
    elseif a:n == 6
      return 185
    elseif a:n == 7
      return 208
    elseif a:n == 8
      return 231
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 8 + (a:n * 10)
    endif
  endif
endfun

" Returns the palette index for the given grey index
fun! s:grey_colour(n)
  if &t_Co == 88
    if a:n == 0
      return 16
    elseif a:n == 9
      return 79
    else
      return 79 + a:n
    endif
  else
    if a:n == 0
      return 16
    elseif a:n == 25
      return 231
    else
      return 231 + a:n
    endif
  endif
endfun

" Returns an approximate colour index for the given colour level
fun! s:rgb_number(x)
  if &t_Co == 88
    if a:x < 69
      return 0
    elseif a:x < 172
      return 1
    elseif a:x < 230
      return 2
    else
      return 3
    endif
  else
    if a:x < 75
      return 0
    else
      let l:n = (a:x - 55) / 40
      let l:m = (a:x - 55) % 40
      if l:m < 20
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" Returns the actual colour level for the given colour index
fun! s:rgb_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 139
    elseif a:n == 2
      return 205
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 55 + (a:n * 40)
    endif
  endif
endfun

" Returns the palette index for the given R/G/B colour indices
fun! s:rgb_colour(x, y, z)
  if &t_Co == 88
    return 16 + (a:x * 16) + (a:y * 4) + a:z
  else
    return 16 + (a:x * 36) + (a:y * 6) + a:z
  endif
endfun

" Returns the palette index to approximate the given R/G/B colour levels
fun! s:colour(r, g, b)
  " Get the closest grey
  let l:gx = s:grey_number(a:r)
  let l:gy = s:grey_number(a:g)
  let l:gz = s:grey_number(a:b)

  " Get the closest colour
  let l:x = s:rgb_number(a:r)
  let l:y = s:rgb_number(a:g)
  let l:z = s:rgb_number(a:b)

  if l:gx == l:gy && l:gy == l:gz
    " There are two possibilities
    let l:dgr = s:grey_level(l:gx) - a:r
    let l:dgg = s:grey_level(l:gy) - a:g
    let l:dgb = s:grey_level(l:gz) - a:b
    let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
    let l:dr = s:rgb_level(l:gx) - a:r
    let l:dg = s:rgb_level(l:gy) - a:g
    let l:db = s:rgb_level(l:gz) - a:b
    let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
    if l:dgrey < l:drgb
      " Use the grey
      return s:grey_colour(l:gx)
    else
      " Use the colour
      return s:rgb_colour(l:x, l:y, l:z)
    endif
  else
    " Only one possibility
    return s:rgb_colour(l:x, l:y, l:z)
  endif
endfun

" Returns the palette index to approximate the 'rrggbb' hex string
fun! s:rgb(rgb)
  let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
  let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
  let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

  return s:colour(l:r, l:g, l:b)
endfun

" Sets the highlighting for the given group
fun! s:X(group, fg, bg, attr)
  if a:fg != ""
    exec "silent hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . s:rgb(a:fg)
  endif
  if a:bg != ""
    exec "silent hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . s:rgb(a:bg)
  endif
  if a:attr != ""
    exec "silent hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun

"the original values would be 24 bit color but apparently that is not possible
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"

let s:file_extension_colors = {
  \ 'styl'     : s:green,
  \ 'scss'     : s:pink,
  \ 'htm'      : s:darkOrange,
  \ 'html'     : s:darkOrange,
  \ 'erb'      : s:red,
  \ 'slim'     : s:orange,
  \ 'ejs'      : s:yellow,
  \ 'css'      : s:blue,
  \ 'less'     : s:darkBlue,
  \ 'md'       : s:yellow,
  \ 'markdown' : s:yellow,
  \ 'json'     : s:beige,
  \ 'js'       : s:beige,
  \ 'jsx'      : s:blue,
  \ 'rb'       : s:red,
  \ 'php'      : s:purple,
  \ 'py'       : s:yellow,
  \ 'pyc'      : s:yellow,
  \ 'pyo'      : s:yellow,
  \ 'pyd'      : s:yellow,
  \ 'coffee'   : s:brown,
  \ 'mustache' : s:orange,
  \ 'hbs'      : s:orange,
  \ 'conf'     : s:white,
  \ 'ini'      : s:white,
  \ 'yml'      : s:white,
  \ 'bat'      : s:white,
  \ 'jpg'      : s:aqua,
  \ 'jpeg'     : s:aqua,
  \ 'bmp'      : s:aqua,
  \ 'png'      : s:aqua,
  \ 'gif'      : s:aqua,
  \ 'ico'      : s:aqua,
  \ 'twig'     : s:green,
  \ 'cpp'      : s:blue,
  \ 'c++'      : s:blue,
  \ 'cxx'      : s:blue,
  \ 'cc'       : s:blue,
  \ 'cp'       : s:blue,
  \ 'c'        : s:blue,
  \ 'hs'       : s:beige,
  \ 'lhs'      : s:beige,
  \ 'lua'      : s:purple,
  \ 'java'     : s:purple,
  \ 'sh'       : s:lightPurple,
  \ 'fish'     : s:green,
  \ 'ml'       : s:yellow,
  \ 'mli'      : s:yellow,
  \ 'diff'     : s:white,
  \ 'db'       : s:blue,
  \ 'sql'      : s:darkBlue,
  \ 'dump'     : s:blue,
  \ 'clj'      : s:green,
  \ 'cljc'     : s:green,
  \ 'cljs'     : s:green,
  \ 'edn'      : s:green,
  \ 'scala'    : s:red,
  \ 'go'       : s:beige,
  \ 'dart'     : s:blue,
  \ 'xul'      : s:darkOrange,
  \ 'sln'      : s:purple,
  \ 'suo'      : s:purple,
  \ 'pl'       : s:blue,
  \ 'pm'       : s:blue,
  \ 't'        : s:blue,
  \ 'rss'      : s:darkOrange,
  \ 'f#'       : s:darkBlue,
  \ 'fsscript' : s:blue,
  \ 'fsx'      : s:blue,
  \ 'fs'       : s:blue,
  \ 'fsi'      : s:blue,
  \ 'rs'       : s:darkOrange,
  \ 'rlib'     : s:darkOrange,
  \ 'd'        : s:red,
  \ 'erl'      : s:lightPurple,
  \ 'hrl'      : s:pink,
  \ 'vim'      : s:green,
  \ 'ai'       : s:darkOrange,
  \ 'psd'      : s:darkBlue,
  \ 'psb'      : s:darkBlue,
  \ 'ts'       : s:blue,
  \ 'jl'       : s:purple
\}

let s:file_node_exact_matches = {
  \ 'gruntfile.coffee'                 : s:yellow,
  \ 'gruntfile.js'                     : s:yellow,
  \ 'gruntfile.ls'                     : s:yellow,
  \ 'gulpfile.coffee'                  : s:pink,
  \ 'gulpfile.js'                      : s:pink,
  \ 'gulpfile.ls'                      : s:pink,
  \ 'dropbox'                          : s:blue,
  \ '.ds_store'                        : s:white,
  \ '.gitconfig'                       : s:white,
  \ '.gitignore'                       : s:white,
  \ '.bashrc'                          : s:white,
  \ '.bashprofile'                     : s:white,
  \ 'favicon.ico'                      : s:yellow,
  \ 'license'                          : s:white,
  \ 'node_modules'                     : s:green,
  \ 'react.jsx'                        : s:blue,
  \ 'procfile'                         : s:purple,
\}

let s:file_node_pattern_matches = {
  \ '.*jquery.*\.js$'       : s:blue,
  \ '.*angular.*\.js$'      : s:red,
  \ '.*backbone.*\.js$'     : s:darkBlue,
  \ '.*require.*\.js$'      : s:blue,
  \ '.*materialize.*\.js$'  : s:salmon,
  \ '.*materialize.*\.css$' : s:salmon,
  \ '.*mootools.*\.js$'     : s:white
\}

let s:enabled_extensions = [
  \ 'bmp',
  \ 'c',
  \ 'coffee',
  \ 'cpp',
  \ 'css',
  \ 'erb',
  \ 'go',
  \ 'hs',
  \ 'html',
  \ 'java',
  \ 'jpg',
  \ 'js',
  \ 'json',
  \ 'jsx',
  \ 'less',
  \ 'lua',
  \ 'markdown',
  \ 'md',
  \ 'php',
  \ 'png',
  \ 'pl',
  \ 'py',
  \ 'rb',
  \ 'rs',
  \ 'scala',
  \ 'scss',
  \ 'sh',
  \ 'sql',
  \ 'vim',
\]

if !exists('g:NERDTreeSyntaxEnabledExtensions')
  let g:NERDTreeSyntaxEnabledExtensions = []
endif

if exists('g:NERDTreeLimitedSyntax') && !exists('g:NERDTreeSyntaxDisableDefaultExtensions')
  for extension in s:enabled_extensions
    call add(g:NERDTreeSyntaxEnabledExtensions, extension)
  endfor
endif

let s:characters = '[a-zA-Z0-9_\#\-\+\*\%\!\~\(\)\{\}\&\.\$\@]'
" substitute will 'eat' single backlashes on the string
let s:chars_double_lashes = substitute(s:characters, '\\', '\\\\', 'g')

" Extension colors

if !exists('g:NERDTreeExtensionHighlightColor')
  let g:NERDTreeExtensionHighlightColor = {}
endif

for [key, val] in items(s:file_extension_colors)
  if ((exists('g:NERDTreeLimitedSyntax') ||
        \ exists('g:NERDTreeSyntaxDisableDefaultExtensions')) ?
        \ index(g:NERDTreeSyntaxEnabledExtensions, key) >= 0 :
        \ !has_key(g:NERDTreeExtensionHighlightColor, key))
    let g:NERDTreeExtensionHighlightColor[key] = val
  endif
endfor


for [key, val] in items(g:NERDTreeExtensionHighlightColor)
  let label_identifier = 'nerdtreeFileExtensionLabel_'.key
  let icon_identifier = 'nerdtreeFileExtensionIcon_'.key
  let regexp = '\v'.s:characters.'+\.'.substitute(key, '\W', '\\\0', 'g')

  exec 'silent syn match '.label_identifier.' "'.regexp.'$" containedin=NERDTreeFile'
  exec 'silent syn match '.label_identifier.' "'.regexp.'\*$" containedin=NERDTreeExecFile'
  exec 'hi def link '.label_identifier.' NERDTreeFile'

  if exists('g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["'.key.'"]')
    let icon = g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[key]
    exec 'silent syn match '.icon_identifier.' "\zs['.icon.']\ze.\+\.'.key.'$" containedin=NERDTreeFile'
    exec 'silent syn match '.icon_identifier.' "\zs['.icon.']\ze.\+\.'.key.'\*$" containedin=NERDTreeExecFile'
    exec 'hi def link '.icon_identifier.' '.label_identifier
  endif

  if !exists('g:NERDTreeDisableFileExtensionHighlight') && val != ''
    call s:X(icon_identifier, val, '', '')
    if exists('g:NERDTreeFileExtensionHighlightFullName')
      call s:X(label_identifier, val, '', '')
    endif
  endif
endfor

"Exact Matches

if !exists('g:NERDTreeExactMatchHighlightColor')
  let g:NERDTreeExactMatchHighlightColor = {}
endif

for [key, val] in items(s:file_node_exact_matches)
  if !has_key(g:NERDTreeExactMatchHighlightColor, key)
    let g:NERDTreeExactMatchHighlightColor[key] = val
  endif
endfor

for [key, val] in items(g:NERDTreeExactMatchHighlightColor)
  let label_identifier = 'nerdtreeExactMatchLabel_'.key
  let icon_identifier = 'nerdtreeExactMatchIcon_'.key
  let folder_identifier = 'nerdtreeExactMatchFolder_'.key
  let folder_icon_identifier = 'nerdtreeExactMatchFolderIcon_'.key
  exec 'silent syn match '.label_identifier.' "\c'.key.'$" containedin=NERDTreeFile'
  exec 'silent syn match '.label_identifier.' "\c'.key.'\*$" containedin=NERDTreeExecFile'
  exec 'hi def link '.label_identifier.' NERDTreeFile'
  exec 'silent syn match '.folder_identifier.' "\v\c<'.key.'\ze\/" containedin=NERDTreeDir'
  exec 'hi def link '.folder_identifier.' NERDTreeDir'
  if exists('g:WebDevIconsUnicodeDecorateFileNodesExactSymbols["'.key.'"]')
    let icon = g:WebDevIconsUnicodeDecorateFileNodesExactSymbols[key]
    exec 'silent syn match '.icon_identifier.' "\c['.icon.']\ze.*'.key.'$" containedin=NERDTreeFile'
    exec 'silent syn match '.icon_identifier.' "\c['.icon.']\ze.*'.key.'\*$" containedin=NERDTreeExecFile'
    exec 'hi def link '.icon_identifier.' '.label_identifier
    exec 'silent syn match '.folder_icon_identifier.' "\c['.icon.']\ze.*'.key.'\/" containedin=NERDTreeDir'
    exec 'hi def link '.folder_icon_identifier.' '.folder_identifier
  endif

  if !exists('g:NERDTreeDisableExactMatchHighlight') && val != ''
    call s:X(icon_identifier, val, '', '')
    if exists('g:NERDTreeExactMatchHighlightFullName')
      call s:X(label_identifier, val, '', '')
    endif
    if exists('g:NERDTreeHighlightFolders')
      call s:X(folder_icon_identifier, val, '', '')
      if exists('g:NERDTreeHighlightFoldersFullName')
        call s:X(folder_identifier, val, '', '')
      endif
    endif
  endif
endfor

"Pattern Matches

if !exists('g:NERDTreePatternMatchHighlightColor')
  let g:NERDTreePatternMatchHighlightColor = {}
endif

for [key, val] in items(s:file_node_pattern_matches)
  if !has_key(g:NERDTreePatternMatchHighlightColor, key)
    let g:NERDTreePatternMatchHighlightColor[key] = val
  endif
endfor

for [key, val] in items(g:NERDTreePatternMatchHighlightColor)
  let suffix = substitute(key, '\W', '', 'g')
  let label_identifier = 'nerdtreePatternMatchLabel_'.suffix
  let icon_identifier = 'nerdtreePatternMatchIcon_'.suffix
  let sub_regexp = substitute(key, '\v\\@<!\.', s:chars_double_lashes, 'g')
  let exec_sub_regexp = substitute(sub_regexp, '\$$', '\\*$', '')

  exec 'syn match '.label_identifier.' "\v\c'.sub_regexp.'" containedin=NERDTreeFile'
  exec 'syn match '.label_identifier.' "\v\c'.exec_sub_regexp.'" containedin=NERDTreeFile'
  " TODO: handle executable file
  exec 'hi def link '.label_identifier.' NERDTreeFile'

  if exists("g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['".key."']")
    let icon = g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols[key]
    exec 'syn match '.icon_identifier.' "\v\c\zs['.icon.']\ze.*'.sub_regexp.'" containedin=NERDTreeFile'
    exec 'hi def link '.icon_identifier.' '.label_identifier
  endif

  if !exists('g:NERDTreeDisablePatternMatchHighlight') && val != ''
    call s:X(icon_identifier, val, '', '')
    if exists('g:NERDTreePatternMatchHighlightFullName')
      call s:X(label_identifier, val, '', '')
    endif
  endif
endfor

let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

"------------------------------------------------------------------------------
" General Vim settings
"------------------------------------------------------------------------------  

set cursorline
set laststatus=2
set number
set numberwidth=5
set showmode
set showcmd
set showmatch
set splitbelow splitright
set title
set scrolloff=5
set sidescrolloff=7
set sidescroll=1

" Add some meaningful file information to the title bar "
if has('title') && (has('gui_running') || &title)
	set titlestring=
	set titlestring+=%f
	set titlestring+=%h%m%r%w
	set titlestring+=\ -\ %{v:progname}
	set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
endif

" Use relative line numbers by default "
"if exists('+relativenumber')
"	set relativenumber
"endif

" Set command completion "
set wildmenu
set wildchar=<TAB>
set wildmode=list:longest
set wildignore+=*.DS_STORE,*.db,node_modules/**,*.jpg,*.png,*.gif

" Indentations and Text-Wrap "
set autoindent smartindent
set copyindent
set softtabstop=2
set tabstop=4
set shiftwidth=4
set smarttab
set textwidth=1000
