;; evil

(use-package evil
  :ensure t
  )

(use-package evil-leader
  :ensure t
  )

(evil-mode 1)
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode)
(evil-leader/set-leader "SPC")

(evil-leader/set-key
  "bb"  'switch-to-buffer
  "i"   'save-buffer
  "wh"  'evil-window-left
  "wj"  'evil-window-down
  "wk"  'evil-window-up
  "wl"  'evil-window-right
  "w\\" 'split-window-horizontally
  "w-"  'split-window-vertically
  "bn"  'evil-window-new
  "q"   'evil-quit
  ";"   'fzf
  )

(define-key evil-normal-state-map "H" 'beginning-of-line)
(define-key evil-normal-state-map "L" 'end-of-line)
(define-key evil-visual-state-map "H" 'beginning-of-line)
(define-key evil-visual-state-map "L" 'end-of-line)

(provide 'init-evil)
