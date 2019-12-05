;; --------------- Basic Config ----------------

;; set unicode encoding
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)

;; clean window
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)

;; clean startup
(setq inhibit-startup-message t)
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message nil)

;; no lockfile
(setq create-lockfiles nil)

;; no ring-bell
(setq ring-bell-function 'ignore)

;; nice scrolling
(pixel-scroll-mode)
(setq scroll-margin 5)

;; enable syntax highlight
(global-font-lock-mode t)

;; show paren
;; (show-paren-mode t)

;; use system clipboard
(setq save-interprogram-paste-before-kill t)

;; not back file
(setq make-backup-files nil)

;; font
(when (member "Menlo" (font-family-list))
  (set-face-attribute 'default nil :font "Menlo-12"))



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
(setq recentf-max-menu-item 10)

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
