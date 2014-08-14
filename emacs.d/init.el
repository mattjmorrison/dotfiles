;;==
;; Set up load path
;;==
(setq load-path
      (append
       (list
        (expand-file-name "~/.emacs.d")
        (expand-file-name "~/.emacs.d/setup"))
       load-path))

;;==
;; Keep emacs custom settings in separate file
;;==
(setq custom-file "~/.emacs.d/customize.el")
(load custom-file)

;;==
; Require common lisp primitives
; As of Emacs 24 this should be (require 'cl-lib) but for some reason doesn't work?
;;==
(require 'cl)

;;==
;; Install packages
;;==
(require 'setup-install-packages)

;;==
;; Load all custom package and editor settings
;;==
(require 'setup-gen-editor-configs)
(require 'setup-appearence)
(require 'setup-gen-editor-configs)
(require 'setup-evil)
(require 'setup-key-chords)
(require 'setup-fiplr)
(require 'setup-auto-complete)
(require 'setup-dired)
(require 'setup-ido)
(require 'setup-smex)
(require 'setup-rainbow-delimiters)
(require 'setup-smart-mode-line)
(require 'setup-elpy)
(require 'setup-flymake)
(require 'setup-ack)
(require 'setup-coffee)
(require 'setup-neotree)
(require 'setup-handlebars)
(require 'setup-markdown)
(require 'setup-helm)
