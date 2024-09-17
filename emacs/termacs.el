
;; ████████╗███████╗██████╗ ███╗   ███╗ █████╗  ██████╗███████╗
;; ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██╔══██╗██╔════╝██╔════╝
;;    ██║   █████╗  ██████╔╝██╔████╔██║███████║██║     ███████╗
;;    ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══██║██║     ╚════██║
;;    ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║  ██║╚██████╗███████║
;;    ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
                                                            



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

(use-package doom-themes
  :ensure t
  :config
  (load-theme
   ;;'doom-vibrant t)
   ;;'doom-gruvbox-light t)
   ;;'timu-macos t)
   'nordic-night t)
  )

(setq mode-line-position (list "(%l,%c)"))

