(require 'package)
(setq package-enable-at-startup nil)

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))





(use-package try
  :ensure t)


;; which-key
(use-package which-key
  :ensure t
  :config (which-key-mode))


;; Theme
(use-package doom-themes
  :ensure t)


;; markdown-mode
(use-package markdown-mode
  :mode ("\\.md\\'" "\\.markdown\\'")
  :custom
  (markdown-enable-math t)
  (markdown-command "pandoc --mathml --quiet")
;;  (markdown-css-paths '("http://jiaxi.sdf.org/static/md.css"))
  (markdown-xhtml-header-content "\n<meta name=\"viewport\" content=\"width=device-width\">"))


(provide 'init-elpa)

