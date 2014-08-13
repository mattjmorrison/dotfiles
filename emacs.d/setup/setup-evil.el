(require 'evil)
(global-evil-leader-mode)                                 ; This must be called before calling 'evil-mode
(evil-mode 1)

;;====
;; Vim like leader keys
;;====
(setq evil-leader/leader "9" evil-leader/in-all-states t) ; Call before require 'evil-leader
(require 'evil-leader)
(evil-leader/set-key "\\" 'split-window-horizontally)     ; (DEFAULT Emacs): Emacs has this backwards for some reason
(evil-leader/set-key "-" 'split-window-vertically)        ; (DEFAULT Emacs): Again with the backwards Emacs sigh...
(evil-leader/set-key "b" 'buffer-menu)                    ; (DEFAULT Emacs): Choose from list of open buffers
(evil-leader/set-key "no" 'dired)                         ; (DEFAULT Emacs): Open dired defaults to current directory
(evil-leader/set-key "ac" 'auto-complete-mode)            ; (REQUIRES auto-complete): Toggle auto complete mode
(evil-leader/set-key "ff" 'fiplr-find-file)               ; (REQUIRES fiplr): Fuzzy file search
(evil-leader/set-key "fc" 'fiplr-clear-cache)             ; (REQUIRES fiplr): Clear fiplr fuzzy find cache
(evil-leader/set-key "x" 'smex)                           ; (REQURES smex): Leader x now works like M-x
(evil-leader/set-key "a" 'ack)                            ; (REQURES Ack-and-a-half): Good old ack

(provide 'setup-evil)
