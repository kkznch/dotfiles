;; システム ----------------------------------------------------------------------

;; load-pathに追加
(setq elisp-path (expand-file-name "elisp" user-emacs-directory))
(add-to-list `load-path elisp-path)

;; 文字コード
(setenv "LANG" "ja_JP.UTF-8")
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

;; バックアップファイルの設定
;;(setq backup-inhibited t) ;; バックアップファイルを作成しない
(setq backup-directory-alist '((".*" . "~/.emacs.d/backup"))) ;; 保存先変更
(setq version-control     t) ;; 実行の有無
(setq kept-new-versions   5) ;; 最新の保持数
(setq kept-old-versions   1) ;; 最古の保持数
(setq delete-old-versions t) ;; 範囲外を削除

;; 自動保存の設定
;;(setq auto-save-default nil) ;; 自動保存しない
(setq auto-save-file-name-transforms   '((".*" "~/.emacs.d/tmp/" t))) ;; 保存先変更
(setq delete-auto-save-files t) ;;  終了時に自動保存ファイルを削除

;; シンボリックリンクの読み込みを許可
(setq vc-follow-symlinks t)

;; シンボリックリンク先のVCS内で更新が入った場合にバッファを自動更新
(setq auto-revert-check-vc-info t)

;; 読み取りモードで起動する
;;(add-hook 'find-file-hooks 'view-mode)

;; 表示 --------------------------------------------------------------------------

;; 現在行をハイライト
;;(global-hl-line-mode t)

;; 対応する括弧をハイライト表示させる設定
(show-paren-mode t)

;; ハイライトモードを有効化
;; C-s検索時にハイライトされる
(global-hi-lock-mode 1)

;; 選択されたリージョンを色付きにしてわかりやすくする設定
(transient-mark-mode t)

;; 行番号と列番号を表示
(line-number-mode 1)
(column-number-mode 1)

;; ビープ音を消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; メニューバーを非表示
(menu-bar-mode -1)

;; コンパイル画面で自動スクロールする
(setq compilation-scroll-output t)

;; 1行スクロール
(setq scroll-step 1)

;; 入力 --------------------------------------------------------------------------
;; DeleteではなくBackspaceにする
(normal-erase-is-backspace-mode 0)

;; tabではなくspaceを使う
;; ここらへんの設定はeditorconfigで管理できるから書かなくてもよいかも
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq default-tab-width 4)

;; リージョンの大文字小文字変換の有効化
;; C-x C-u -> upcase
;; C-x C-l -> downcase
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; キーバインド
(global-set-key (kbd "C-h") 'delete-backward-char) ;; Delete
;;(global-set-key (kbd "C-j") 'dabbrev-expand) ;; 補完（auto-complete使うからいらないかも）
;;(global-set-key (kbd "C-u") 'undo) ;; Undo
(global-set-key (kbd "C-x C-m") 'compile) ;; コンパイル
(global-set-key (kbd "C-x C-g") 'goto-line) ;; 指定した行に移動
(global-unset-key (kbd "C-x C-n")) ;; 強制移動カラムのキーバインド無効化

;; 外部パッケージ ----------------------------------------------------------------

;; package.el --------------------------------------------------

;; パッケージ追加
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(fset 'package-desc-vers 'package--ac-desc-version)
(package-initialize)

;; package.elでインストールしたパッケージを管理するcustom.elを読み込み
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; replace-colorthemes -----------------------------------------
;; custom-theme-load-pathに追加
(add-to-list `custom-theme-load-path
             (file-name-as-directory (expand-file-name "replace-colorthemes" elisp-path)))

;; テーマ設定
(load-theme 'ld-dark t t)
(enable-theme `ld-dark)

;; uniquify ----------------------------------------------------
;; 同名ファイルを開いたときに、１階層上のディレクトリ名を表示する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; auto-complete -----------------------------------------------
;; 入力を補完する
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(ac-config-default)
(setq ac-use-menu-map t)
(global-set-key (kbd "C-j") 'auto-complete)

;; editorconfig ------------------------------------------------
;; editorconfigを使用する
(editorconfig-mode 1)

;; python ------------------------------------------------------
;; python-modeがロードされた際の処理（python-modeではなくpythonでよい）
(with-eval-after-load "python"
    ;; pep8に準じたコードか解析する
    (require 'flymake-python-pyflakes)
    (setq flymake-python-pyflakes-executable "flake8")
    (add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

    ;; pyflakesの検出内容をバッファに表示する
    (defun flymake-show-help ()
        (when (get-char-property (point) 'flymake-overlay)
            (let ((help (get-char-property (point) 'help-echo)))
                (if help (message "%s" help)))))
    (add-hook 'post-command-hook 'flymake-show-help))

;; golang ------------------------------------------------------
;; go-modeがロードされた際の処理
(with-eval-after-load "go-mode"
    ;; go言語の入力の補完を行う
    (require 'go-autocomplete)

    ;; 保存時にコードを整形する
    (add-hook 'before-save-hook 'gofmt-before-save))

;; php ---------------------------------------------------------
;; php-modeがロードされた際の処理
(with-eval-after-load "php-mode"
    ;; phpの入力の補完を行う
    (require 'ac-php)
    (setq ac-sources '(ac-source-php))
    (yas-global-mode 1)
    (global-set-key (kbd "C-]") 'ac-php-find-symbol-at-point)
    (global-set-key (kbd "C-[") 'ac-php-location-stack-back))

;; web ---------------------------------------------------------
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(with-eval-after-load "web-mode"
    (setq web-mode-enable-auto-closing t)
    (setq web-mode-enable-auto-pairing t)
    (setq web-mode-auto-close-style 1)
    (setq web-mode-tag-auto-close-style t))

;; flycheck ----------------------------------------------------
(require 'flycheck)
(flycheck-add-mode 'javascript-eslint 'javascript-mode)
(flycheck-add-mode 'javascript-eslint 'typescript-mode)

;; typescript --------------------------------------------------
(with-eval-after-load "javascript-mode"
    (add-hook 'javascript-mode #'add-node-modules-path))

;; typescript --------------------------------------------------
(with-eval-after-load "typescript-mode"
    (add-hook 'typescript-mode #'add-node-modules-path))
