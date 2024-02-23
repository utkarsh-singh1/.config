
;; Basic config file for get started -


;; Set Startup-modes
(setq inhibit-startup-message t)
(scroll-bar-mode 0)
(set-fringe-style 10)
(tool-bar-mode 0)
(menu-bar-mode 0)

(display-battery-mode t)
(display-time-mode t)

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

;; Use this keybinding temporarily for maximze Emacs to its full screen potential
;; (global-set-key (kbd "s-f") 'toggle-frame-fullscreen)
;; (if (getenv "XDG_SESSION_DESKTOP" 'KDE)
;;     (global-set-key (kbd "s-f") 'toggle-frame-fullscreen))


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
  (load-theme 'doom-snazzy t)
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

;; (use-package general

;;   :config
;;   (general-create-definer basic/leader-keys
;;     :keymaps '(normal insert visual emacs)
;;     :prefix "SPC" ;; Set Space as leader key
;;     :global-prefix "C-SPC") ;; Access leader key in Insert mode


;;   ;; Options Keymaps
;;   (basic/leader-keys
;;     "o" '(:ignore t :which-key "Options")
;;     "o t" '(counsel-load-theme :which-key "choose theme")
;;     )
  
;;   )


;; (use-package evil
;;   :init
;;   (setq evil-want-integration t)
;;   (setq evil-want-keybinding nil)
;;   (setq evil-want-C-u-scroll t)
;;   (setq evil-want-C-i-jump nil)
;;   (setq evil-vsplit-window-right t)
;;   (setq evil-split-window-below t)

;;   ;; (setq evil-respect-visual-line-mode t)
;;   ;; (setq evil-undo-system 'undo-tree)
;;   ;; :hook (evil-mode . rem/evil-hook)

;;   :config
;;   (evil-mode 1)
;;   (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
;;   (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

;;   ;; Use visual line motions even outside of visual-line-mode buffers
;;   (evil-global-set-key 'motion "j" 'evil-next-visual-line)
;;   (evil-global-set-key 'motion "k" 'evil-previous-visual-line)


;;   (evil-set-initial-state 'messages-buffer-mode 'normal)
;;   (evil-set-initial-state 'dashboard-mode 'normal))


;; (use-package evil-collection
;;   :after evil
;;   :config
;;   (evil-collection-init)
;;   )

(use-package projectile)



;; Git Based Settings

(use-package magit
  :custom  ;; display git diff in same window
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  )

(use-package forge)

(use-package git-gutter

  :hook ((text-mode . git-gutter-mode)
	 (prog-mode . git-gutter-mode))
  :config
  (setq git-gutter:update-interval 0.02)

  )

(use-package git-gutter-fringe
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

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
        neo-theme (if (display-graphic-p) 'icons)
        ;; truncate long file names in neotree
        (add-hook 'neo-after-create-hook
           #'(lambda (_)
               (with-current-buffer (get-buffer neo-buffer-name)
                 (setq truncate-lines t)
                 (setq word-wrap nil)
                 (make-local-variable 'auto-hscroll-mode)
                 (setq auto-hscroll-mode nil)))))

;; ;; Org-Mode setup

;; Turn on indentation and auto-fill mode for Org files
(defun bs/org-mode-setup ()
  (org-indent-mode)
  ;;(variable-pitch-mode 1)
  ;;(auto-fill-mode 0)
  (visual-line-mode 1))
  ;;(setq evil-auto-indent nil))

(use-package org
  ;; :defer t
  :hook (org-mode . bs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t)

  (setq org-directory "~/Tasks&Agenda")
  
  (setq org-agenda-files
	'("Tasks.org" "Birthdays.org" "Target.org"
	  "~/local-work-space/workspace/Go-workspace/src/Go-training/00_Get-Started/org-mode-tutorial.org"))

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  

  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))


  
  )


(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun bs/org-mode-visual-fill ()
  (setq visual-fill-column-width 150
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . bs/org-mode-visual-fill))


;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-banner-logo-title "Editor of the century")
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-startup-banner "~/.config/emacs/Gnu-listen-half.jpg")
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        ;; (projects . 3)
                        (agenda . 3)
                        (registers . 3)))
  (setq dashboard-icon-type 'all-the-icons) 
)

