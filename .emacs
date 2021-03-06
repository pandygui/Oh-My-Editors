;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;     文件名: .eamcs
;;;       作者: Dianchun Huang
;;;   版本管理：Git
;;;     创建于: 2012 年 7 月 21 日
;;; 第一次更新: 2012 年 7 月 21 日 修改者：Dianchun Huang
;;;       描述：
;;;     ===============================================================================
;;;         使用 Emacs 有两年时间了，但一直以来没有用心去配置过，往往是发现自己需要哪个功能
;;;     就到网上找，凡属觉得有意思的，就拿来，测试通过后就不管了，全然不去管这个配置会不
;;;     会影响其他的模式，会不会影响整体性能，所以这次抽空把以前所有的东西重新整理一次，
;;;     不求一次配置出最好的效果，但求稳定高效。
;;;         首先介绍一下基本情况，这个配置文件目前只限人本人使用，所有配置都是按我自己的习
;;;     惯来定义的，暂时只考虑修改配置文件，.emacs.d 目录暂时不放入到仓库中。
;;;         不管以后谁来修改这个文件，请务必遵守如几下条修改规则：
;;;         1、 要求是对每行代码进行审核，确定它的用途，并通过测试。
;;;         2、 鼓励写注释，这种配置脚本的性质不像代码，连续性没有那么强，这也方便以后的修改。
;;;         3、 建议每次修改后，参考本次描述的方式，在提交的 comment 中将自己修改了哪里，为
;;;             什么要修改，这样做有什么好处写进去。这样做，一方面帮助自己理清了思路，另一方面
;;;             也帮助后面修改的人更加清楚修改的原因和理由。
;;;
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 关闭 Emacs 的启动画面
(setq inhibit-startup-message t)

;; 改变 Emacs 固执地要你回答 yes 的行为
(fset 'yes-or-no-p 'y-or-n-p)

;; 显示行号
(global-linum-mode 1)

;; 添加包仓库
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )

;; e2wm
;; simple window manager for emacs
;; 加载失败，原因是：缺少 window-layout.el
;; 断网中，没有办法修复
(add-to-list 'load-path "~/.emacs.d/elpa/window-layout-20120312")
(require 'window-layout)
(add-to-list 'load-path "~/.emacs.d/elpa/e2wm-20120601")
(require 'e2wm)
; 此功能保留，暂时还不熟悉操作
;(e2wm:start-management)

;; 自动补全括号，引号
(add-to-list 'load-path "~/.emacs.d/elpa/autopair-20110508")
(require 'autopair)
(autopair-global-mode t)

;; 不产生备份文件
(setq make-backup-files nil)

;; 不生成 #filename# 文件
(setq auto-save-default nil)

;; 不产生临时文件
(setq-default make-backup-files nil)

;; 让 Emacs 可以直接打开和显示图片
(setq auto-image-file-mode t)

;; 修改 Emacs 标题栏的标题
(setq frame-title-format "%b@HDC")

;; 设置 tab 为 4 个空格的宽度
(setq default-tab-width 4)
(setq c-basic-offset 4)
(setq c-hungry-delete-key t)

;; 使用 24 小时制
(setq display-time-24hr-format t)

;; 时间显示包括日期和具体时间
(setq display-time-day-and-date t)

;; 鼠标自动避开指针
(mouse-avoidance-mode 'animate)

;; 指针不要闪
(blink-cursor-mode -1)

;; 高亮显示要拷贝的内容
(transient-mark-mode 1)

;; 当指针到一边括号时，自动显示所匹配的别一边括号
(show-paren-mode 1)
(setq show-paren-style 'mixed)

;; 使用的是滚轴鼠标
(mouse-wheel-mode t)

;; 自动存盘
(setq auto-save-mode t)

;; 记录最近编辑的文件
(recentf-mode 1)

;; 记住上一次打开的位置
(require 'saveplace)
(setq-default save-place t)

;; 滚动页面时比较舒服，不要整面的滚动
(setq scroll-step 1
      scroll-margin 3
      scroll-conservatively 10000)

;; 设定删除保存记录为200,可以方便以后无限恢复
(setq kill-ring-max 200)

;; 当光标在行尾上下移动的时候，始终保持在行尾
(setq track-eolt)

;; ido-mode
(require 'ido)
(ido-mode t)

;; indent-guide
(add-to-list 'load-path "~/.emacs.d/elpa/indent-guide-20130625.7")
(require 'indent-guide)

;; 关闭当前 buffer
(global-set-key "\C-ck" 'kill-this-buffer)

;; 回车后自动缩进
(global-set-key (kbd "RET") 'newline-and-indent)

;; F2 ：撤销
(global-set-key [f2] 'undo)
;;
;;
;; F3 ：字符替换
(global-set-key [f3] 'replace-string)
;;
;;
;;
;; F4 : 定位到下一个错误，C-f4 ：定位到上一个错误
(global-set-key [C-f4] 'previous-error)
(global-set-key [f4] 'next-error)
;;
;;
;;
;; F5 ：设置编译命令，保存所有文件然后编译当前窗口文件
;; 这个还有改进的余地，如果在一个工程的子目录中，而这个
;; 子目录下面没有 Makefile 文件的话执行就会失败
(defun du-onekey-compile ()
  "Save buffers and start compile"
  (interactive)
  (save-some-buffers)
  (compile compile-command)
  )
(global-set-key [C-f5] 'compile)
(global-set-key [f5] 'du-onekey-compile)
;;
;;
;; F6
;;
;;
;;
;;
;; F7 ：调用 gdb
(global-set-key [f7] 'gdb)
(global-set-key [C-f7] 'gdb-many-windows)
(setq gdb-many-windows t)
;;
;;
;;
;;
;; F8 ：开一个 buffer 然后打开 shell
(defun open-eshell-other-buffer ()
  "Open eshell in other buffer"
  (interactive)
  (split-window-vertically)
  (shell))
(global-set-key [f8] 'open-eshell-other-buffer)
;;
;;
;;
;; F9
(global-set-key [f9] 'ido-switch-buffer)
;;
;;
;; F10
(defun my-ecb-active-or-deactive ()
  (interactive)
  (if ecb-minor-mode
    (ecb-deactivate)
    (ecb-activate)))
(global-set-key [f10] 'my-ecb-active-or-deactive)
;;
;; F11
(global-set-key [f11] 'magit-git-command)
;;
;;
;;
;;
;; F12 : 定义在cpp文件和.h文件中切换的函数
(require 'eassist nil 'noerror)
(global-set-key [f12] 'eassist-switch-h-cpp)
;;
;;
;;
;;

;; hungry-delete minor mode
;(add-to-list 'load-path "~/.emacs.d/elpa/hungry-delete")
;(require 'hungry-delete)
;(global-hungry-delete-mode)

;; undo-tree
;; Treat undo history as a tree
(add-to-list 'load-path "~/.emacs.d/elpa/undo-tree-0.5.2")
(require 'undo-tree)
(global-undo-tree-mode)

;; vlf-0.2
;; View Large Files
(add-to-list 'load-path "~/.emacs.d/elpa/vlf-0.2")
(require 'vlf)

;; 函数参数提示
(require 'eldoc)

;; iimage mode
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)

;; 在 Emacs org 模式里面开启 image 模式
(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
    (set-face-underline-p 'org-link nil)
    (set-face-underline-p 'org-link t))
  (iimage-mode)
  )

(setq org-startup-indented t)

;; rinari minor mode for rails
(setq rinari-tags-file "TAGS")

;; haml-mode
;(add-to-list 'load-path "~/.emacs.d/elpa/haml-mode")
;(require 'haml-mode)

;; sass-mode
;(add-to-list 'load-path "~/.emacs.d/elpa/sass-mode")
;(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))

;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js.erb\\'" . js2-mode))

(add-hook 'haml-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (define-key haml-mode-map "\C-m" 'newline-and-indent)))

;; textmate-to-yas
(add-to-list 'load-path "~/.emacs.d/elpa/textmate-to-yas.el")

;; yasnippet
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet")
(require 'yasnippet)
(setq yas/root-directory '("~/.emacs.d/elpa/yasnippet/snippets"
                           "~/.emacs.d/elpa/yasnippet/yasmate/snippets"))
(yas-global-mode 1)
(yas-reload-all)
(add-hook 'prog-mode-hook
          '(lambda ()
             (yas/minor-mode)))

;; popup
(add-to-list 'load-path "~/.emacs.d/elpa/popup-20120720")
(require 'popup)

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)
(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue")
(define-key ac-completing-map "\M-n" 'ac-next)  ;;; 列表中通过按M-n来向下移动
(define-key ac-completing-map "\M-p" 'ac-previous)
(setq ac-auto-start 2)
(setq ac-auto-show-menu 0.8)
(setq ac-quick-help-delay 0.1)

;; auto-complate-clang-async 配置
(add-to-list 'load-path "~/.emacs.d/elpa/emacs-clang-complete-async")
(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
 (setq ac-clang-complete-executable "~/.emacs.d/elpa/emacs-clang-complete-async/clang-complete")
 (setq ac-sources '(ac-source-clang-async))
 (ac-clang-launch-completion-process)
)


(defun my-ac-config ()
 (setq ac-clang-flags (split-string "-I/usr/include \
					   -I/usr/local/include \
					   -I/usr/include/x86_64-linux-gnu/c++/4.7/bits \
					   -I/usr/include/c++/4.7 \
					   -I/usr/include/c++/4.7/bits \
					   -I/usr/include/c++/4.7/tr1 \
					   -I/usr/include/c++/4.7/tr2 \
					   -I/usr/include/c++/4.7/backward \
					   -I/usr/include/x86_64-linux-gnu \
					   -I/opt/Qt5.1.0/5.1.0/gcc_64/include/QtCore \
					   -I/opt/Qt5.1.0/5.1.0/gcc_64/include/QtGui \
					   -I/opt/Qt5.1.0/5.1.0/gcc_64/include/QtWidgets \
					   -I/opt/Qt5.1.0/5.1.0/gcc_64/include/QtNetwork"))
 (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
 (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
 (add-hook 'auto-complete-mode-hook 'ac-common-setup)
 (global-auto-complete-mode t))
(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)

(my-ac-config)

(defmacro after (mode &rest body)
  `(eval-after-load ,mode
     '(progn ,@body)))

(after 'auto-complete
       (setq ac-use-menu-map t))

;(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-clang-20120612")
;(require 'auto-complete-clang)

;; Rainbow-mode for edit css-like Files
(add-to-list 'load-path "~/.emacs.d/elpa/rainbow-mode-0.2")
(require 'rainbow-mode)
(rainbow-mode t)

;; Support Qt
;; Enable EDE
(add-to-list 'load-path "~/.emacs.d/elpa/cedet-1.1/common")
(require 'cedet)
(require 'eieio)
(require 'semantic-ia)
(require 'semantic-gcc)
(require 'semantic-c nil 'noerror)
(require 'semanticdb)

;; Enable EDE (Project Management) features
(global-ede-mode 1)
(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-excessive-code-helpers)

;; (setq semanticdb-project-roots (list (expand-file-name "/")))
(defconst cedet-user-include-dirs
          (list ".." "../include" "../inc" "../common" "../public"
                "../.." "../../include" "../../inc" "../../common" "../../public"))
(defconst cedet-include-dirs
            (list "/usr/include"
				  "/usr/local/include"
				  "/usr/include/x86_64-linux-gnu/c++/4.7/bits"
                  "/usr/include/c++/4.7"
                  "/usr/include/c++/4.7/bits"
                  "/usr/include/c++/4.7/tr1"
                  "/usr/include/c++/4.7/tr2"
                  "/usr/include/c++/4.7/backward"
                  "/usr/include/x86_64-linux-gnu"
                  "/opt/Qt5.1.0/5.1.0/gcc_64/include/QtCore"
                  "/opt/Qt5.1.0/5.1.0/gcc_64/include/QtGui"
                  "/opt/Qt5.1.0/5.1.0/gcc_64/include/QtWidgets"
                  "/opt/Qt5.1.0/5.1.0/gcc_64/include/QtNetwork"
                  "/opt/Qt5.1.0/5.1.0/gcc_64/include"))

(semantic-load-enable-gaudy-code-helpers)
(setq include-dirs cedet-user-include-dirs)
(setq include-dirs (append include-dirs cedet-include-dirs))
(let ((include-dirs cedet-user-include-dirs))
    (when (not (eq system-type 'windows-nt))
      (setq include-dirs (append include-dirs cedet-include-dirs)))
    (mapc (lambda (dir)
            (semantic-add-system-include dir 'c++-mode)
            (semantic-add-system-include dir 'c-mode))
          include-dirs))

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

(setq qt4-base-dir "/opt/Qt5.1.0/5.1.0/gcc_64/include/QtCore/")
(semantic-add-system-include qt4-base-dir 'c++-mode)
(add-to-list 'auto-mode-alist (cons qt4-base-dir 'c++-mode))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "qconfig.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "qconfig-dist.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "qglobal.h"))

(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-ci" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c." 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))
(add-hook 'c-mode-common-hook 'my-cedet-hook)

;; rhtml mode
(add-to-list 'load-path "~/.emacs.d/elpa/rhtml")
(require 'rhtml-mode)

;; git-emacs
(add-to-list 'load-path "~/.emacs.d/elpa/magit-20120714")
(require 'magit)

;; coffee-mode
(add-to-list 'load-path "~/.emacs.d/elpa/coffee-mode-20120522")
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(add-to-list 'auto-mode-alist '("\\.ejs$" . rhtml-mode))

;; jedi 配置
(add-to-list 'load-path "~/.emacs.d/elpa/ctable-20131202.2114")
(require 'ctable)
(add-to-list 'load-path "~/.emacs.d/elpa/deferred-20120306")
(require 'deferred)
(add-to-list 'load-path "~/.emacs.d/elpa/concurrent-20130914.536")
(require 'concurrent)
(add-to-list 'load-path "~/.emacs.d/elpa/epc-20130803.2228")
(require 'epc)
(add-to-list 'load-path "~/.emacs.d/elpa/emacs-jedi")
(require 'jedi)
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)			; optional
(setq jedi:complete-on-dot t)		; optional

(global-set-key (kbd "M-/") 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev                 ; 搜索当前 buffer
        try-expand-dabbrev-visible         ; 搜索当前可见窗口
        try-expand-dabbrev-all-buffers     ; 搜索所有 buffer
        try-expand-dabbrev-from-kill       ; 从 kill-ring 中搜索
        try-complete-file-name-partially   ; 文件名部分匹配
        try-complete-file-name             ; 文件名匹配
        try-expand-all-abbrevs             ; 匹配所有缩写词
        try-expand-list                    ; 补全一个列表
        try-expand-line                    ; 补全当前行
        try-complete-lisp-symbol-partially ; 部分补全 elisp symbol
        try-complete-lisp-symbol))         ; 补全 lisp symbol

;; 有同名 buffer 时显示上层目录名称
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(add-to-list 'load-path "~/.emacs.d/elpa/ecb-20130202.1459/")
(require 'ecb)

(add-to-list 'load-path "~/.emacs.d/elpa/")
(require 'auto-header)
(setq header-full-name "Dianchun Huang")
(setq header-email-address "simpleotter23@gmail.com")
(setq header-copyright-notice "
Copyright (c) 2013 Dianchun Huang (simpleotter23@gmail.com)
")
(setq header-update-on-save
      '(filename)
)
(setq header-field-list
      '(filename
         version
         author
         copyright
         created
         description))

;; mew 配置，用于发送和接收邮件
(setq load-path
    (append '("/usr/local/share/emacs/site-lisp/mew")
    load-path))
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

;; 可选步骤
(if (boundp 'read-mail-command)
  (setq read-mail-command 'mew))

;; 可选步骤
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

;; 不删除服务器上的邮件
(setq mew-pop-delete nil)

(setq mew-config-alist
    '(("default"
     ("name"         .  "Dianchun Huang")
     ("user"         .  "pbe_sedm")
     ("smtp-server"  .  "smtp.126.com")
     ("smtp-port"    .  "25")
     ("pop-server"   .  "pop.126.com")
     ("pop-port"     .  "110")
     ("smtp-user"    .  "pbe_sedm")
     ("pop-user"     .  "pbe_sedm")
     ("mail-domain"  .  "126.com")
     ("mailbox-type" .  pop)
     ("pop-auth"     .  pass)
     ("smtp-auth-list" . ("PLAIN" "LOGIN" "CRAM-MD5"))
     )
     ("gmail"
        ("name"         . "Dianchun Huang")
        ("user"         . "simpleotter23")
        ("mail-domain"  . "gmail.com")
        ("proto"        . "+")
        ("pop-ssl"      . t)
        ("pop-ssl-port" . "995")
;       ("prog-ssl"     . "/usr/sbin/stunnel")
        ("pop-auth"     . pass)
        ("pop-user"     . "simpleotter23@gmail.com")
        ("pop-server"   . "pop.gmail.com")
        ("smtp-ssl"     . t)
        ("smtp-ssl-port". "465")
        ("smtp-auth-list" . ("PLAIN" "LOGIN" "CRAM-MD5"))
        ("smtp-user"    . "simpleotter23@gmail.com")
        ("smtp-server"  . "smtp.gmail.com")
        )
))

(setq mew-use-cached-passwd t)
;(setq mew-use-master-passwd t)
(setq mew-charset-m17n "utf-8")
(setq mew-internal-utf-8p t)

(setq mew-signature-file "~/Mail/signature")
(setq mew-signature-as-lastpart t)
(setq mew-signature-insert-last t)
(add-hook 'mew-before-cite-hook 'mew-header-goto-body)
(add-hook 'mew-draft-mode-newdraft-hook 'mew-draft-insert-signature)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(adaptive-fill-mode t)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wombat)))
 '(ecb-options-version "2.40")
 '(fill-column 79)
 '(fill-nobreak-invisible nil)
 '(fill-nobreak-predicate (quote (fill-french-nobreak-p)))
 '(font-use-system-font t)
 '(global-ede-mode t)
 '(global-hl-line-mode t)
 '(global-hl-line-sticky-flag t)
 '(guru-mode nil)
 '(hl-line-sticky-flag t)
 '(indent-guide-char "¦")
 '(indent-guide-global-mode t)
 '(js2-auto-indent-p t)
 '(js2-auto-insert-catch-block t)
 '(js2-bounce-indent-p nil)
 '(js2-cleanup-whitespace t)
 '(js2-concat-multiline-strings t)
 '(js2-enter-indents-newline t)
 '(js2-indent-on-enter-key t)
 '(js2-mirror-mode nil)
 '(mail-host-address "Dianchun Huang")
 '(menu-bar-mode nil)
 '(pop3-leave-mail-on-server t)
 '(pop3-mailhost "pop3.126.com")
 '(pop3-password-required t)
 '(safe-local-variable-values (quote ((encoding . utf-8) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby"))))
 '(save-abbrevs (quote silently))
 '(scroll-bar-mode nil)
 '(semantic-mode t)
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(smtpmail-smtp-server "smtp.126.com")
 '(smtpmail-smtp-service 25)
 '(smtpmail-smtp-user "pbe_sedm")
 '(tool-bar-mode nil)
 '(user-full-name "Dianchun Huang")
 '(user-mail-address "pbe_sedm@126.com"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "apple" :slant normal :weight normal :height 98 :width normal))))
 '(hl-line ((t (:background "#333" :underline nil :weight semi-bold)))))
