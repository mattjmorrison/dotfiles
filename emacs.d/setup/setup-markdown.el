(require 'markdown-mode)

(setq auto-mode-alist
      (cons '("\\.\\(md\\|markdown\\)\\'" . markdown-mode) auto-mode-alist))

(provide 'setup-markdown)
