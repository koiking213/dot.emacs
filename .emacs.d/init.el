;; proxy
(setq load-path (append
                 '("~/.emacs.d/private-conf")
                 load-path))
(load "myproxy" t)

;; C-hをバックスペースに
(keyboard-translate ?\C-h ?\C-?)

;; デフォルトのインデントはスペース4つ
(setq-default tab-width 4 indent-tabs-mode nil)

;;; (yes/no) を (y/n)に
(fset 'yes-or-no-p 'y-or-n-p)

;; C-o で順番にウィンドウを切り替える
(global-set-key  "\C-o" 'other-window)

;; カーソル位置のファイル名を開く
(ffap-bindings)

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
	))

;; eshell settings
(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))

;; use package
(require 'use-package)

;;;===============================================
;;; cmigemo設定
;;;===============================================
(use-package migemo)
(when (eq system-type 'windows-nt)
  (setq migemo-dictionary "C:/Users/koiki/AppData/Roaming/.emacs.d/conf/migemo/dict/cp932/migemo-dict")
  (setq migemo-coding-system 'cp932-unix))
(when (eq system-type 'gnu/linux)
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-coding-system 'utf-8-unix))
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs" "-i" "\a"))
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(load-library "migemo") ; ロードパス指定.
(migemo-init)

;; helm
(bind-keys*
 ("M-h" . helm-for-files))

;; package-installのために必要
(require 'epg)

;; magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; ediffでコンフリクト解消する際に両方採用する
(defun ediff-copy-both-to-C ()
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun add-d-to-ediff-mode-map () (define-key ediff-mode-map "d" 'ediff-copy-both-to-C))
(add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map)

;; C-s C-wでカーソル下の単語検索(デフォルトだとカーソルから単語末まで)
(defun isearch-forward-with-heading ()
  "Search the word your cursor looking at."
  (interactive)
  (command-execute 'backward-word)
  (command-execute 'isearch-forward))
(global-set-key "\C-s" 'isearch-forward-with-heading)

;; ;; C/C++文法チェック
;; (require 'flycheck)
;; (flycheck-define-checker c/c++
;;   "A C/C++ checker using g++."
;;   :command ("g++" "-Wall" "-Wextra" source)
;;   :error-patterns  ((error line-start
;;                            (file-name) ":" line ":" column ":" " エラー: " (message)
;;                            line-end)
;;                     (warning line-start
;;                            (file-name) ":" line ":" column ":" " 警告: " (message)
;;                            line-end))
;;   :modes (c-mode c++-mode))
;;(add-hook 'cc-mode 'flycheck-mode)
;;(add-hook 'after-init-hook #'global-flycheck-mode)

;;; GNU global
(require 'ggtags)
(bind-keys*
 ("M-r" . ggtags-find-reference))

(add-hook 'c-mode-common-hook
	  '(lambda()
	     (gtags-mode 1)
	     ))

;; projectile
(use-package projectile)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode projectile flycheck ggtags tramp-theme ## magit helm use-package migemo))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:inherit diff-changed :background "brightgreen"))))
 '(diff-context ((t (:foreground "white"))))
 '(diff-removed ((t (:inherit diff-changed :background "magenta"))))
 '(font-lock-builtin-face ((t (:foreground "cyan"))))
 '(font-lock-function-name-face ((t (:foreground "color-33"))))
 '(font-lock-keyword-face ((t (:foreground "brightmagenta"))))
 '(font-lock-string-face ((t (:foreground "color-135"))))
 '(font-lock-type-face ((t (:foreground "green"))))
 '(magit-section-highlight ((t (:background "color-17"))))
 '(minibuffer-prompt ((t (:foreground "brightcyan")))))


