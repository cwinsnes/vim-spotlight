if exists('g:spotlight_loaded')
    finish
endif

let g:spotlight_loaded = 1

call spotlight#setspotlightcolor()

if has('autocmd')
    augroup spotlight
        autocmd!
        autocmd ColorScheme * call spotlight#setspotlightcolor()
        autocmd WinLeave * call spotlight#timerkill()
        autocmd WinEnter * call spotlight#spotlight()
    augroup END
endif

command! -nargs=0 Spotlight call spotlight#spotlight()
