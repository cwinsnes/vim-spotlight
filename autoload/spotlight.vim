let s:prevcolor={}
let s:prevcursorline=""

let g:Spotlight_time=get(g:, 'Spotlight_time', 500)

function! spotlight#gethighlight(group)
  let output = execute('hi ' . a:group)
  let list = split(output, '\s\+')
  let dict = {}
  for item in list
    if match(item, '=') > 0
      let splited = split(item, '=')
      let dict[splited[0]] = splited[1]
    endif
  endfor
  return dict
endfunction

function! spotlight#removespotlight(timer)
    let &cursorline=s:prevcursorline
    for item in keys(s:prevcolor)
      execute('hi CursorLine ' . item . '=' . s:prevcolor[item])
    endfor
endfunction

function! spotlight#spotlight()
    let s:prevcolor=spotlight#gethighlight('CursorLine')
    let s:prevcursorline=&cursorline
    hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
    set cursorline
    let timer = timer_start(g:Spotlight_time, 'spotlight#removespotlight')
endfunction

autocmd! BufEnter * call spotlight#spotlight()
