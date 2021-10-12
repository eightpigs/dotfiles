(require 'package)

(setq package-enable-at-startup nil)

;; (setq package-archives '(("gnu"           . "http://elpa.example.invalid/gnu/")
;;                          ("melpa"         . "http://elpa.example.invalid/melpa/")
;;                          ("stable-melpa"  . "http://elpa.example.invalid/stable-melpa/")
;;                          ("org"           . "http://elpa.example.invalid/org/")))

(setq package-archives '(("melpa" . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/melpa/")
                         ("org"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/org/")
                         ("gnu"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/gnu/")))

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
