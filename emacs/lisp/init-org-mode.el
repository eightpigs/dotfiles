;; Org-mode

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-todo-keywords
'((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d)" "CANCELLED(c)")
(sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
(sequence "|" "CANCELED(c)")))

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

(org-agenda-files (quote ("~/Documents/TODO.org")))

(provide 'init-org-mode)
