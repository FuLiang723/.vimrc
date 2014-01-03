syntax on 
set ruler
set nocompatible
set bs=2
set hlsearch
set nomodeline
set showmatch
set expandtab
set tabstop=4
set shiftwidth=4
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ Dir:\ %r%{getcwd()}%h\ \ \ Line:\ %l/%L:%c
:retab

function! Mosh_Tab_Or_Complete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
endfunction

:inoremap <Tab> <C-R>=Mosh_Tab_Or_Complete()<CR>

if has("autocmd")
  autocmd FileType php set complete+=k~/.vim/phpdict
endif
