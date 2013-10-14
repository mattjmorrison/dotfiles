;-------------------------------------------------------------------------------
; Name:         init.el
; Purpose:      Makes emacs useful to me. I couldn't use it without it.
; Author:       Jarrod
; Notes:        Created using Emacs24
; Time-stamp:   <10-13-2013 20:05:40 (jrock)>
; Index:
; -------- #1:    -- Add plugin directories to the load path
; -------- #2:    -- Require Evil and set key bindings
; -------- #2.1   -- Global Key cords
; -------- #2.1.1 -- Spell check keys
; -------- #2.1.2 -- Code folding keys
; -------- #2.1.3 -- Window movement
; -------- #2.2   -- Global Leader keys
; -------- #2.3   -- Mode specific key maps
; -------- #2.3.1 -- Clojure keys
; -------- #2.3.2 -- Python keys
; -------- #3     -- Require packages
; -------- #3.1   -- Auto-complete
; -------- #3.2   -- Electric-pair-mode <removed>Autopair: Adds closing ([""]) etc</removed>
; -------- #3.3   -- Whitespace-mode
; -------- #3.4   -- Snippets
; -------- #3.5   -- Easily move buffer windows around
; -------- #3.6   -- Rainbow Delimiters
; -------- #3.7   -- Custom Modeline
; -------- #3.8   -- js2-mode 
; -------- #4     -- General enviro configs
; -------- #4.1   -- Font settings
; -------- #4.2   -- Highlight active line 
; -------- #4.3   -- Window Title: Full file path and the time
; -------- #4.4   -- Spell check: Use aspell
; -------- #4.5   -- Load hideshow: Enable this in each major mode config separately
; -------- #4.6   -- Insert time stamp when file is saved
; -------- #4.7   -- Scroll one line at a time And turn of the freaking auto center
; -------- #4.8   -- Keep auto customization in a separate file
; -------- #5     -- Dried Settings
; -------- #6     -- My Functions
; -------- #6.1   -- Toggle between horizontal and vertical layout of two windows.
; -------- #7     -- Color settings
; -------- #8     -- Major mode configurations
; -------- #8.1   -- CSS
; -------- #8.2   -- Clojure
; -------- #8.3   -- Org
;-------------------------------------------------------------------------------

;;------------------------------------------------------------------------------
;; #1 Sub directories: Recursively add the plugin directories to the load path.
;;    Source: http://www.emacswiki.org/emacs/LoadPath#AddSubDirectories
;;------------------------------------------------------------------------------
(let ((default-directory "~/.emacs.d/elpa/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") ; Load custom themes

;;------------------------------------------------------------------------------
;; #2 Require evil and set all key bindings
;;------------------------------------------------------------------------------
(require 'evil)
(evil-mode 1)
(require 'key-chord) ; So the key-chord mappings will work properly
;====================================
;; #2.1 Global Key cords
;====================================
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state) ; Evil Esc from insert mode
;====
; #2.1.1 Spell check keys
;====
(key-chord-define evil-normal-state-map "ss" 'flyspell-buffer)                          ; Spell check the buffer
(key-chord-define evil-normal-state-map "sm" 'flyspell-mode)                            ; Use this to toggle spell check off
(key-chord-define evil-normal-state-map "s]" 'flyspell-goto-next-error)                 ; Next misspelled word
(key-chord-define evil-normal-state-map "s[" 'flyspell-check-previous-highlighted-word) ; Previous misspelled word
(key-chord-define evil-normal-state-map "z=" 'ispell-word)                              ; Correct word under cursor
;====
; #2.1.2 Code folding keys
;====
(key-chord-define evil-normal-state-map "za" 'hs-hide-all)   ; Fold the entire buffer
(key-chord-define evil-normal-state-map "zc" 'hs-hide-block) ; Fold the current section
(key-chord-define evil-normal-state-map "zo" 'hs-show-block) ; Show the current section
(key-chord-define evil-normal-state-map "zO" 'hs-show-all)   ; Show the entire buffer
;====
; #2.1.3 Window movement - These work in all modes (eg. Insert, normal, etc)
;====
(global-set-key (kbd "C-l") 'windmove-right)                 ; Move cursor to window to the right
(global-set-key (kbd "C-h") 'windmove-left)                  ; Move cursor to window to the left
(global-set-key (kbd "C-j") 'windmove-down)                  ; Move cursor to window to the below
(global-set-key (kbd "C-k") 'windmove-up)                    ; Move cursor to window to the above

(key-chord-mode 1)

;====================================
; #2.2 Global Leader keys: Like vim these key combos work after
;                          hitting the leader key which is "9" for me
;====================================
(setq evil-leader/leader "9" evil-leader/in-all-states t) ; Call before require 'evil-leader
(require 'evil-leader)                                    ; Use the leader key for more vim like key strokes
(evil-leader/set-key "ac" 'auto-complete-mode)            ; Toggle auto complete mode
(evil-leader/set-key "ll" 'global-whitespace-mode)        ; Highlight over 80 chars, trailing white space
(evil-leader/set-key "sw" 'split-window-horizontally)     ; Split the screen horizontally
(evil-leader/set-key "sv" 'split-window-vertically)       ; Split the screen vertically
(evil-leader/set-key "b" 'ibuffer)                        ; Get list of current buffers to select from
(evil-leader/set-key "d" 'dired)                          ; Open dired defaults to current directory
(evil-leader/set-key "<up>" 'buf-move-up)                 ; Swap the current buffer with the one above
(evil-leader/set-key "<down>" 'buf-move-down)             ; Swap the current buffer with the one below
(evil-leader/set-key "<left>" 'buf-move-left)             ; Swap the current buffer with the one to the left
(evil-leader/set-key "<right>" 'buf-move-right)           ; Swap the current buffer with the one to the right
(evil-leader/set-key "<backspace>" 'org-mark-ring-goto)   ; Go to the previous file in org mode (kind of works)
(defun open-org ()
    (interactive)
    (find-file "~/Dropbox/Org/Home.org"))
(evil-leader/set-key "om" 'open-org)                      ; Open main Org mode file
(evil-leader/set-key "hs" 'hs-minor-mode)                 ; Toggle the hide show minor mode

;====================================
;; #2.3 Mode specific key maps
;====================================
;;; The syntax to customize specific modes
;(eval-after-load 'css-mode
;  '(progn
;  (key-chord-define evil-normal-state-map "es" 'split-window-right)))

;====
; #2.3.1 Clojure keys
;====
(eval-after-load 'clojure-mode 
  '(progn
  (key-chord-define evil-normal-state-map "es" 'nrepl-eval-last-expression)
  (key-chord-define evil-normal-state-map "eb" 'nrepl-eval-buffer)
  (evil-leader/set-key "ji" 'nrepl-jack-in)))

;====
; #2.3.2 Python keys
;====
(eval-after-load 'python
  '(progn
  (evil-leader/set-key "ps" 'run-python)      ; Start the python repl
  (evil-leader/set-key "pc" 'python-check)    ; Syntax check with Pylint
  ;; The line below quit working when I went back to 24
  ;(key-chord-define evil-visual-state-map "er" 'python-shell-send-region))) ; Send highlighted region to repl
  (key-chord-define evil-visual-state-map "er" 'python-send-region))) ; Send highlighted region to repl

;;------------------------------------------------------------------------------
;; #3 Require packages
;;------------------------------------------------------------------------------
;;=====
;; #3.1 Auto-complete: http://cx4a.org/software/auto-complete/manual.html
;; Key shortcut toggle: 9ac
;;=====
(require 'auto-complete-config)
;(setq ac-sources '(ac-source-filename)) ; This doesn't do anything but should
                                         ; complete the file paths in buffers
(ac-config-default)

;;=====
;; #3.2 Electric-pair-mode
;; Autopair was not working when I went back to emacs 24 this does seem to work
;; leaving the commented out code for when the evil bug is fixed in emacs 25 
;; <removed>
;; Autopair: Adds closing ([""]) etc
;; Source: https://github.com/capitaomorte/autopair
;; </removed>
;;=====
;; The two lines below were working but when I went down to emacs 24
;; I changed to electric-pair-mode
;(require 'autopair)
;(autopair-global-mode) ; enable autopair in all buffers
(electric-pair-mode 1)

;;=====
;; #3.3 Whitespace-mode: Highlight trailing whitespace, empty lines and anything
;;                       over column 80.
;;      Source: http://www.emacswiki.org/emacs/EightyColumnRule
;;      Key shortcut toggle: 9ll
;;=====
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))

;;=====
;; #3.4 Snippets
;;=====
(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/my-snippets"              ; My personal snippets
        "~/.emacs.d/elpa/yasnippet/snippets"  ; The default collection
        ))

;(setq yas/indent-line nil)                   ; Turns off auto indenting
(yas-global-mode 1)                           ; Turn on snippets in all buffers

;;=====
;; #3.5 Easily move buffer windows around
;;      Key shortcut: 9 <up>, 9 <down>, 9 <left>, 9 <right>
;;=====
(require 'buffer-move)

;;=====
;; #3.4 Make dired less verbose
;;=====
(require 'dired-details)

;;=====
;; #3.5 Package Management
;;=====
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;=====
;; #3.6 Rainbow Delimiters
;;      Web site: http://www.emacswiki.org/emacs/RainbowDelimiters
;;=====
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode) ; Enable by default in all modes

;;=====
;; #3.7 Custom Modeline
;;=====
(require 'my-modeline)
(powerline-default) ; Use the power line for the mode line

;;=====
;; #3.8 js2-mode
;;=====
(require 'js2-mode)
(add-to-list 'auto-mode-alist
             '("\\.js$" . js2-mode))

;;------------------------------------------------------------------------------
;; #4 General enviro configs
;;------------------------------------------------------------------------------

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
;; Use only spaces (no tabs at all)
;;====
(setq-default indent-tabs-mode nil)

;;====
;; #4.1 Font settings
;;====
(set-face-attribute 'default nil :font "Monospace-12")

;;====
;; #4.2 Highlight active line 
;;====
(global-hl-line-mode t)

;;====
;; #4.3 Window Title: Full file path and the time
;;====
(setq frame-title-format
  '((:eval (if (buffer-file-name)
                (abbreviate-file-name (buffer-file-name))
                  "%b")) "    [ " (:eval (propertize (format-time-string "%H:%M"))) " ]"))

;;====
;; #4.4 Spell check: Use aspell
;;====
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=fast"))

;;====
;; #4.5 Load hideshow: I enable this in any major mode config file that I want to use 
;;                     in with. The following line for example is from python mode
;;                     (add-hook 'python-mode-hook 'hs-minor-mode) after that my
;;                     code folding key bindings will work properly.
;;====
(load-library "hideshow")

;;====
;; #4.6 Insert time stamp when file is saved
;; Usage: Within the first 10 lines of a file place "Time-stamp: <>"
;;        and automatically when the file is saved we will get a time stamp
;;====
(setq 
  time-stamp t                           ; do enable time-stamps
  time-stamp-line-limit 10               ; check first 10 buffer lines for Time-stamp: 
  time-stamp-format "%02m-%02d-%04y %02H:%02M:%02S (%u)") ; date format
(add-hook 'write-file-hooks 'time-stamp) ; update when saving

;;====
;; Turn on show parentheses mode so we get the matching sign highlighted 
;;====
(show-paren-mode 1)

;;====
;; Stop Emacs from leaving "foo~" (backup) files all over the place.
;;====
(setq make-backup-files nil)

;;====
;; Write backup files to their own directory
;;====
;;(setq backup-directory-alist
;;      `(("." . ,(expand-file-name
;;                 (concat user-emacs-directory "backups")))))

;;====
;; Auto refresh buffers
;;====
(global-auto-revert-mode 1)

;;====
;; #4.7 Scroll one line at a time And turn of the freaking auto center
;;====
(setq redisplay-dont-pause t
  scroll-margin 0
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1
  auto-window-vscroll nil)
;;------------------------------------------------------------------------------
;; Remember file positions *NOTE* Shut off as it made org act funny.
;;------------------------------------------------------------------------------
;(setq save-place-file "~/.emacs.d/file_positions") ;; save the marks in this file
;(setq-default save-place t)                        ;; activate it for all buffers
;(require 'saveplace)                               ;; get the package

;;====
;; #4.8 Keep any auto customizations in a separate file to keep mine from getting
;; overwritten 
;;====
(setq custom-file "~/.emacs.d/my-emacs-auto-custom.el")
(load custom-file)

;;------------------------------------------------------------------------------
;; #5 Dried Settings
;;------------------------------------------------------------------------------
;;====
;; Also auto refresh dired, but be quiet about it
;;====
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
;;====
;; Make dired less verbose
;; Reminder that ) expands the hidden portion and M-o
;; toggles visibility of the dot files. 
;;====
(setq-default dired-details-hidden-string "[)  M-o] ")
(dired-details-install)
;;====
;; Hide dot files with M-o
;;====
(require 'dired-x)
;(setq-default dired-omit-files-p t) ; this is buffer-local variable
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
;;------------------------------------------------------------------------------
;; #6 My Functions
;;------------------------------------------------------------------------------

;;====
;; #6.1 Toggle between horizontal and vertical layout of two windows.
;;====
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

;;------------------------------------------------------------------------------
;; #7 Color settings
;;------------------------------------------------------------------------------

;;====
;; Default color theme
;;====
(load-theme 'zenburn t) ; Use the zenburn theme

;;====
;; This allows the usage of solarized themes if I want to use them
;;====
(require 'solarized)

;;====
;; Set the color of paren mode matches so they really stand out
;;====
(require 'paren)
(set-face-background 'show-paren-match-face (face-background 'default)) ; Use the background
(set-face-foreground 'show-paren-match-face "#3FFF00")                  ; Bright green colored font
(set-face-attribute 'show-paren-match-face nil :weight 'extra-bold)     ; And a bold weight 

;;------------------------------------------------------------------------------
;; #8 Major mode configurations
;;------------------------------------------------------------------------------

;;====
;; #8.1 CSS
;;====

;;----
; Turn on the hide screen minor mode in all css files, so we can fold lines
;;----
(add-hook 'css-mode-hook 'hs-minor-mode)

;;----
;; CSS and Rainbow modes 
;;----
(defun all-css-modes() (css-mode) (rainbow-mode)) 

;;----
;; Load both major and minor modes in one call based on file type 
;;----
(add-to-list 'auto-mode-alist '("\\.css$" . all-css-modes)) 

;;====
;; #8.2 Clojure
;;====
(require 'clojure-mode)
;-----
; Source: https://github.com/kingtim/nrepl.el
; Additional key mappings can be found there if need be. And this is likely going to
; need to be updated at some point as Clojure matures
;-----
(require 'nrepl)

;;====
;; #8.3 Org
;;====
(setq org-src-fontify-natively t)        ; Highlight text in SRC blocks
(setq org-return-follows-link t)         ; Follow links by pressing enter
(setq org-hidden-keywords '(title))      ; This is not working in Linux works on windows
(setq org-hide-emphasis-markers t)       ; Hide all the * / _ etc markers 
(setq org-directory "~/Dropbox/Org")     ; Set the prg directory
;----
; Make links in my wiki open in the same frame where the link was clicked
;----
(setq org-link-frame-setup 
  (quote 
    ((vm . vm-visit-folder-other-frame) 
    (gnus . gnus) 
    (file . find-file))))

