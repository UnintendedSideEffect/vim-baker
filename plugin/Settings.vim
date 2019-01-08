
let g:Baker_MakefileNames = get(g:, 'Baker_MakefileNames',
            \['GNUmakefile', 'makefile', 'Makefile'])

let g:Baker_MakefileLookupPath = get(g:, 'Baker_MakefileLookupPath', './')

let g:Baker_CompleteDirectories = get(g:, 'Baker_CompleteDirectories', 1)


augroup Baker_UpdateCacheOnMakefileChange
    autocmd!
    autocmd FileWritePost,BufWritePost *
            \   if MakefileFinder#IsMakefile(expand('%'))
            \ |     call MakefileCache#Add(Makefile#Parse(expand('%')))
            \ | endif
augroup END
