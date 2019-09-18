(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
; (load-theme 'doom-one t)
;; (load-theme 'doom-molokai t)
;; (load-theme 'doom-nord-light t)
;; (load-theme 'doom-spacegrey t)
(load-theme 'doom-peacock t)
;; (load-theme 'doom-opera-light t)


;; Corrects (and improves) org-mode's native fontification.
;; (doom-themes-org-config)


;; org-mode 粗体问题
(dolist (face '(org-level-1
                org-level-2 org-level-3
                org-level-4 org-level-5
                org-level-6 org-level-7
                org-level-8))
  (set-face-attribute face nil :weight 'normal))

(provide 'init-doom-theme)
