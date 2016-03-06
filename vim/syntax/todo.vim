syntax match TodoCheck "√"
syn region TodoDone start='\v\[√]' end='$' contains=TodoCheck
hi TodoCheck ctermfg=29
hi TodoDone ctermfg=236
