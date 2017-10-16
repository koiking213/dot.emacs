;; C-hをバックスペースに
(keyboard-translate ?\C-h ?\C-?)

;; C-o to switch windows in order
(global-set-key  "\C-o" 'other-window)

;; M-p to scroll up, M-n to scroll down
(defun scroll-up-in-place (n)
  (interactive "p")
  (previous-line n)
  (scroll-down n))
(defun scroll-down-in-place (n)
  (interactive "p")
  (next-line n)
  (scroll-up n))
(global-set-key "\M-p" 'scroll-up-in-place)
(global-set-key "\M-n" 'scroll-down-in-place)

;; showing and hiding blocks of code
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
(hs-minor-mode t)))

;; package list
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;; use package
(require 'use-package)

;; M-hで単語削除
(bind-keys*
 ("M-h" . backward-kill-word))

;; ;;;===============================================
;; ;;; cmigemo設定
;; ;;;===============================================
;; (use-package migemo)
;; (when (eq system-type 'windows-nt)
;;   (setq migemo-dictionary "C:/Users/koiki/AppData/Roaming/.emacs.d/conf/migemo/dict/cp932/migemo-dict")
;;   (setq migemo-coding-system 'cp932-unix))
;; (when (eq system-type 'gnu/linux)
;;   (setq migemo-dictionary "C:/Users/koiki/AppData/Roaming/.emacs.d/conf/migemo/dict/utf-8/migemo-dict")
;;   (setq migemo-coding-system 'utf-8-unix))
;; (setq migemo-command "cmigemo")
;; (setq migemo-options '("-q" "--emacs" "-i" "\a")) (setq migemo-user-dictionary nil) (setq migemo-regex-dictionary nil)
;; (load-library "migemo") ; ロードパス指定.
;; (migemo-init)

;; helm
(bind-keys*
 ("C-;" . helm-for-files))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (magit helm use-package migemo))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

