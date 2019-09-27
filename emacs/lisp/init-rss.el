;; newsticker 

(use-package newsticker
  :defer t
  :init
  (progn
    (add-to-list 'evil-emacs-state-modes 'newsticker-treeview-mode)
    (add-to-list 'evil-emacs-state-modes 'newsticker-treeview-list-mode)
    (setq
     newsticker-url-list-defaults nil   ;;设置默认的列表为空
     newsticker-retrieval-interval 0   ;don't fetch when I'm not reading RSS
     newsticker-automatically-mark-items-as-old nil

     newsticker-url-list
     '(
       ("懒猫" "https://manateelazycat.github.io/feed.xml")
       ("zmonster" "http://www.zmonster.me/atom.xml")
       ))

    (add-hook 'newsticker-treeview-mode-hook
              (lambda ()
                (define-key newsticker-treeview-mode-map (kbd "j") 'newsticker-treeview-next-feed)
                (define-key newsticker-treeview-mode-map (kbd "k") 'newsticker-treeview-prev-feed)
                (define-key newsticker-treeview-mode-map (kbd "l") 'newsticker-treeview-next-page)
                ))
    (add-hook 'newsticker-treeview-list-mode-hook
              (lambda ()
                (define-key newsticker-treeview-list-mode-map (kbd "j") 'next-line)
                (define-key newsticker-treeview-list-mode-map (kbd "k") 'previous-line)
                ))
    ))

(provide 'init-rss)
