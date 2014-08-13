(elpy-enable)

;;======
; Use jedi as the backend instead of the default rope
;;======
(setq elpy-rpc-backend "jedi")

;;======
; Make Python auto indent
;;======
(add-hook 'python-mode-hook 'electric-indent-mode)

;;======
; Make Python auto indent
;;======
(setq python-indent-offset 4)

(provide 'setup-elpy)
