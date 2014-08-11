;;==
;; Require packages, add additional package archives and activate all packages
;;==
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;;==
; We will guarantee the following packages are installed
;;==
(defvar required-packages
  '(
    evil                      ; The sole reason that is Emacs useful
    evil-leader               ; Provide Vim-like leader key functionality
    key-chord                 ; Provide functionality similar to key maps in Vim
    fiplr                     ; Fuzzy file finder
    dired-details             ; Provide the ability to manipulate info displayed by dired
    ido-vertical-mode         ; Make the auto completion of commands not be a hot mess
    smex                      ; Actually to the cool auto completion of command
    rainbow-delimiters        ; Does what it says on the tin
    smart-mode-line           ; A slightly better than stock mode line
    auto-complete             ; Provide auto completion in buffers
    cider                     ; Clojure hotness
    zenburn-theme             ; Zenburn Emacs theme nuff said
  ))

;;==
; Method to check if all packages are installed
;;==
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))
;;==
; If we have any missing packages we install them here
;;==
(unless (packages-installed-p)
  (package-refresh-contents)
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;;==
; Shows packages that are installed but not in `required-packages'.
; Helpful for clean up
;;==
(defun package-list-unaccounted-packages ()
  (interactive)
  (package-show-package-list
   (remove-if-not (lambda (x) (and (not (memq x required-packages))
                                   (not (package-built-in-p x))
                                   (package-installed-p x)))
                  (mapcar 'car package-archive-contents))))

(provide 'setup-install-packages)
