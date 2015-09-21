let s:save_cpo = &cpo
set cpo&vim

function! Report()
    echo "hoge"
endfunction

function! Matcher(inputfile)
    for line in readfile(a:inputfile)
        let link = matchstr(line,'|\S\{-}|')
        for line2 in readfile(a:inputfile)
            if match(line2, line)
            else
                call Report()
            endif
        endfor
    endfor
endfunction


function! PathGet()
    return split(globpath(&runtimepath, "doc/*.txt"),"\n")
endfunction


function! Main()
    let l:paths =  PathGet()
    for path in l:paths
        call Matcher(path)
    endfor
endfunction

call Main()




let &cpo = s:save_cpo
unlet s:save_cpo
