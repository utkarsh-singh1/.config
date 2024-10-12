;; ████████╗███████╗██████╗ ███╗   ███╗ █████╗  ██████╗███████╗
;; ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██╔══██╗██╔════╝██╔════╝
;;    ██║   █████╗  ██████╔╝██╔████╔██║███████║██║     ███████╗
;;    ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══██║██║     ╚════██║
;;    ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║  ██║╚██████╗███████║
;;    ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
                                                            


;---------------------------------------------------------------------------------------------------------------------------------;
;                                          Initialize Package and Respositories                                                   ;
;---------------------------------------------------------------------------------------------------------------------------------;


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

;---------------------------------------------------------------------------------------------------------------------------------;
;                                                    Emacs Setup                                                                  ;
;---------------------------------------------------------------------------------------------------------------------------------;

;; Set Startup-modes
(setq inhibit-startup-message t)
(scroll-bar-mode 0)
(set-fringe-style 10)
(tool-bar-mode 0)
(menu-bar-mode 0)
(display-battery-mode t)

;; Put backup file or backup data in another directory instead of creating clutter
(setq backup-directory-alist '((".*" . "~/.Trash")))


;; Line numbers mode
(global-display-line-numbers-mode 1)
(column-number-mode 1)

;; Disable line number for some mode
(dolist (mode '(org-mode-hook
		eshell-mode-hook
		shell-mode-hook
		dired-mode-hhok
		term-mode-hook
		vterm-mode-hook
		vterm-toggle-mode-hook
		neotree-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; key-bindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;--------------------------------------------------------------------------------------------------------------------------------;
;                                       Command-Completion and Themes                                                            ;
;--------------------------------------------------------------------------------------------------------------------------------;


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

(use-package smartparens
  :hook (prog-mode . smartparens-mode))

(use-package nordic-night-theme)

(use-package doom-themes
  :ensure t
  :config
  (load-theme
   'timu-macos t)
  )

(setq mode-line-position (list "(%l,%c)"))

;--------------------------------------------------------------------------------------------------------------------------------;
;                                                 LSP and Completions                                                            ;
;--------------------------------------------------------------------------------------------------------------------------------;

;; Setup LSP with Eglot

(use-package eglot)


;; Completion Pack

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :config
  (setq tab-always-indent 'complete
	corfu-min-width 250
        corfu-min-height 750
        corfu-count 20
        corfu-auto t
        corfu-cycle t
        corfu-separator ?\s
        corfu-preview-current "insert"
        corfu-scroll-margin 25
        ;; shows documentation after `corfu-popupinfo-delay'
        corfu-popupinfo-delay '(1.25 . 0.5))
  )

(corfu-popupinfo-mode 1)

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (nerd-icons-completion-marginalia-setup)
  (nerd-icons-completion-mode 1)
  )

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  )


(use-package go-mode)

