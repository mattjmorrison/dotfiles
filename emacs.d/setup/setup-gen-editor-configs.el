;;====
; Use only spaces (no tabs at all)
;;====
(setq-default indent-tabs-mode nil)

;;====
; Spell check: Use aspell
;;====
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=fast"))

;;====
; Load hideshow (Aka, folding) and enable it for all minor modes
;;====
(load-library "hideshow")
(add-hook 'prog-mode-hook #'hs-minor-mode)

;;====
; Stop Emacs from leaving "foo~" (backup) files all over the place.
;;====
(setq make-backup-files nil)

;;====
; Auto refresh buffers
;;====
(global-auto-revert-mode 1)

;;====
; Scroll one line at a time And turn of the freaking auto center
;;====
(setq redisplay-dont-pause t
  scroll-margin 0
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1
  auto-window-vscroll nil)

;;====
; Show keystrokes in progress
;;====
(setq echo-keystrokes 0.1)

;;====
; Auto close brackets
;;====
(electric-pair-mode 1)

(provide 'setup-gen-editor-configs)
