(let (;; 加载的时候临时增大`gc-cons-threshold'以加速启动速度。
      (gc-cons-threshold most-positive-fixnum)
      ;; 清空避免加载远程文件的时候分析文件。
      (file-name-handler-alist nil))

;; M-x benchmark-init/show-durations-tree
;; (require 'benchmark-init-modes)
;;   (require 'benchmark-init)
;;   (benchmark-init/activate)

;; Emacs配置文件内容写到下面.
;; Emacs配置文件内容写到下面.
;; Emacs配置文件内容写到下面.

  (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
  
  (setq custom-file "~/.emacs.d/custom.el")
  ;; (load custom-file)

  (require 'init-basic)
  (require 'init-basic-interface)
  (require 'init-elpa)
  (require 'init-org-mode)
  (require 'init-evil)
  (require 'init-doom-theme)
  (require 'init-doom-modeline)
  (require 'init-company)
  (require 'init-keymaps)
  (require 'init-rss)
)
