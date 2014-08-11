;;;====================================
; Global Key cords
;;;====================================
(require 'key-chord)
(setq key-chord-two-keys-delay 0.5)

;;;====
; Spell check keys
;;;====
(key-chord-define evil-normal-state-map "ss" 'flyspell-buffer)                          ; Spell check the buffer
(key-chord-define evil-normal-state-map "sm" 'flyspell-mode)                            ; Use this to toggle spell check off
(key-chord-define evil-normal-state-map "s]" 'flyspell-goto-next-error)                 ; Next misspelled word
(key-chord-define evil-normal-state-map "s[" 'flyspell-check-previous-highlighted-word) ; Previous misspelled word
(key-chord-define evil-normal-state-map "z=" 'ispell-word)                              ; Correct word under cursor
;;====
; Code folding keys
;;====
(key-chord-define evil-normal-state-map "zR" 'hs-hide-all)                              ; Fold the entire buffer
(key-chord-define evil-normal-state-map "zc" 'hs-hide-block)                            ; Fold the current section
(key-chord-define evil-normal-state-map "zo" 'hs-show-block)                            ; Show the current section
(key-chord-define evil-normal-state-map "zM" 'hs-show-all)                              ; Show the entire buffer
;;====
; Window movement - These work in all modes (eg. Insert, normal, etc)
;;====
(global-set-key (kbd "C-l") 'windmove-right)                                            ; Move cursor to window to the right
(global-set-key (kbd "C-h") 'windmove-left)                                             ; Move cursor to window to the left
(global-set-key (kbd "C-j") 'windmove-down)                                             ; Move cursor to window to the below
(global-set-key (kbd "C-k") 'windmove-up)                                               ; Move cursor to window to the above

(key-chord-mode 1)

(provide 'setup-key-chords)
