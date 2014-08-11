(require 'dired)

;;====
; Also auto refresh dired, but be quiet about it
;;====
(setq-default dired-auto-revert-buffer t)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;;====
; Listing options
;;====
(setq dired-listing-switches "-alhv --group-directories-first")


(require 'dired-details)
;;====
;; Toggle file details with TAB
;;====
(setq-default dired-details-hidden-string "..> ")
(define-key dired-mode-map (kbd "TAB") 'dired-details-toggle)

;;====
;; Hide dot files with M-o
;;====
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))

(provide 'setup-dired)
