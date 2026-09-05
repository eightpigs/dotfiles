;; Org-mode

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(require 'org-agenda)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-startup-indented nil)
(setq org-bullets-bullet-list '( "" ""))

(setq org-tag-alist '(
  ("@career" . ?c)
  ("@health" . ?h)
  ("@family" . ?f)
  ("@dollar" . ?d)
  ("@scoial" . ?s)
  ("@learn" . ?l)
  ("@relax" . ?r)
  ("@mind" . ?m)
))

(setq org-ellipsis " ")

(setq org-tags-column 2)

(setq org-cycle-separator-lines 1)
(setq org-enforce-todo-dependencies t)

(setq org-todo-keywords
'((sequence "PLAN(p!)" "TODO(t!)" "|" "DOING(s@/!)" "|" "DONE(d@/!)" "ABORT(a@/!)" "DELAYED(-@/!)")
))

;; :background "#3f54ea"
(setf org-todo-keyword-faces '(
  ("TODO" . (:foreground "white" :background "#3977d4" :weight bold))
  ("DOING" . (:foreground "black" :background "yellow"  :weight bold))
  ("DONE" . (:foreground "white" :background "#2c8e4a" :weight bold))
  ("ABORT" . (:foreground "white" :background "#808586" :weight bold))
  ("DELAYED" . (:foreground "white" :background "#FF0000" :weight bold))
))

(setq org-log-done 'time)
(setq org-log-done 'note)

(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)

;; auto highlight
(setq org-src-fontify-natively t)

(dolist (face '(org-level-1)
                org-level-2 org-level-3
                org-level-4 org-level-5
                org-level-6 org-level-7
                org-level-8))
  (set-face-attribute face nil :weight 'normal))


(custom-theme-set-faces 'user
                        `(org-level-1 ((t (:background nil)))))

;; ------------------------------------------
;; agenda
;; ------------------------------------------

(define-key org-agenda-mode-map "j" 'org-agenda-next-line)
(define-key org-agenda-mode-map "k" 'org-agenda-previous-line)
(define-key org-agenda-mode-map "n" 'org-agenda-goto-date)
(define-key org-agenda-mode-map "p" 'org-agenda-capture)

(setq org-agenda-align-tags-to-column -80)


;; Optional agenda time-grid coloring (disabled).
;; (defun ljg/org-agenda-time-grid-spacing ()
;;   "Set different line spacing w.r.t. time duration."
;;   (save-excursion
;;     (let* ((background (alist-get 'background-mode (frame-parameters)))
;;            (background-dark-p (string= background "dark"))
;;            (colors (list "#1ABC9C" "#2ECC71" "#3498DB" "#9966ff"))
;;            pos
;;            duration)
;;       (nconc colors colors)
;;       (goto-char (point-min))
;;       (while (setq pos (next-single-property-change (point) 'duration))
;;         (goto-char pos)
;;         (when (and (not (equal pos (point-at-eol)))
;;                    (setq duration (org-get-at-bol 'duration)))
;;           (let ((line-height (if (< duration 30) 1.0 (+ 0.5 (/ duration 60))))
;;                 (ov (make-overlay (point-at-bol) (1+ (point-at-eol)))))
;;             (overlay-put ov 'face `(:background ,(car colors)
;;                                                 :foreground
;;                                                 ,(if background-dark-p "black" "white")))
;;             (setq colors (cdr colors))
;;             (overlay-put ov 'line-height line-height)
;;             (overlay-put ov 'line-spacing (1- line-height))))))))
;; 
;; (add-hook 'org-agenda-finalize-hook #'ljg/org-agenda-time-grid-spacing)

(setq org-agenda-custom-commands
      '(("h" "Agenda and Home-related tasks"
         ((agenda "")
          (tags-todo "home")
          (tags "garden")))
        ("o" "Agenda and Office-related tasks"
         ((agenda "")
          (tags-todo "@career")))))


(setq org-agenda-custom-commands
      '(("d" "Upcoming deadlines" agenda "" 
                ((org-agenda-time-grid nil)
                 (org-deadline-warning-days 365)        ;; [1]
                 (org-agenda-entry-types '(:deadline))  ;; [2]
                 ))
      ;; other commands go here
       ))

;; Set this on the machine, e.g. in custom.el.
;; (setq org-agenda-files '("~/org/"))

(provide 'init-org-mode)
