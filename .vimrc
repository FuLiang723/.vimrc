syntax on 
set ruler
set nocompatible
set bs=2
set hlsearch
set nomodeline
set showmatch
set nu

function! Mosh_Tab_Or_Complete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
endfunction

:inoremap <Tab> <C-R>=Mosh_Tab_Or_Complete()<CR>

if has("autocmd")
  autocmd FileType php set complete+=k~/.vim/PHP.dict
endif

set expandtab
set tabstop=4
:retab
set shiftwidth=4

    
