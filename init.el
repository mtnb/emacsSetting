(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/yasnippet"))
(setq yas-snippet-dirs '("~/.emacs.d/yasnippet-snippets" "~/.emacs.d/mysnippets"))
(require 'yasnippet)
(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete")
(require 'auto-complete)
(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
(global-auto-complete-mode t)

(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(auto-save-list-file-prefix nil)
 '(indent-tabs-mode nil)
 '(make-backup-files nil)
 '(scalable-fonts-allowed t)
 '(tab-always-indent nil)
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-face-tag ((t (:foreground "color-43"))))
 '(custom-group-tag ((t (:inherit variable-pitch :foreground "brightyellow" :weight bold :height 1.2))))
 '(custom-variable-tag ((t (:foreground "blue" :weight bold))))
 '(font-lock-doc-face ((t (:inherit font-lock-string-face))))
 '(font-lock-function-name-face ((t (:foreground "brightmagenta"))))
 '(font-lock-string-face ((t (:foreground "brightgreen"))))
 '(minibuffer-prompt ((t (:foreground "white"))))
 '(whitespace-tab ((t (:background "color-16" :foreground "brightred" :underline "brightcyan")))))

;;JS2-mode install
;;(require 'js2-mode)
;;(autoload 'js2-mode "js2" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'autoinsert)
;;template dir
(setq auto-insert-directory "~/.emacs.d/site-lisp/insert/")
;;change template for file val
(setq auto-insert-alist
      (nconc '(
               ("\\.cpp$" . ["template.cpp" my-template])
               ("\\.h$" . ["template.h" my-template])
               ("\\.html$" . ["template.html" my-template])
               ("\\.js$" . ["template.js" my-template])
               ) auto-insert-alist))
(require 'cl)

(defvar template-replacements-alists
  '(("%file%"                .   (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%"   .   (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%include-guard%"      .   (lambda () (format "__SCHEME_%s__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))
    (defun my-template ()
        (time-stamp)
        (mapc #'(lambda(c)
            (progn
                (goto-char (point-min))
                (replace-string (car c) (funcall (cdr c)) nil )))
        template-replacements-alists)
    (goto-char (point-max))
    (message "done."))
(add-hook 'find-file-not-found-hooks 'auto-insert)

(setq auto-mode-alist
      (cons (cons "\\.tss" 'css-mode) auto-mode-alist))

;;
;; whitespace
;;
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
                         empty          ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark
                         ))

(setq whitespace-display-mappings
      '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

(global-whitespace-mode 1)

(add-hook 'css-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-always-indent t)
            ))
(add-hook 'nxml-mode-hook
          (lambda ()
            (setq nxml-child-indent 0)
            (setq indent-tabs-mode t) 
           (setq tab-width 4)
            ))
(add-hook 'js-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-always-indent)
            (setq tab-width 4)
           ))
