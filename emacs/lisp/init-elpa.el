(require 'package)

(setq package-enable-at-startup nil)

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(when (version< emacs-version "27.0")(package-initialize))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package evil
  :ensure t
  )

(use-package evil-leader
  :ensure t
  )

(use-package company
  :ensure t
  )

(use-package try
  :ensure t
  :defer 5
  )

;; which-key
(use-package which-key
  :ensure t
  :defer 5
  :config (which-key-mode))

;; Theme
(use-package doom-themes
  :ensure t)

;; markdown-mode
(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :defer 5
  :custom
  (markdown-enable-math t)
  (markdown-command "pandoc --mathml --quiet")
  ;; (markdown-css-paths '("http://jiaxi.sdf.org/static/md.css"))
  (markdown-xhtml-header-content "\n<meta name=\"viewport\" content=\"width=device-width\">")
  :init (setq markdown-command "multimarkdown"))

(provide 'init-elpa)

