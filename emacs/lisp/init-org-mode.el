;; Org-mode

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; 打开 org-indent mode
(setq org-startup-indented t)

;; 设置 bullet list
(setq org-bullets-bullet-list '("☰" "☶" "☷" "◈" "◇" "●" "○"))

(setq org-todo-keywords
'((sequence "TODO(t)" "DOING(s)" "|" "DONE(d)" "ABORT(a)")
))

;; :background "#3f54ea"
(setf org-todo-keyword-faces '(("TODO" . (:foreground "white" :background "#3977d4" :weight bold))
                                ("DOING" . (:foreground "black" :background "yellow"  :weight bold))
                                ("DONE" . (:foreground "white" :background "#2c8e4a" :weight bold))
                                ("ABORT" . (:foreground "white" :background "#808586" :weight bold))
                                ))

(setq org-log-done 'time)
(setq org-log-done 'note)

(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)

;;在agenda view中使j/k键绑定为下/上移一行（与默认的n/p交换）
(require 'org-agenda)
(define-key org-agenda-mode-map "j" 'org-agenda-next-line)
(define-key org-agenda-mode-map "k" 'org-agenda-previous-line)
(define-key org-agenda-mode-map "n" 'org-agenda-goto-date)
(define-key org-agenda-mode-map "p" 'org-agenda-capture)

(setq org-tags-column 2)
;; auto highlight
(setq org-src-fontify-natively t)


;; org-mode 粗体问题
(dolist (face '(org-level-1
                org-level-2 org-level-3
                org-level-4 org-level-5
                org-level-6 org-level-7
                org-level-8))
  (set-face-attribute face nil :weight 'normal))

(org-agenda-files (quote ("~/OneDrive/docs/org-mode/agenda.org")))

(provide 'init-org-mode)
