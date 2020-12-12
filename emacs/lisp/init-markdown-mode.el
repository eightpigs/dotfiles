;; markdown-mode

(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode))
  :defer 5
  :custom
  (markdown-enable-math t)
  (markdown-command "pandoc --mathml --quiet")
  ;; (markdown-css-paths '("http://jiaxi.sdf.org/static/md.css"))
  (markdown-xhtml-header-content "\n<meta name=\"viewport\" content=\"width=device-width\">")
  :init (setq markdown-command "multimarkdown"))
