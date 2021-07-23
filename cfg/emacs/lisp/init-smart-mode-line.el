;; smart-mode-line
(use-package smart-mode-line
  :config
  (setq sml/mode-width		'full
    sml/theme 'atom-one-dark
    sml/no-confirm-load-theme t
	  sml/line-number-format	"%4l")
  (sml/setup))


(provide 'init-smart-mode-line)
