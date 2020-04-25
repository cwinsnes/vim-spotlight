if exists('g:spotlight_loaded')
    finish
endif

let g:spotlight_loaded = 1
if !hlexists('SpotlightColor')
    hi SpotlightColor cterm=NONE ctermbg=white ctermfg=black guibg=white guifg=black
endif

if has('autocmd')
    autocmd WinLeave * call spotlight#timerkill()
    autocmd WinEnter * call spotlight#spotlight()
endif

command! -nargs=0 Spotlight call spotlight#spotlight()
