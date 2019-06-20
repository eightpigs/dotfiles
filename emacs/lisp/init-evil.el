;; evil
(require 'evil)
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
  "wv"  'split-window-horizontally
  "wh"  'split-window-vertically
  "bn"  'evil-window-new
  "q"   'quit-window
  )

(define-key evil-normal-state-map "H" 'beginning-of-line)
(define-key evil-normal-state-map "L" 'end-of-line)

(provide 'init-evil)
