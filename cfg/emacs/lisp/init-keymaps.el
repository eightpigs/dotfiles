;; open recent files
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
;; open init-config.el: <f2>
(global-set-key (kbd "<f2>") '(lambda() (interactive) (find-file "~/.config/emacs/init.el")))
;; load init-config.el: C-<f2>
(global-set-key (kbd "M-<f2>") '(lambda() (interactive) (load-file "~/.config/emacs/init.el")))


(provide 'init-keymaps)
