(use-package doom-modeline
      :ensure t
      :defer t
      :hook (after-init . doom-modeline-init))

(setq doom-modeline-height 20)
(setq doom-modeline-bar-width 3)
(setq doom-modeline-icon nil)
(setq doom-modeline-major-mode-icon nil)
(setq doom-modeline-major-mode-color-icon nil)
(setq doom-modeline-enable-word-count t)
(setq doom-modeline-indent-info t)
(setq doom-modeline-vcs-max-length 25)

(provide 'init-doom-modeline)
