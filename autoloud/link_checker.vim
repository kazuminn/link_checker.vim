let s:save_cpo = &cpo
set cpo&vim

function! GetFromLinkTagList(path)
    let l:list = []
    for line in readfile(a:path)
        call add(l:list,matchstr(line,'|\S\{-}|'))
    endfor
    return l:list
endfunction


function! GetToLinkTagList(path)
    let l:list = []
    for line in readfile(a:path)
        call add(l:list, matchstr(line,'\*\S\{-}\*'))
    endfor
    return l:list
endfunction


function! Matcher(path)
    let fromLinkTagList = GetFromLinkTagList(a:path)
    let toLinkTagList = GetToLinkTagList(a:path)

    let key = 0 "見つからない前提
    let match_list = []

    for char in toLinkTagList
        if match(fromLinkTagList,char)
            call add(match_list,char)
            let key = 1
        endif
    endfor

    if key == 1
        return [1,"hoge"]
    else
        return [0,"hoge"]
    endif
endfunction


function! PathGet()
    return split(globpath(&runtimepath, "doc/*.txt"),"\n")
endfunction


function! Report(notlink,filename)
    let ret = [{'filename':a:filename,'text':a:notlink}]

    call setqflist(ret, 'a')
    copen
endfunction

"見つかったら真。1

function! Main()
    let l:paths =  PathGet()
    for path in l:paths
        let l:infomation = Matcher(path)
        if l:infomation[0] "l:infomation[0]
            call Report(l:infomation[1],path)
        endif
    endfor
endfunction

call Main()




let &cpo = s:save_cpo
unlet s:save_cpo
