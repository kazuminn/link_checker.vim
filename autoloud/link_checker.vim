let s:save_cpo = &cpo
set cpo&vim

"echo globpath(&runtimepath, "doc/*.txt")

for path in split(globpath(&runtimepath, "doc/*.txt"),"\n")
    vimgrep |.*| /Users/kinoshita/.vim/bundle/open-browser.vim/doc/openbrowser.txt
endfor



"let s:paths = map(s:paths,'v:val."doc"')
"echo s:paths
function! s:Parser()
endfunction
"
"for line in s:paths
"    Parser(line)
"endfor


let &cpo = s:save_cpo
unlet s:save_cpo
