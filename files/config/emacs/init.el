;; -*- lexical-binding: t; -*-

;; システム ----------------------------------------------------------------------

;; 文字コード
(setenv "LANG" "ja_JP.UTF-8")
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

;; バックアップファイルの設定
(setq backup-directory-alist `((".*" . ,(expand-file-name "backup" user-emacs-directory))))
(setq version-control     t)
(setq kept-new-versions   5)
(setq kept-old-versions   1)
(setq delete-old-versions t)

;; 自動保存の設定
(setq auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/" user-emacs-directory) t)))
(setq delete-auto-save-files t)

;; シンボリックリンクの読み込みを許可
(setq vc-follow-symlinks t)

;; シンボリックリンク先のVCS内で更新が入った場合にバッファを自動更新
(setq auto-revert-check-vc-info t)

;; custom.el を別ファイルに分離
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; 表示 --------------------------------------------------------------------------

;; 対応する括弧をハイライト
(show-paren-mode t)

;; ハイライトモード（C-s検索時にハイライト）
(global-hi-lock-mode 1)

;; 選択リージョンを色付き表示
(transient-mark-mode t)

;; 行番号と列番号を表示
(line-number-mode 1)
(column-number-mode 1)

;; ビープ音を消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; メニューバーを非表示
(menu-bar-mode -1)

;; コンパイル画面で自動スクロール
(setq compilation-scroll-output t)

;; 1行スクロール
(setq scroll-step 1)

;; 入力 --------------------------------------------------------------------------

;; DeleteではなくBackspaceにする
(normal-erase-is-backspace-mode 0)

;; tabではなくspaceを使う
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; リージョンの大文字小文字変換の有効化
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; キーバインド
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-x C-m") 'compile)
(global-set-key (kbd "C-x C-g") 'goto-line)
(global-unset-key (kbd "C-x C-n"))

;; パッケージ管理 ----------------------------------------------------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; use-package (Emacs 29+ ビルトイン)
(require 'use-package)
(setq use-package-always-ensure t)

;; 外部パッケージ ----------------------------------------------------------------

;; 同名ファイルを開いたときにディレクトリ名を表示
(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;; 補完
(use-package company
  :config
  (global-company-mode t)
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 2)
  :bind ("C-j" . company-complete))

;; editorconfig
(use-package editorconfig
  :config
  (editorconfig-mode 1))

;; web-mode
(use-package web-mode
  :mode ("\\.phtml\\'" "\\.tpl\\.php\\'" "\\.[agj]sp\\'"
         "\\.as[cp]x\\'" "\\.erb\\'" "\\.mustache\\'"
         "\\.djhtml\\'" "\\.html?\\'")
  :config
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-auto-close-style 1)
  (setq web-mode-tag-auto-close-style t))

;; flycheck
(use-package flycheck
  :defer t
  :config
  (flycheck-add-mode 'javascript-eslint 'javascript-mode)
  (flycheck-add-mode 'javascript-eslint 'typescript-mode))
