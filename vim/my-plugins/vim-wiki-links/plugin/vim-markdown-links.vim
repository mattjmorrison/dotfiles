function! s:initVariable(var, value)
    if !exists(a:var)
        exec 'let ' . a:var . ' = ' . "'" . a:value . "'"
        return 1
    endif
    return 0
endfunction

"Initialize variables
call s:initVariable("g:wikilinkAutosplit", "on")
call s:initVariable("g:wikilinkOnEnter", "on")
call s:initVariable("s:startWord", '[[')
call s:initVariable("s:endWord", ']]')
call s:initVariable("s:sepWord", '|')

function! WikiLinkGetWord()
  let word = ''
  "Get string between <startWord> and <endWord>
  let origPos = getpos('.')
  let endPos = searchpos(s:endWord, 'W', line('.'))
  let startPos = searchpos(s:startWord, 'bW', line('.'))
  let ok = cursor(origPos[1], origPos[2]) "Return to the original position

  if (startPos[1] < origPos[2])
    let ll = getline(line('.'))
    let word = strpart(ll, startPos[1] + 1, endPos[1] - startPos[1] - 2)
  endif

  if !empty(word)
    "Only return the link part
    if word =~ s:sepWord
      let word = split(word, s:sepWord)[1]
    else
      let word = split(word, s:sepWord)[0]
    endif

    "substitute spaces by dashes
    let word = substitute(word, '[ ]', '-', 'g')
  end

  return word
endfunction

function! WikiLinkWordFilename(word)
  let file_name = ''
  "Same directory and same extension as the current file
  if !empty(a:word)
    let cur_file_name = bufname("%")
    let dir = fnamemodify(cur_file_name, ":h")
    if !empty(dir)
      if (dir == ".")
        let dir = ""
      else
        let dir = dir."/"
      endif
    endif
    let extension = fnamemodify(cur_file_name, ":e")
    let file_name = dir.a:word.".".extension
  endif
  return file_name
endfunction

function! WikiLinkGotoLink()
  let link = WikiLinkWordFilename(WikiLinkGetWord())
  if !empty(link)
    "Search in subdirectories
    let mypath =  fnamemodify(bufname("%"), ":p:h")."/**"
    let existing_link = findfile(link, mypath)
    if !empty(existing_link)
      let link = existing_link
    endif
    exec "edit " . link
  endif
endfunction

"search file in the current directory and its ancestors
function! WikiLinkFindFile(afile)
  let afile = fnamemodify(a:afile, ":p")
  if filereadable(afile)
    return afile
  else
    let filename = fnamemodify(afile, ":t")
    let file_parentdir = fnamemodify(afile, ":h:h")
    if file_parentdir == "//"
      "We've reached the root, no more parents
      return ""
    else
      return WikiLinkFindFile(file_parentdir . "/" . filename)
    endif
  endif
endfunction

function! WikiLinkDetectFile(word)
  return WikiLinkFindFile(WikiLinkWordFilename(a:word))
endfunction

command! WikiLinkGotoLink call WikiLinkGotoLink()
nnoremap <script> <Plug>WikiLinkGotoLink :WikiLinkGotoLink<CR>
if !hasmapto('<Plug>WikiLinkGotoLink')
  nmap <silent> <CR> <Plug>WikiLinkGotoLink
endif

" augroup wikilink
"   au!
"   au BufNewFile,BufRead *.asciidoc,*.creole,*.markdown,*.mdown,*.mkdn,*.mkd,*.md,*.org,*.pod,*.rdoc,*.rest.txt,*.rst.txt,*.rest,*.rst,*.textile,*.mediawiki,*.wiki
" augroup END
