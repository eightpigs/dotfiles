(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-vibrant t)
;; (load-theme 'doom-one-light t)
;; (load-theme 'doom-one t)
;; (load-theme 'doom-spacegrey t)
;; (load-theme 'doom-peacock t)
;; (load-theme 'doom-molokai t)
;; (load-theme 'doom-Iosvkem t)
;; (load-theme 'doom-opera t)
;; 
;; (load-theme 'doom-nord-light t)
;; (load-theme 'doom-opera-light t)
;; (load-theme 'doom-acario-dark t)
;; (load-theme 'doom-acario-light t)
;; (load-theme 'doom-city-lights t)
;; (load-theme 'doom-dracula t)
;; (load-theme 'doom-gruvbox t)
;; (load-theme 'doom-Iosvkem t)
;; (load-theme 'doom-nord t)
;; (load-theme 'doom-nova t)
;; (load-theme 'doom-oceanic-next t)
;; (load-theme 'doom-palenight t)
;; (load-theme 'doom-peacock t)
;; (load-theme 'doom-snazzy t)
;; (load-theme 'doom-solarized-dark t)
;; (load-theme 'doom-solarized-light t)
;; (load-theme 'doom-sourcerer t)
;; (load-theme 'doom-spacegrey t)
;; (load-theme 'doom-tomorrow-day t)
;; (load-theme 'doom-tomorrow-night t)
;; (load-theme 'doom-wilmersdorf t)


;; defaults write org.gnu.Emacs TransparentTitleBar LIGHT / DARK
;; defaults write org.gnu.Emacs Emacs.ToolBar -string no
;; defaults write org.gnu.Emacs Emacs.ScrollBar -string no
;; defaults write org.gnu.Emacs Emacs.MenuBar -string no
(when (memq window-system '(mac ns))
  (load-theme 'doom-one-light t)
  (add-to-list 'default-frame-alist '(ns-appearance . light)) ;; {light, dark}
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))

;; Corrects (and improves) org-mode's native fontification.
;; (doom-themes-org-config)

(provide 'init-doom-theme)
