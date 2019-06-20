(require 'go-mode)

(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-c C-g") 'go-goto-imports)))
(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-c C-f") 'gofmt)))
(add-hook 'before-save-hook 'gofmt-before-save)

(defvar golang-goto-stack '())

(defun golang-jump-to-definition ()
  (interactive)
  (add-to-list 'golang-goto-stack
               (list (buffer-name) (point)))
  (godef-jump (point) nil))

(defun golang-jump-back ()
  (interactive)
  (let ((p (pop golang-goto-stack)))
    (if p (progn
            (switch-to-buffer (nth 0 p))
            (goto-char (nth 1 p))))))


(provide 'init-lang-go)
