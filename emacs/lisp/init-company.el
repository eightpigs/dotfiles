;; company-mode
(require 'company)
;; (require 'company-lsp)

(add-hook 'after-init-hook 'global-company-mode)

 (setq company-backends
        '(company-capf company-files company-lsp company-css
                       (company-dabbrev-code company-gtags company-etags company-keywords)
                       company-dabbrev ))

(global-company-mode 1)

(setq
 company-dabbrev-other-buffers 'all
 ;; t means search buffers with same major mode
 company-dabbrev-code-other-buffers t
 company-dabbrev-code-ignore-case nil
 company-dabbrev-ignore-case nil
 company-dabbrev-downcase nil
 company-minimum-prefix-length 2
 company-idle-delay 0.01)


(provide 'init-company)
