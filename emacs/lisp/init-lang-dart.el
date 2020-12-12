(use-package dart-mode
  :ensure t
  :defines (projectile-project-root-files-bottom-up)
  :config
  (with-eval-after-load 'projectile
    (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
    (add-to-list 'projectile-project-root-files-bottom-up "BUILD")))

(provide 'init-lang-dart)
