let s:save_cpo = &cpo
set cpo&vim

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
            let match_list= matchstr(fromLinkTagList,char)
            return [0,match_list]
        else
            return 1
        endif
    endfor

endfunction


function! PathGet()
    return split(globpath(&runtimepath, "doc/*.txt"),"\n")
endfunction



function! Report(notlink,filename)
    let ret = [{'filename':a:filename,'text':"hoge"}]

    call setqflist(ret, 'a')
    copen
endfunction



function! Main()
    let l:paths =  PathGet()
    for path in l:paths
        let l:infomation = Matcher(path)
        if 0 "l:infomation[0]
        else
            call Report(l:infomation[1],path)
        endif

    endfor
endfunction

call Main()




let &cpo = s:save_cpo
unlet s:save_cpo
