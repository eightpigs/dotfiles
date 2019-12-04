(require 'go-mode)

;; auto complete
(add-hook 'go-mode-hook
      (lambda ()
        (set (make-local-variable 'company-backends) '(company-go))
        (company-mode)))

;; Call Gofmt before saving
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

(defvar golang-goto-stack '())

(provide 'init-lang-go)
