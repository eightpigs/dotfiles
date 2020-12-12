(require 'package)

(setq package-enable-at-startup nil)

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(when (version< emacs-version "27.0")(package-initialize))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(use-package try
  :ensure t
  :defer 5
  )

;; which-key
(use-package which-key
  :ensure t
  :defer 5
  :config (which-key-mode))

(provide 'init-elpa)

