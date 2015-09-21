let s:save_cpo = &cpo
set cpo&vim

function! Report()
    echo "hoge"
endfunction

function! GetFromLinkTagList(path)
    let l:list = []
    for line in readfile(a:path)
        call add(list, matchstr(matchstr(line,'|\S\{-}|'),'\w.*\w'))
    endfor
    return l:list
endfunction


function! GetToLinkTagList(path)
    let l:list = []
    for line in readfile(a:path)
        call add(list, matchstr(matchstr(line,'\*\S\{-}\*'),'\w.*\w'))
    endfor
    return l:list
endfunction


function! Matcher(path)
    let fromLinkTagList = GetFromLinkTagList(a:path)
    let toLinkTagList = GetToLinkTagList(a:path)

    for char in toLinkTagList
        if match(fromLinkTagList,char)
            return 0
        else
            return 1
        endif
    endfor

endfunction


function! PathGet()
    return split(globpath(&runtimepath, "doc/*.txt"),"\n")
endfunction


function! Main()
    let l:paths =  PathGet()
    for path in l:paths
        if  Matcher(path)
            call Report()
        endif
    endfor
endfunction

call Main()




let &cpo = s:save_cpo
unlet s:save_cpo
