setlocal et ts=4 sts=4 sw=4 cc=81
inoremap """<CR> """<CR><CR>"""<Esc>kO
autocmd BufWritePost <buffer> execute ':!black %'
