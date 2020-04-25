# Vim Spotlight

Highlights the current cursor line for a short time when switching windows
within vim! This plugin is intended to make it easier to find your cursor
when switching windows.

Vim-spotlight requires vim to be compiled with `+timers`.

## Installation
You can install the plugin using your favorite plugin manager. I personally
like [Vim-plug](https://github.com/junegunn/vim-plug) in which case you would
add the following line to your `vimrc`.
```viml 
Plug 'cwinsnes/vim-spotlight'
```

and then run `:PlugInstall`.

## Configuration
The default spotlight time is 200ms. You can control this by the setting `g:Spotlight_time`. 
```viml
" Time in milliseconds. Default 200
let g:Spotlight_time=200
```

The default spotlight color is black text with white background. You can
control this by setting the highlight group.
```viml
highlight SpotlightColor cterm=NONE ctermbg=white ctermfg=black guibg=white guifg=black
```

You can blacklist filetypes which you do not want to get spotlighted when
entering.
```viml
" A list of blacklisted filetypes. Defaults to []
let g:SpotlightBlacklist=['nerdtree']
```
