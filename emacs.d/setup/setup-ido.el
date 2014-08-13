(require 'ido-vertical-mode)

(dolist (mode
         '(ido-mode                   ; Interactivly do
           ido-everywhere             ; Use Ido for all buffer/file reading
           ido-vertical-mode))        ; Makes ido-mode display vertically
  (funcall mode 1))

(provide 'setup-ido)
