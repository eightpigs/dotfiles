;; --------------- Basic Config ----------------

;; Encoding
;; UTF-8 as the default coding system
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))

;; Explicitly set the prefered coding systems to avoid annoying prompt
;; from emacs (especially on Microsoft Windows)
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)

;; clean window
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; clean startup
(setq inhibit-startup-message t)
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message nil)

;; disable scrollbars
(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'horizontal-scroll-bar-mode nil)

;; no lockfile
(setq create-lockfiles nil)

;; no ring-bell
(setq ring-bell-function 'ignore)

;; nice scrolling
(pixel-scroll-mode)
(setq scroll-margin 1)

;; enable syntax highlight
(global-font-lock-mode t)

;; use system clipboard
(setq save-interprogram-paste-before-kill t)

;; not back file
(setq make-backup-files nil)


;; --------------- Build-in Config ----------------

;; calendar [built-in]
(setq calendar-location-name "Beijing, China")
(setq calendar-chinese-all-holidays-flag t)
(setq mark-diary-entries-in-calendar t)
(setq mark-holidays-in-calendar t)


;; display-line-numbers [built-in]
(setq display-line-numbers-type 'relative)
(fringe-mode 0)
(setq linum-relative-format "%4s ")
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
(setq nlinum-format " %d")
;; line-number
(setq linum-format "%4d ")

;; Buffer
(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(defalias 'list-buffers 'ibuffer)

;; dired [built-in]
(put 'dired-find-alternate-file 'disabled nil)
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
(setq dired-listing-switches "-alh")

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 20)

;; 显示匹配的括号
(show-paren-mode 1)


;; --------------- Editor Config ----------------

;; indentation
(setq-default indent-tabs-mode nil)
(setq-default default-tab-width 2)
(setq-default c-basic-offset 2)
(setq-default tab-width 2)


;; highlight current line
(global-hl-line-mode 0)

(setq-default indent-tabs-mode nil) ; tab 改为插入空格
(setq go-offset 2)
(setq c-default-style "linux")




;; ------------------- Misc ---------------------

(fset 'yes-or-no-p 'y-or-n-p)
(setq-default major-mode 'text-mode
              fill-column 80
              tab-width 4
              indent-tabs-mode nil)

(defmacro k-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))

(defvar k-gc-timer
  (run-with-idle-timer 15 t
    (lambda ()
    (message "Garbage Collector has run for %.06fsec"
    (k-time (garbage-collect))))))


;; 高亮括号
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))

(provide 'init-basic)
