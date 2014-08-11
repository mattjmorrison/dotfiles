;;====
; List of directories and files to ignore
;;====
(setq fiplr-ignored-globs '((directories (".git" "node_modules"))
                            (files ("*.pyc" "*.zip"))))

(provide 'setup-fiplr)
