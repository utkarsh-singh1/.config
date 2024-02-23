
;; Basic config file for get started -


;; Set Startup-modes
(setq inhibit-startup-message t)
(scroll-bar-mode 0)
(set-fringe-style 10)
(tool-bar-mode 0)
(menu-bar-mode 0)
(display-battery-mode 1)

;; Put backup file or backup data in another directory instead of creating clutter
(setq backup-directory-alist '((".*" . "~/.Trash")))

;; Set Fonts
(set-face-attribute 'default nil :family "FiraCode Nerd Font Mono" :height 115 )

;; Line numbers mode
(global-display-line-numbers-mode 1)
(column-number-mode 1)

;; Disable line number for some mode
(dolist (mode '(org-mode-hook
		eshell-mode-hook
		shell-mode-hook
		term-mode-hook
		vterm-mode-hook
		vterm-toggle-mode-hook
		treemacs-mode-hook
		neotree-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; key-bindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "s-f") 'toggle-frame-fullscreen)

;; Package Archives - where packages are stored and use-package to fecth them
;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;; Packages for programming-modes
(use-package python-mode
  :hook (python-mode . lsp-deferred))

(use-package go-mode
  :hook (go-mode . lsp-deferred))

(use-package yaml-mode
  :mode "\\.y?ml\\'"
  :hook (yaml-mode . lsp-deferred)
  :config
  (setq lsp-yaml-schemas '(:kubernetes "/*-k8s.yaml"))
  :custom
  (lsp-yaml-completion t)
  )

(use-package web-mode
  :mode "\\.html\\'"
  :hook (web-mode . lsp-deferred)
  :custom
  (lsp-html-auto-closing-tags t)
  )

;; (use-package emmet-mode
;;   :hook (emmet-mode . web-mode)
;;   )

(use-package lua-mode)

(use-package rust-mode)

(use-package zig-mode)

;; LSP-mode
(defun rem/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . rem/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))


(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)

  :custom
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-doc-show)

  :config
  (setq lsp-ui-peek-always-show t)
  (setq	lsp-ui-peek-enable t)
  ;; (setq lsp-ui-sideline-enable t)
  ;; (setq lsp-ui-sideline-show-hover t)
  (setq lsp-ui-peek-peek-height 30)
  )

(use-package lsp-ivy
  :after lsp)


(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . lsp-deferred)) 


;; Use-mode-line or not
;; (use-package mini-echo)

(use-package doom-modeline
  :init
  (doom-modeline-mode t)
  :custom (doom-modeline-height 33)
  )

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-bluloco-dark' t)
  )

(use-package one-themes)

(use-package atom-one-dark-theme)

;; All the themes
;; (use-package timu-macos-theme
;;   :ensure t
;;   ;:config
;;   ;(load-theme 'timu-macos t))

;; (use-package gruvbox-theme
;;   :ensure t
;;   :config
;;   (load-theme 'gruvbox-dark-medium' t))



;; Use-command-completion-and-description-package

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
        ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1)
  )


(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-switch-buffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)
  )


(use-package ivy-rich
  :init
  (ivy-rich-mode t)
  )

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

;; Help of finding keymaps

(use-package which-key
  :init
  (which-key-mode t)
  )

(use-package general
  
  )


;; Git Based Settings

(use-package magit
  :custom  ;; display git diff in same window
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  )

(use-package forge)

(use-package git-gutter)

(use-package blamer)

;; Complete the parenthesis

(use-package smartparens
  :hook (prog-mode . smartparens-mode))

;; Different color for different parenthesis
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package vterm)

(use-package vterm-toggle
  :after vterm
  :bind (
	("C-x M-v" . vterm-toggle)
	 )
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  ;;(display-buffer-reuse-window display-buffer-in-direction)
                  ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                  ;;(direction . bottom)
                  ;;(dedicated . t) ;dedicated is supported in emacs27
                  (reusable-frames . visible)
                  (window-height . 0.4)))
  )

;; (use-package corfu)

;; (use-package vertico)

;; (use-package eglot)


;; File-tree-manager

(use-package neotree
  :bind (
	 ("C-x M-t" . neotree-toggle)
	 )
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 55
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action) 
        ;; truncate long file names in neotree
        (add-hook 'neo-after-create-hook
           #'(lambda (_)
               (with-current-buffer (get-buffer neo-buffer-name)
                 (setq truncate-lines t)
                 (setq word-wrap nil)
                 (make-local-variable 'auto-hscroll-mode)
                 (setq auto-hscroll-mode nil)))))

;; (use-package treemacs)

;; Dashboard

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "/home/utkarsh/.config/emacs/gnu.jpg")  ;; use custom image as banner
  (setq dashboard-center-content t) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  ;; (dashboard-modify-heading-icons '((recents . "file-text")
  ;;                             (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))
