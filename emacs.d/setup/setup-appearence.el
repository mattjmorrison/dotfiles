;;====
;; y or n instead of yes or no in the prompts
;;====
(fset 'yes-or-no-p 'y-or-n-p)

;;====
;; Remove scrollbars
;;====
(toggle-scroll-bar -1)

;;====
;; Turn off line wrapping
;;====
(setq-default truncate-lines t)

;;====
;; Don't show the startup screen
;;====
(setq-default inhibit-startup-screen t)

;;====
;; Hide the toolbar
;;====
(tool-bar-mode 0)

;;====
;; Font settings
;;====
(set-face-attribute 'default nil :font "Monospace-12")

;;====
;; Highlight active line
;;====
(global-hl-line-mode t)

;;====
;; Window Title: For buffers visiting files show the full file name in the title
;; bar, for buffers not associated with files show the buffer name.
;;====
(setq frame-title-format '(buffer-file-name "%f" ("%b")))

;;====
;; Turn on show parentheses mode so we get the matching sign highlighted
;;====
(show-paren-mode 1)
(setq show-paren-delay 0)

;;====
;; Load theme
;;====
(load-theme 'zenburn t)

(provide 'setup-appearence)
