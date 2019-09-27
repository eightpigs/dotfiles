(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-basic)
(require 'init-elpa)
(require 'init-org-mode)
(require 'init-evil)
(require 'init-doom-theme)
(require 'init-doom-modeline)

;; languages
(require 'init-lang-go)

(require 'init-company)

(require 'init-keymaps)


(require 'init-rss)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bc75dfb513af404a26260b3420d1f3e4131df752c19ab2984a7c85def9a2917e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(markdown-command "pandoc --mathml --quiet" t)
 '(markdown-enable-math t t)
 '(markdown-xhtml-header-content "
<meta name=\"viewport\" content=\"width=device-width\">" t)
 '(org-agenda-files (quote ("~/Documents/TODO.org")))
 '(package-selected-packages
   (quote
    (company-lsp company editorconfig ag fzf go-mode markdown-mode evil-leader evil org-bullets which-key try use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
