;; (use-package all-the-icons)
;; (setq inhibit-compacting-font-caches t)


;; font
;;(when (member "Menlo" (font-family-list))
;;  (set-face-attribute 'default nil :font "Menlo-13"))

;; (require 'cnfonts)
;; 让 cnfonts 随着 Emacs 自动生效。
;; (cnfonts-enable)
;; (setq cnfonts-use-face-font-rescale t)


;; Auto generated by cnfonts
;; <https://github.com/tumashu/cnfonts>
(set-face-attribute
 'default nil
 :font (font-spec :name "-APPL-Monaco-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1"
                  :weight 'normal
                  :slant 'normal
                  :size 14.0))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font
   (frame-parameter nil 'font)
   charset
   (font-spec :name "-WQYF-WenQuanYi Micro Hei Mono-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1"
              :weight 'normal
              :slant 'normal
              :size 11.0)))

(provide 'init-basic-interface)
