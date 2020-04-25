let s:prevcolor={}
let s:prevcursorline=""
let s:enabled=1
let s:timer=""

let g:SpotlightTime=get(g:, 'Spotlight_time', 200)

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

function! spotlight#timerkill()
  call spotlight#removespotlight(s:timer)
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
  if s:timer
    let ignore = timer_stop(s:timer)
    let s:timer = 0
  else
    return
  endif

  let &cursorline=s:prevcursorline
  for item in keys(s:prevcolor)
    execute('hi CursorLine ' . item . '=' . s:prevcolor[item])
  endfor
  redraw
endfunction

function! spotlight#spotlight()
  if !spotlight#shouldspot()
    return
  endif
  let s:prevcolor=spotlight#gethighlight('CursorLine')
  let s:prevcursorline=&cursorline
  hi! link CursorLine SpotlightColor
  set cursorline
  let s:timer = timer_start(g:SpotlightTime, 'spotlight#removespotlight')
endfunction
