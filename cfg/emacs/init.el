(let (;; `gc-cons-threshold'
      (gc-cons-threshold most-positive-fixnum)
      ;; 
      (file-name-handler-alist nil))

;; M-x benchmark-init/show-durations-tree
;; (require 'benchmark-init-modes)
;;   (require 'benchmark-init)
;;   (benchmark-init/activate)

;; Emacs.
;; Emacs.
;; Emacs.

  (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
  
  (setq custom-file "~/.config/emacs/custom.el")
  ;; (load custom-file)

  (require 'init-basic)
  (require 'init-basic-interface)
  (require 'init-elpa)
  (require 'init-doom-theme)
  (require 'init-doom-modeline)
  (require 'init-evil)
  (require 'init-org-mode)
  (require 'init-company)
  (require 'init-git)
  (require 'init-keymaps)

  (require 'init-lang-rust)
  (require 'init-lang-go)
  (require 'init-lang-dart)
)
