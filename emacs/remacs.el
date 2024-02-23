
;; ██████╗ ███████╗███╗   ███╗ █████╗  ██████╗███████╗
;; ██╔══██╗██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝
;; ██████╔╝█████╗  ██╔████╔██║███████║██║     ███████╗
;; ██╔══██╗██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║
;; ██║  ██║███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║
;; ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                                   

;; ╔═╗╔═╗╔╦╗╔╦╗╦╔╗╔╔═╗╔═╗
;; ╚═╗║╣  ║  ║ ║║║║║ ╦╚═╗
;; ╚═╝╚═╝ ╩  ╩ ╩╝╚╝╚═╝╚═╝


;; Don't show front page
(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar
(display-time-mode 1)
;; (display-battery-mode 1)

;; Set up the visible bell
(setq visible-bell t)


;; Font Settings
(set-face-attribute 'default nil :font "Fira Code Nerd Font Mono" :height 120)
(set-face-attribute 'fixed-pitch nil :font "FantasqueSansMono Nerd Font" :height 120)
(set-face-attribute 'variable-pitch nil :font "BlexMono Nerd Font Mono" :height 120)



;; ╦╔═╔═╗╦ ╦╔╗ ╦╔╗╔╔╦╗╦╔╗╔╔═╗╔═╗
;; ╠╩╗║╣ ╚╦╝╠╩╗║║║║ ║║║║║║║ ╦╚═╗
;; ╩ ╩╚═╝ ╩ ╚═╝╩╝╚╝═╩╝╩╝╚╝╚═╝╚═╝

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; My M-x key is kinda lost in kde ,So...
;; (global-set-key (kbd "M-s") 'execute-extended-command)

;; Use this keybinding temporarily for maximze Emacs to its full screen potential
(global-set-key (kbd "s-f") 'toggle-frame-fullscreen)



;; Display Line number

(column-number-mode)
(global-display-line-numbers-mode t)
;; (menu-bar--display-line-numbers-mode-relative)

;; Disable line number for some mode
(dolist (mode '(org-mode-hook
		eshell-mode-hook
		shell-mode-hook
		term-mode-hook
		vterm-mode-hook
		vterm-toggle-mode-hook
		treemacs-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; ╔═╗╔═╗╔═╗╦╔═╔═╗╔═╗╔═╗  ╔═╗╔═╗╔╦╗╔╦╗╦╔╗╔╔═╗╔═╗
;; ╠═╝╠═╣║  ╠╩╗╠═╣║ ╦║╣───╚═╗║╣  ║  ║ ║║║║║ ╦╚═╗
;; ╩  ╩ ╩╚═╝╩ ╩╩ ╩╚═╝╚═╝  ╚═╝╚═╝ ╩  ╩ ╩╝╚╝╚═╝╚═╝

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


;; ╔═╗╔╦╗╔═╗╔═╗╔═╗   ╔═╗╔═╗╔═╗ ╔═╗╔═╗╔╗╔╔═╗╦╔═╗
;; ║╣ ║║║╠═╣║  ╚═╗───╠═╝╠═╣║───║  ║ ║║║║╠╣ ║║ ╦
;; ╚═╝╩ ╩╩ ╩╚═╝╚═╝   ╩  ╩ ╩╚═╝ ╚═╝╚═╝╝╚╝╚  ╩╚═╝


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
  (ivy-mode 1))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))


(use-package counsel
  :bind (("M-s" . counsel-M-x)
         ("C-x b" . counsel-switch-buffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't searches with '

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))


(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3
	;; which-key-side-window-location 'bottom
	;; which-key-sort-order #'which-key-key-order-alpha
	;; which-key-sort-uppercase-first nil
	;; which-key-add-column-padding 1
	;; which-key-max-display-columns nil
	;; which-key-min-display-lines 6
	;; which-key-side-window-slot -10
	;; which-key-side-window-max-height 0.25
	;; which-key-max-description-length 25
	;; which-key-allow-imprecise-window-fit t
	;; which-key-separator " → "
	))	

(use-package general
  :config
  (general-create-definer rem/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC" ;; Set Space as leader key
    :global-prefix "C-SPC") ;; Access leader key in Insert mode

  (rem/leader-keys
    "o" '(:ignore t :which-key "Options")
    "o t" '(counsel-load-theme :which-key "choose theme")
    )

  (rem/leader-keys
    "b"  '(:ignore t :wk "Buffers")
    "b b" '(counsel-switch-buffer :wk "switch buffers")
    "b k" '(kill-buffer :wk "kill this buffer")
    "b i" '(ibuffer :wk "Ibuffers")
    "b n" '(next-buffer :wk "next buffer")
    "b p" '(previous-buffer :wk "previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer")
   )

  (rem/leader-keys
    "e"   '(:ignore t :which-key "eval")
    "e b"  '(eval-buffer :which-key "Evaluate current buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e h" '(counsel-esh-history :which-key "Eshell history")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e r" '(eval-region :wk "Evaluate elisp in region")
    "e s" '(eshell :which-key "Eshell")) 

  (rem/leader-keys
    "w"   '(:ignore t :which-key "evil-window")

    ;; Handle window split
    "w v" '(evil-window-vsplit :which-key "split window vertically")
    "w s" '(evil-window-split :which-key "split window horizontally")
    "w c" '(evil-window-delete :which-key "delete current split window")
    "w n" '(evil-window-new :which-key "Open completely new window")

    ;; window motion
    "w h" '(evil-window-left :which-key "move cursor/focus to left window")
    "w j" '(evil-window-down :which-key "move cursor/focus to down window")
    "w k" '(evil-window-up :which-key "move cursor/focus to up window")
    "w l" '(evil-window-right :which-key "move cursor/focus to down window")

    ;; literally move windows
    "w H" '(buf-move-left :wk "Move current window to left")
    "w L" '(buf-move-right :wk "Move current window to right")
    "w J" '(buf-move-down :wk "Move current window to down")
    "w K" '(buf-move-up :wk "Move current window to up")

    ;; Resize window size
    "w <right>" '(evil-window-increase-width :wk "Increase current window width")
    "w <left>"  '(evil-window-decrease-width :wk "Decrease current window width")
    "w <up>"    '(evil-window-increase-height :wk "Increase current window height")
    "w <down>"  '(evil-window-decrease-height :wk "Decrease current window height")
    )

  (rem/leader-keys

    ;; EAF
    "x" '(:ignore t :wk "EAF")

    ;; EAF-browser
    "xb" '(eaf-open-browser :wk "Open eaf browser")
    

  ;; EAF-Markdown-preview
    "xm" '(eaf-markdown-previewer-open :wk "Open markdown previewer")
  )
)



;; (defun rem/evil-hook ()
;;   (dolist (mode '(custom-mode
;;                   eshell-mode
;;                   git-rebase-mode
;;                   erc-mode
;;                   circe-server-mode
;;                   circe-chat-mode
;;                   circe-query-mode
;;                   sauron-mode
;;                   term-mode))
;;   (add-to-list 'evil-emacs-state-modes mode)))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)

  ;; (setq evil-respect-visual-line-mode t)
  ;; (setq evil-undo-system 'undo-tree)
  ;; :hook (evil-mode . rem/evil-hook)

  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)


  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))


(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
  )

;; Setup transiet key-bindings
;; Means a pop-up will appear that allow us to perform certain action using some keys for a temporary period

(use-package hydra)


;; Here i want a increase in test scale , using j,k,l for a certain period of time (:timeout 4 --->>> means the pop-menu after doing M-x hydra-text-scale/body will remain for 4 sec without any input , after it will disappear.


(defhydra hydra-text-scale (:timeout 4)
  "scale-text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(rem/leader-keys
 "ts" '(hydra-text-scale/body :which-key "scale text"))



;; ╔╦╗╔═╗╦  ╦   ╔═╗╦═╗╔═╗╔═╗
;;  ║║║╣ ╚╗╔╝───╠═╣╠╦╝║╣ ╠═╣
;; ═╩╝╚═╝ ╚╝    ╩ ╩╩╚═╚═╝╩ ╩


(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init

  (when (file-directory-p "~/workspace")
    (setq projectile-project-search-path '("~/workspace")))
  (setq projectile-switch-project-action #'projectile-dired)

  (when (file-directory-p "~/local-workspace/src")
    (setq projectile-project-search-path '("~/local-workspace/src")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))



(use-package magit
  ;; :bind ("C-M-;" . magit-status)
  ;; :commands (magit-status magit-get-current-branch)
 :custom  ;; display git diff in same window
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))


;; Learn About forge here first - https://magit.vc/manual/forge.html
;; https://magit.vc/manual/forge.html
;; https://magit.vc/manual/forge.html#Token-Creation
(use-package forge)


;; ╔═╗╦═╗╔═╗   ╔═╗╔═╗╔╦╗╦ ╦╔═╗
;; ║ ║╠╦╝║ ╦───╚═╗║╣  ║ ║ ║╠═╝
;; ╚═╝╩╚═╚═╝   ╚═╝╚═╝ ╩ ╚═╝╩  


;; Turn on indentation and auto-fill mode for Org files
(defun rem/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  ;;(auto-fill-mode 0)
  (visual-line-mode 1))
  ;;(setq evil-auto-indent nil))

(use-package org
  ;; :defer t
  :hook (org-mode . rem/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; (dolist (face '((org-level-1 . 1.3)
;;                 (org-level-2 . 1.1)
;;                 (org-level-3 . 1.05)
;;                 (org-level-4 . 1.0)
;;                 (org-level-5 . 1.1)
;;                 (org-level-6 . 1.1)
;;                 (org-level-7 . 1.1)
;;                 (org-level-8 . 1.1)))
;;   (set-face-attribute (car face) nil :font "FiraCode Nerd font" :weight 'medium :height (cdr face)))

;; ;; ;; ;; Ensure that anything that should be fixed-pitch in Org files appears that way
;; (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
;; ;; (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
;; (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
;; ;; (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
;; (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
;; (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
;; (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
;; (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

(defun rem/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  ;;:defer t
  :hook (org-mode . rem/org-mode-visual-fill))



;; ╔╦╗╦ ╦╔═╗╔╦╗╔═╗╔═╗
;;  ║ ╠═╣║╣ ║║║║╣ ╚═╗
;;  ╩ ╩ ╩╚═╝╩ ╩╚═╝╚═╝

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 35)))

;; More themes can be found here (Search it on google - Peach Melpa)
;; Or go to Emacs-Theme

(use-package doom-themes
  :init (load-theme
	 ;;'doom-dracula t
	 'doom-snazzy t 
	 ;; 'doom-vibrant t
	 ))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; M-x all-the-icons-install-fonts
(use-package all-the-icons)

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(use-package rainbow-mode
  :hook (org-mode prog-mode))


;; Dashboard

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "/home/utkarsh/.config/emacs/gnu.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  (dashboard-modify-heading-icons '((recents . "file-text")
                              (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))


;; ╦  ╔═╗╔═╗   ╔╦╗╔═╗╔╦╗╔═╗  ╔═╗╔═╗╔╦╗╦ ╦╔═╗
;; ║  ╚═╗╠═╝───║║║║ ║ ║║║╣───╚═╗║╣  ║ ║ ║╠═╝
;; ╩═╝╚═╝╩     ╩ ╩╚═╝═╩╝╚═╝  ╚═╝╚═╝ ╩ ╚═╝╩ 


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

(use-package lsp-treemacs
  :after lsp)


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

(use-package go-mode
  :hook (go-mode . lsp-deferred))


;; (use-package python-mode
;;   :ensure t
;;   :hook (python-mode . lsp)
;;   ;; :custom
;;   ;; NOTE: Set these if Python 3 is called "python3" on your system!
;;   ;; (python-shell-interpreter "python3")
;;   ;; (dap-python-executable "python3")
;;   ;; (dap-python-debugger 'debugpy)
;;   ;; :config
;;   ;; (require 'dap-python)
;; )

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . lsp-deferred)) 
					; or lsp 


(use-package yaml-mode
  :mode "\\.y?ml\\'"
  :hook (yaml-mode . lsp-deferred))

(use-package k8s-mode
  :mode "\\.y?ml\\'"
  :hook (k8s-mode . lsp)
)

(use-package markdown-mode
  ;; :straight t
  :mode "\\.md\\'"
  :config
  (setq markdown-command "marked")
  (defun rem/set-markdown-header-font-sizes ()
    (dolist (face '((markdown-header-face-1 . 1.2)
                    (markdown-header-face-2 . 1.1)
                    (markdown-header-face-3 . 1.0)
                    (markdown-header-face-4 . 1.0)
                    (markdown-header-face-5 . 1.0)))
      (set-face-attribute (car face) nil :weight 'normal :height (cdr face))))

  (defun rem/markdown-mode-hook ()
    (rem/set-markdown-header-font-sizes))

  (add-hook 'markdown-mode-hook 'rem/markdown-mode-hook))

(use-package lua-mode
  :hook (lua-mode . lsp)
)

(use-package smartparens
  :hook (prog-mode . smartparens-mode))

;; (use-package lsp-dart
;;   :hook (dart-mode . lsp)
;; )

;; (use-package dap-mode 
;;   :custom
;;   (lsp-enable-dap-auto-configure nil)
;;   :config
;;   (dap-ui-mode 1)
;;   (dap-tooltip-mode 1)
;;   (require 'dap-dlv-go)
;;   (dap-dlv-go-debug-in-vterm))

;; (add-hook 'emacs-lisp-mode-hook #'flycheck-mode)



(use-package sudo-edit
  :config
    (rem/leader-keys
      "fu" '(sudo-edit-find-file :wk "Sudo find file")
      "fU" '(sudo-edit :wk "Sudo edit file")))


(use-package vterm
:config
(setq shell-file-name "/bin/fish"
      vterm-max-scrollback 5000))

(use-package vterm-toggle
  :after vterm
  :config
  (rem/leader-keys
    "v"  '(:ignore t :wk "Vterm-toggle")
    "vs" '(vterm-toggle-show :wk "Show vterm buffer")
    "vh" '(vterm-toggle-hide :wk "Hide vterm buffer")
  )
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
                  (window-height . 0.5)))
  )


(use-package git-gutter
  :hook ((text-mode . git-gutter-mode)
	 (prog-mode . git-gutter-mode))
  :config
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(use-package blamer
  :hook (prog-mode . global-blamer-mode)
  :custom
  (blamer-max-commit-message-length 100)
  )


(use-package treemacs
  :config
  (rem/leader-keys
    "t"  '(:ignore              :wk "Treemacs")
    "tt" '(treemacs             :wk "Toggle treemacs frame")
    "ta" '(treemacs-create-file :Wk "Create a new file")
    "ts" '(treemacs-create-dir  :wk "Create a new Directory")
    "tr" '(treemacs-rename-file :wk "Rename any file/folder in treemacs")
    "tb" '(treemacs-delete-file :wk "Delete any file/folder in treemacs")
    )
)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
(require 'eaf)
(require 'eaf-browser)
(require 'eaf-markdown-previewer)
(require 'eaf-terminal)
(require 'eaf-jupyter)
;; ╦ ╦╦╔╗╔╔╦╗╔═╗╦ ╦╔═╗  ╔╦╗╔═╗╔╦╗╦╔═╗╔╗╔
;; ║║║║║║║ ║║║ ║║║║╚═╗  ║║║║ ║ ║ ║║ ║║║║
;; ╚╩╝╩╝╚╝═╩╝╚═╝╚╩╝╚═╝  ╩ ╩╚═╝ ╩ ╩╚═╝╝╚╝


(require 'windmove)

;;;###autoload
(defun buf-move-up ()
  "Swap the current buffer and the buffer above the split.
If there is no split, ie now window above the current one, an
error is signaled."
;;  "Switches between the current buffer, and the buffer above the
;;  split, if possible."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'up))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No window above this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-down ()
"Swap the current buffer and the buffer under the split.
If there is no split, ie now window under the current one, an
error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'down))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (or (null other-win) 
            (string-match "^ \\*Minibuf" (buffer-name (window-buffer other-win))))
        (error "No window under this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-left ()
"Swap the current buffer and the buffer on the left of the split.
If there is no split, ie now window on the left of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'left))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No left split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-right ()
"Swap the current buffer and the buffer on the right of the split.
If there is no split, ie now window on the right of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'right))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No right split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))
