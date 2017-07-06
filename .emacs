;; 初期フレームの設定
(setq default-frame-alist
	(append (list '(foreground-color . "gray")
		'(background-color . "black")
		'(border-color . "black")
		'(mouse-color . "white")
		'(width . 80)
		'(height . 40)
		'(top . 100)
		'(left . 100))
	default-frame-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; yatex-mode 設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; yatex-mode をロードする
;;; (require 'yatex-mode) ではエラーが発生
;(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;(setq auto-mode-alist (append
;  '(("\\.tex$" . yatex-mode)
;    ("\\.ltx$" . yatex-mode)
;    ("\\.cls$" . yatex-mode)
;    ("\\.sty$" . yatex-mode)
;    ("\\.clo$" . yatex-mode)
;    ("\\.bbl$" . yatex-mode)) auto-mode-alist))

;;;;; mozcとiBusの設定
;;; ibus-mode
;(require 'ibus)
;;; ibus-modeの自動起動
;(add-hook 'after-init-hook 'ibus-mode-on)
;;; C-SPCでSet Mark
;(ibus-define-common-key ?\C-\s nil)
;; C-/でUndo
;(ibus-define-common-key ?\C-/ nil)
;;; IBusの状態でカーソルの色を変更
;(setq ibus-cursor-color '("limegreen" "white" "blue"))
;(global-set-key "\C-\\" 'ibus-toggle)
;(global-set-key [henkan] 'ibus-enable)
;(global-set-key [muhenkan] 'ibus-disable)

;; C-hをバックスペースに
(keyboard-translate ?\C-h ?\C-?)

;;; auto complete mode
;(add-to-list 'load-path "/home/koiking213/.emacs.d/elisp")
;(require 'auto-complete)
;(global-auto-complete-mode t)

;;; python-mode.el
;(add-to-list 'load-path "/home/koiking213/.emacs.d/python-mode.el-6.0.11")
;(setq auto-mode-alist (cons '("\.py$" . python-mode) auto-mode-alist))
;(setq interpreter-mode-alist (cons '("python" . python-mode)
;interpreter-mode-alist))
;(autoload 'python-mode "python-mode" "Python editing mode." t)
;
;
;;; use pysmell
;(add-to-list 'load-path "/home/koiking213/.emacs.d/pysmell")
;(require 'pysmell)
;(add-hook 'python-mode-hook (lambda () (pysmell-mode 1)))
;
;(defvar ac-source-pysmell
;'((candidates
;. (lambda ()
;(require 'pysmell)
;(pysmell-get-all-completions))))
;"Source for PySmell")
;
;(add-hook 'python-mode-hook
;'(lambda ()
;(set (make-local-variable 'ac-sources) (append ac-sources '(ac-source-pysmell)))))
;

;; シェルウインドウ内のマウスクリックの際，バッファの最後にカーソルが飛ぶ
(require 'shell)
(define-key shell-mode-map [mouse-1] 'end-of-buffer)

;; SHIFT + cursor to swap window
(setq windmove-wrap-around t)
(windmove-default-keybindings)

;; setting elisp
(setq load-path (cons "~/.emacs.d/elisp" load-path))

;; install-elisp
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;; auto-complete-mode
(require 'auto-complete)
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; auto-install
(add-to-list 'load-path (expand-file-name "~/elisp"))
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")

;; anything
(require 'anything)
(require 'anything-config)
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)

;; gtags
(setq c-mode-hook
      '(lambda ()
	 (gtags-mode 1)
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\M-b" 'gtags-pop-stack)
	 ))

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

;; navi2ch
(autoload 'navi2ch "navi2ch" "Navigator for 2ch" t)

;; showing and hiding blocks of code
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
    (hs-minor-mode t)))

;;  Attempt to reassign the default gdb command to point to gdb64
(setq gud-gdb-command-name "/usr/local/gdb-python/bin/gdb")
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;;;;;; Go language
(setenv "GOPATH" "/home/yuya/Development/gocode")
(setq exec-path (cons "/usr/local/go/bin" exec-path))
(add-to-list 'exec-path "/home/yuya/Development/gocode/bin")
(add-hook 'before-save-hook 'gofmt-before-save)

;godef
(defun my-go-mode-hook ()
  ; Call Gofmt before saving                                                    
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding                                                      
  (local-set-key (kbd "M-t") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;;auto-complete for go
;(require 'go-mode-load)
(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)
;(eval-after-load "go-mode"
;  '(progn
;     (require 'go-autocomplete)))
;(add-to-list 'ac-dictionary-directories "~/elisp/ac-dict")
;(ac-config-default)
;(require 'go-autocomplete)
;(require 'auto-complete-config)
;(require 'go-mode-load)
