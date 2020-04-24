if exists('g:spotlight_loaded')
    finish
endif

let g:spotlight_loader = 1

if has('autocmd')
    autocmd!
    autocmd BufEnter * call spotlight#spotlight()
endif

command! -nargs=0 Spotlight call spotlight#spotlight()
