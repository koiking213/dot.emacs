;; proxy
(setq load-path (append
                 '("~/.emacs.d/private-conf")
                 load-path))
(load "myproxy" t)

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

;; 行頭でC-kすると改行ごとキルする
(defun kill-line-twice (&optional numlines)
  "Acts like normal kill except kills entire line if at beginning"
  (interactive "p")
  (cond ((or (= (current-column) 0)
                  (> numlines 1))
          (kill-line numlines))
        (t (kill-line))))
(global-set-key "\C-k" 'kill-line-twice)

;; 現在の関数名を表示
(which-function-mode 1)

;; org mode
(setq org-use-speed-commands t)

;; cua mode
(cua-mode t)
(setq cua-enable-cua-keys nil) ; デフォルトキーバインドを無効化
(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)

;; タイトルバー
(setq frame-title-format (format "%%b" invocation-name))

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
        ("org" . "http://orgmode.org/elpa/")
	("marmalade" . "http://marmalade-repo.org/packages/")))


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

;; package-installのために必要
(require 'epg)

;; magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (## magit helm use-package migemo))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-string-face ((t (:foreground "color-135"))))
 '(magit-section-highlight ((t (:background "color-17"))))
 '(minibuffer-prompt ((t (:foreground "brightcyan")))))


