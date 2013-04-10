syntax on 

set viminfo='20,\"500
set ruler
set nocompatible
set bs=2                " Allow backspacing over everything in insert mode
set hlsearch
set nomodeline
set showmatch

set nopaste
"去掉粘贴时的自动缩进
set pastetoggle=<F3>

if has('gui_running')
  "Buffer 位置
  winpos 100 500
  " Always show file types in menu
  let do_syntax_sel_menu=1

  " 因为设定为不换行，所以要显示底部滚动条，不显示左右滚动条和工具栏
  "set guioptions+=b
  "set guioptions-=r
  "set guioptions-=l
  set guioptions-=T

  " 用浅色高亮当前行
  "autocmd InsertLeave * se nocul
  "autocmd InsertEnter * se cul
  colorscheme desert
  set cursorline
endif

 """"""""""""""""""""""""""""""
  " Statusline
  """"""""""""""""""""""""""""""
  "Always hide the statusline
  "set laststatus=2
  "Format the statusline
  "set statusline=\ %F%m%r%h\ %w\ \ Dir:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 單鍵 <F7> 控制 syntax on/off。倒斜線是 Vim script 的折行標誌
" 按一次 <F7> 是 on 的話，再按一次則是 off，再按一次又是 on。
map <F7> :if exists("syntax_on") <BAR>
     \   syntax off <BAR><CR>
     \ else <BAR>
     \   syntax enable <BAR>
     \ endif <CR>
" 按 F8 會在 searching highlight 及非 highlight 間切換
map <F8> :set hls!<BAR>set hls?<CR>

" 函数，修改文件头部的最后修改时间，就象这个文件的头部一样
function! LastMod()
  if line("$") > 5
    let l = 5
  else
    let l = line("$")
  endif
  exe "1," . l . "s/[Ll]ast [Mm]odified: .*/Last modified: " . strftime("%c") . " [" . hostname() . "]/e"
endfunction

" 手工更新文件最后修改时间
map ,L :call LastMod()<CR>

"用Tab自动完成
function! Mosh_Tab_Or_Complete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
endfunction

:inoremap <Tab> <C-R>=Mosh_Tab_Or_Complete()<CR>

if has("autocmd")
  autocmd FileType php set complete+=k~/.vim/phpdiction
endif

if has("autocmd")

augroup gentoo
  au!

  " In text files, limit the width of text to 78 characters, but be careful
  " that we don't override the user's setting.
  autocmd BufNewFile,BufRead *.txt
        \ if &tw == 0 && ! exists("g:leave_my_textwidth_alone") |
        \     setlocal textwidth=78 |
        \ endif

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
        \ if ! exists("g:leave_my_cursor_position_alone") |
        \     if line("'\"") > 0 && line ("'\"") <= line("$") |
        \         exe "normal g'\"" |
        \     endif |
        \ endif

  " When editing a crontab file, set backupcopy to yes rather than auto. See
  " :help crontab and bug #53437.
  autocmd FileType crontab set backupcopy=yes

augroup END

endif " has("autocmd")

"用空格替换Tab
set expandtab
set tabstop=4
:retab
set shiftwidth=4
