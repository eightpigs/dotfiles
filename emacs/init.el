(let (;; 加载的时候临时增大`gc-cons-threshold'以加速启动速度。
      (gc-cons-threshold most-positive-fixnum)
      ;; 清空避免加载远程文件的时候分析文件。
      (file-name-handler-alist nil))

;; M-x benchmark-init/show-durations-tree
 (require 'benchmark-init-modes)
   (require 'benchmark-init)
   (benchmark-init/activate)

;; Emacs配置文件内容写到下面.
;; Emacs配置文件内容写到下面.
;; Emacs配置文件内容写到下面.

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-basic)
(require 'init-elpa)
(require 'init-org-mode)
(require 'init-evil)
(require 'init-doom-theme)
(require 'init-doom-modeline)
;; (require 'init-lang-go)
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
    ("2d392972cbe692ee4ac61dc79907af65051450caf690a8c4d36eb40c1857ba7d" default)))
 '(markdown-command "pandoc --mathml --quiet" t)
 '(markdown-enable-math t t)
 '(markdown-xhtml-header-content "
<meta name=\"viewport\" content=\"width=device-width\">" t)
 '(package-selected-packages
   (quote
    (benchmark-init esup which-key use-package try org-bullets go-mode evil-leader doom-themes doom-modeline company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


)
