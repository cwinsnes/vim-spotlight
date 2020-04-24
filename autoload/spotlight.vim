let s:prevcolor={}
let s:prevcursorline=""
let s:enabled=1

let g:SpotlightTime=get(g:, 'Spotlight_time', 500)

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

function! spotlight#shouldspot()
  if !s:enabled
    return 0
  endif

  if !exists('g:SpotlightBlacklist')
    let g:SpotlightBlacklist=['']
  endif

  return index(g:SpotlightBlacklist, &filetype) < 0
endfunction

function! spotlight#removespotlight(timer)
  let &cursorline=s:prevcursorline
  for item in keys(s:prevcolor)
    execute('hi CursorLine ' . item . '=' . s:prevcolor[item])
  endfor
endfunction

function! spotlight#spotlight()
  if !spotlight#shouldspot()
    return
  endif
  let s:prevcolor=spotlight#gethighlight('CursorLine')
  let s:prevcursorline=&cursorline
  hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
  set cursorline
  let timer = timer_start(g:SpotlightTime, 'spotlight#removespotlight')
endfunction

autocmd! BufEnter * call spotlight#spotlight()
