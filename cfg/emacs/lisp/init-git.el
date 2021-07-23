
(use-package git-gutter
  :ensure t
  :defer 5
)
(use-package magit
  :ensure t
  :defer 5
  )

(global-git-gutter-mode +1)
(custom-set-variables
 '(git-gutter:update-interval 2))

(custom-set-variables
 '(git-gutter:modified-sign " * ")
 '(git-gutter:added-sign " + ") 
 '(git-gutter:deleted-sign " - "))

(set-face-foreground 'git-gutter:modified "yellow") 
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

(provide 'init-git)
