" *quickref*
unlet! skip_defaults_vim " *defaults.vim*
ru defaults.vim
ru ftplugin/man.vim
pa! matchit

se pa+=** " *'pa'* *file-searching*
au BufWinEnter * se rnu nu
let g:netrw_bufsettings="noma nomod nu nobl nowrap ro rnu" " *netrw-P19*

se cpo+=$ " *cpo-$*
se vb t_vb= " *'vb'*
se wim=longest:full
se kp=:help
se ic scs
se cc=80
se sm
se shm=at

nn <silent> <leader>w :up<cr>
nn <silent> <C-w>Q :qa<cr>
map ' `
nn <silent> <leader>o :bro ol<cr>
nn <silent> <leader>v :cd ~/.vim<cr>
nn <silent> <leader>v :cd ~/.dotfiles<cr>

" https://github.com/jszakmeister/vim-togglecursor/blob/master/plugin/togglecursor.vim#L34
" https://stackoverflow.com/a/6489348
let &t_SI.="\e[6 q"
let &t_EI.="\e[0 q"

" cl / cc
nn S <nop>
nn s <nop>
" A<cr> / I<cr>
nn O <nop>
nn o q:
" dl / dh
nn X <nop>
nn x <nop>
nn ? q/
nn Y y$

nn jj L " https://stackoverflow.com/a/23489147
nn kk H
nn ww f
nn bb F

let g:Signs_IndentationLevel = 1
let g:Signs_MixedIndentation = 1
let g:Signs_Bookmarks = 1
let g:Signs_QFList = 1
let g:Signs_Diff = 1
let g:Signs_Scrollbar = 1
let g:Signs_Alternate = 0
hi SignColumn NONE
hi link LineOdd NONE
hi LineEven ctermbg = 255

" https://stackoverflow.com/a/559052 + *interrupt()*
fu My_Signs()
	if line("$") < 1000
		DisableSigns
		Signs
	endif
endf

fu SignsToggle()
	if g:Signs_Alternate
		let g:Signs_Alternate = 0
	else
		let g:Signs_Alternate = 1
	endif
endf

au BufWinEnter * call My_Signs()
nn <silent> <leader><leader> :call My_Signs()<cr>
nn <silent> <leader>- :call SignsToggle()<cr>

hi link QuickScopePrimary IncSearch
