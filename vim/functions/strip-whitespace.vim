"===============================================================================
" DESCRIPTION:   Removes trailing whitespace when a file is saved. Prints a
"                message when the function runs so it will not be a surprise
"===============================================================================
function! StripTrailingWhitespace()
  normal mZ
  let l:chars = col("$")
  %s/\s\+$//e
  if (line("'Z") != line(".")) || (l:chars != col("$"))
    echo "Trailing whitespace stripped\n"
  endif
  normal `Z
endfunction

autocmd BufWritePre * :call StripTrailingWhitespace()

"===============================================================================
" Function Keymappings
"===============================================================================
" N/A

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
" N/A
