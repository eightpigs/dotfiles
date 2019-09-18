;; Org-mode

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-todo-keywords
'((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d)" "CANCELLED(c)")
(sequence "|" "CANCELED(c)")))

(setf org-todo-keyword-faces '(("TODO" . (:weight bold))
                                ("STARTED" . (:foreground "white" :background "#2E8B57"  :weight bold))
                                ("DONE" . (:foreground "white" :background "#3498DB" :weight bold))
                                ("CANCELLED" . (:foreground "white" :background "#ff4500" :weight bold))
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

(setq org-tags-column 100)
;; auto highlight
(setq org-src-fontify-natively t)

(org-agenda-files (quote ("~/Documents/TODO.org")))

(provide 'init-org-mode)
