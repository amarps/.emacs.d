(defun amay/open-terminal()
  "open term"
  (interactive)
  (call-process "urxvt" nil 0 nil)
  )

(defun amay/term()
  "open vterm"
  (interactive)
  (split-window-below -15)
  (windmove-down)
  (eshell "/usr/bin/fish")
  (setq term-default-bg-color "#211f21")
  (setq-local face-remapping-alist
              '((default . (:background "#211f21"))))
  )
(global-set-key (kbd "<f1>") 'amay/term)

(defun eshell/clear ()
  "Clear the eshell buffer."
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(use-package eshell
  :bind (("C-q" . kill-buffer-and-window)
	 ("C-l" . eshell/clear))
  :config
  (setq scroll-margin 0)
  
  )

(defun amay/internal-terminal()
  "open internal ansi-term and compilation"
  (interactive)
  (split-window-below -15)
  (windmove-down)
  (ansi-term "/usr/bin/fish")
  (setq-local face-remapping-alist
              '((default . (:background "#1f2026"))))
  ;; (split-window-right)
  ;; (windmove-right)
  ;; (switch-to-buffer "Compilation")
  ;; (compilation-mode)
  ;; (setq-local face-remapping-alist
  ;;             '((default . (:background "#231f24"))))
  )

(defun amay/tall-layout()
  "open internal ansi-term and compilation"
  (interactive)
  (split-window-right -100)
  (windmove-right)
  (split-window-below)
  (split-window-below)
  (windmove-down)
  (windmove-down)
  (split-window-below))

(setq default-frame-alist
       '((height . 25)
         (width . 100)
         (left . 350)
         (top . 200)
         (vertical-scroll-bars . nil)
         (horizontal-scroll-bars . nil)
         (tool-bar-lines . 0)))

(defun amay/dired()
  "open dired"
  (interactive)
  (split-window-right 30)
  (dired ".")
  (setq-local face-remapping-alist
              '((default . (:background "#33343a"))))
  )

(defun amay/layout1()
  "buka banyak window"
  (interactive)
  (delete-other-windows)
  (amay/dired)
  (windmove-right)
  (amay/internal-terminal)
  (windmove-up)
  )

(global-set-key (kbd "M-1") 'amay/layout1)

(defun amay/new-blank-line()
  (interactive)
  (move-end-of-line 1)
  (newline)
  )

(defun amay/run()
  "Run c program"
  (interactive)
  (compile (concat "g++ -g -Wall -Werror " (file-name-nondirectory buffer-file-name)
		   "&& ./a.out"))
  ;; (shell-command (concat "urxvt --hold -e ./a.out > /dev/null &1"))
)

(global-set-key (kbd "<f5>") 'amay/run)

(defun amay/find()
  "find text"
  (interactive)
  (split-window-right)
  (windmove-right)
  (swiper)
  )

;; gui configuration
;; ==============================================================
(setq inhibit-startup-screen t) ;remove startup
(setq imagemagick-types-inhibit t)
(setq-default tab-width 4)
(setq web-mode-enable-current-element-highlight t)
(use-package php-mode)
(add-hook 'web-mode-hook 'lsp)
(add-hook 'js-mode-hook 'lsp)
(add-hook 'css-mode-hook 'lsp)
(add-hook 'php-mode-hook 'lsp)

(scroll-bar-mode -1)    ; Disable visible scrollbar
(tool-bar-mode -1)      ; Disable the toolbar
(tooltip-mode -1)       ; Disable tooltips
(set-fringe-mode 10)    ; Give some breathing room
(menu-bar-mode -1) 	; disable menubar
(toggle-truncate-lines 1)
(auto-revert-mode)


;; highlight line mode
;; (global-hl-line-mode t)

;; hide org tag
(setq org-hide-emphasis-markers t)

;; transparent background
(set-frame-parameter (selected-frame) 'alpha '(99 . 99))

;; save session when quit
;(desktop-save-mode 1)

;; highlight matching parentheses
(show-paren-mode 1)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		ansi-term-mode-hook
		shell-mode-hook
		dired-mode-hook)))

(use-package rainbow-delimiters
  :config
  (rainbow-delimiters-mode)
  )


;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; 
(setq scroll-step            0
      scroll-conservatively  10000)
(setq scroll-margin 13);

;; show eol indicator
(whitespace-newline-mode 1)

;;Set font size
(buffer-face-mode 0)
(set-face-attribute 'default nil :font "Source Code Pro" :height 70)
(set-face-attribute 'fixed-pitch nil :font "Source Code Pro" :height  70)
(set-face-attribute 'font-lock-function-name-face nil :weight 'semibold)
(set-face-attribute 'font-lock-keyword-face nil :weight 'semibold)
(set-face-attribute 'font-lock-function-name-face nil :weight 'semibold)

(set-face-attribute 'mode-line-inactive nil :background "#39363b")

;; package configuration
;; ==============================================================
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(package-initialize)
(setq use-package-verbose t)

;;(use-package almost-mono-themes
;;  :config
  ;; (load-theme 'almost-mono-black t)
  ;; (load-theme 'almost-mono-gray t)
  ;; (load-theme 'almost-mono-cream t)
;;  (load-theme 'almost-mono-white t))

(defun efs/org-font-setup ()
  ;; Replace list hypen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  (setq org-support-shift-select 1)
  (set-face-attribute 'org-block-begin-line nil :foreground "#221f22")
  (set-face-attribute 'org-block nil :background "#221f22")
  (set-face-attribute 'org-block-end-line nil :foreground "#221f22")
  )

(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
)

(use-package org-bullets
  :ensure t
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/brain-dump")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
	  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n#+author: Amar Panji Senjaya\n")
	  :unnarrowed t)
	 ("l" "programming language" plain
	  "* Characteristics\n\n- Family: %?\n- Inspired by: \n\n* Reference:\n\n "
	  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
	  :unnarrowed t)))
  :bind (("C-c n l" . org-roam-buffer-toggle)
		 ("C-c n f" . org-roam-node-find)
		 ("C-c n i" . org-roam-node-insert)
		 :map org-mode-map
		 ("C-M-i"   . completion-at-point)
		 )
  :config
  (org-roam-setup)
  )

(use-package plantuml-mode
  :config
  (setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
  (setq plantuml-default-exec-mode 'jar)

  (setq plantuml-executable-path "/usr/bin/plantuml")
  (setq plantuml-default-exec-mode 'executable)
  )

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode)
  (efs/org-font-setup)
  (setq org-startup-with-inline-images t)
  )

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 150
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package eldoc
  :delight)

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t) (python . t)))

(use-package elpy
  :ensure t
  :init
  (elpy-enable))
(setenv "PYTHONIOENCODING" "utf-8")
(add-to-list 'process-coding-system-alist '("python" . (utf-8 . utf-8)))
(add-to-list 'process-coding-system-alist '("elpy" . (utf-8 . utf-8)))
(add-to-list 'process-coding-system-alist '("flake8" . (utf-8 . utf-8)))

;; themes

;; (use-package doom-modeline
;;   :ensure t
;;   :hook (after-init . doom-modeline-mode)
;;   :config
;;   (setq doom-modeline-height 15)
;;   (setq doom-modeline-icon t))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  (load-theme 'doom-vibrant t)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(set-face-attribute 'font-lock-function-name-face nil :weight 'semibold)
(set-face-attribute 'font-lock-keyword-face nil :weight 'semibold)

;; (use-package edwina
;;   :ensure t
;;   :config
;;   (setq display-buffer-base-action '(display-buffer-below-selected))
;;   ;; (edwina-setup-dwm-keys)
;;   (edwina-mode 1))

;; managing buffer
(use-package perspective
  :bind
  ("C-x k" . persp-kill-buffer*)   ; or use a nicer switcher, see below
  ("C-x b" . persp-switch-to-buffer*)
  :config
  (persp-mode 1)
  (persp-switch "Terminal")
  (persp-switch "Debugger")
  (persp-switch "Other")
  (persp-switch "main")
  )

;; get icon
;; (use-package all-the-icons)

;; realtime syntax checking
(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode)
  )
;; (add-hook 'c-mode-hook (lambda () (setq c-default-style "gnu")))

;; language settings
(electric-indent-mode 1)
(electric-layout-mode 1)
(electric-pair-mode 1)
(setq electric-pair-pairs '((?\< . ?\>)))

(defvar my-cpp-other-file-alist
  '(("\\.cpp\\'" (".hpp" ".ipp"))
    ("\\.ipp\\'" (".hpp" ".cpp"))
    ("\\.hpp\\'" (".ipp" ".cpp"))
    ("\\.cxx\\'" (".hxx" ".ixx"))
    ("\\.ixx\\'" (".cxx" ".hxx"))
    ("\\.hxx\\'" (".ixx" ".cxx"))
    ("\\.c\\'" (".h"))
    ("\\.h\\'" (".c"))
    ))

(setq-default ff-other-file-alist 'my-cpp-other-file-alist)

(add-hook 'c-initialization-hook (lambda ()
    (define-key c-mode-base-map [(meta o)] 'ff-get-other-file))
)
(add-to-list ff-other-file-alist '("\\.cshtml\\'" (".cshtml.cs" ".cshtml.cs")))

(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode)
  (setq projectile-other-file-alist
  '( ;; handle C/C++ extensions
    ("cpp" . ("h" "hpp" "ipp"))
    ("ipp" . ("h" "hpp" "cpp"))
    ("hpp" . ("h" "ipp" "cpp" "cc"))
    ("cxx" . ("h" "hxx" "ixx"))
    ("ixx" . ("h" "hxx" "cxx"))
    ("hxx" . ("h" "ixx" "cxx"))
    ("c"   . ("h"))
    ("m"   . ("h"))
    ("mm"  . ("h"))
    ("h"   . ("c" "cc" "cpp" "ipp" "hpp" "cxx" "ixx" "hxx" "m" "mm"))
    ("cc"  . ("h" "hh" "hpp"))
    ("hh"  . ("cc"))

    ("cshtml" . ("cshtml.cs"))
    ("cshtml.cs" . ("cshtml"))

    ;; OCaml extensions
    ("ml" . ("mli"))
    ("mli" . ("ml" "mll" "mly"))
    ("mll" . ("mli"))
    ("mly" . ("mli"))
    ("eliomi" . ("eliom"))
    ("eliom" . ("eliomi"))

    ;; vertex shader and fragment shader extensions in glsl
    ("vert" . ("frag"))
    ("frag" . ("vert"))

    ;; handle files with no extension
    (nil    . ("lock" "gpg"))
    ("lock" . (""))
    ("gpg"  . (""))
    ))
  (setq projectile-globally-ignored-directories
	'(".idea"
	  ".vscode"
	  ".ensime_cache"
	  ".eunit"
	  ".git"
	  ".hg"
	  ".fslckout"
	  "_FOSSIL_"
	  ".bzr"
	  "_darcs"
	  ".tox"
	  ".svn"
	  ".stack-work"
	  ".ccls-cache"
	  ".cache"
	  ".clangd"
	  "build/"
	  "lib/")
	)
  :bind-keymap
  ("C-p" . projectile-command-map)
  )

(use-package hs-minor-mode
  :bind
  (("C-9" . hs-show-block)
   ("C-0" . hs-hide-block))
  )
;; (use-package winum
;;   :commands winum-mode
;;   :config
;;   (global-set-key (kbd "C-w s") 'winum-select-window-by-number)
;;   (global-set-key (kbd "C-1") 'winum-select-window-1)
;;   (global-set-key (kbd "C-2") 'winum-select-window-2)
;;   (global-set-key (kbd "C-3") 'winum-select-window-3)
;;   (global-set-key (kbd "C-4") 'winum-select-window-4)
;;   (global-set-key (kbd "C-5") 'winum-select-window-5)
;;   (global-set-key (kbd "C-6") 'winum-select-window-6)
;;   (global-set-key (kbd "C-7") 'winum-select-window-7)
;;   (global-set-key (kbd "C-8") 'winum-select-window-8)
;;   (global-set-key (kbd "C-9") 'winum-select-window-9)
;;   )


;; auto complete

(global-unset-key (kbd "C-]"))
(use-package eglot
  :commands eglot
  :config
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (require 'cc-mode)
  (load "/usr/share/clang/clang-format.el")
  (load "/usr/share/clang/clang-rename.el")
  (require 'clang-rename)
  (define-key c++-mode-map (kbd "<tab>") 'clang-format-region)
  (define-key c-mode-base-map (kbd "C-]") 'dumb-jump-go)
  (define-key c-mode-base-map (kbd "C-}") 'dumb-jump-back)
  )


(use-package lsp-mode :commands lsp
   :config
   (add-hook 'csharp-mode 'lsp)
   (define-key lsp-mode-map (kbd "C-]") 'lsp-find-definition)
   )
 (use-package lsp-ui :commands lsp-ui-mode)
 (use-package helm-lsp :commands helm-lsp-workspace-symbol)
(use-package lsp-treemacs
   :commands lsp-treemacs-errors-list
  )
(use-package dap-mode :commands dap-mode)


(add-hook 'go-mode-hook 'lsp)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; (setq lsp-headerline-breadcrumb-enable nil
;;        gc-cons-threshold (* 100 1024 1024)
;;        read-process-output-max (* 1024 1024)
;;        treemacs-space-between-root-nodes nil)

(use-package dotnet
  :ensure t
  :config
  (add-hook 'csharp-mode-hook 'dotnet-mode)
  (add-hook 'fsharp-mode-hook 'dotnet-mode))
(use-package company
  :ensure t
  :config
  (company-mode 1)
  (add-hook 'after-init-hook 'global-company-mode)
  (add-to-list 'company-backends 'company-capf)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-maximum-width 40)

  ;; remove icon
  (setq company-format-margin-function nil)
  )


;; (use-package ccls
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;          (lambda () (require 'ccls) (lsp))))


;; (setq ccls-executable "/bin/ccls")

(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
(add-to-list 'auto-mode-alist '("\\.cshtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(use-package restclient)

(use-package omnisharp
  :config
  (defun omnisharp-setup ()
    ;; (eval-after-load
    ;; 	'company
    ;;   '(add-to-list 'company-backends #'company-omnisharp))
    (omnisharp-mode)
    (company-mode)
    (flycheck-mode)

    (setq indent-tabs-mode nil)
    (setq c-syntactic-indentation t)
    (c-set-style "ellemtel")
    (setq c-basic-offset 4)
    (setq tab-width 4)

    (local-set-key (kbd "C-]") 'omnisharp-go-to-definition)
    (local-set-key (kbd "C-}") 'dumb-jump-back)
    (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
    (local-set-key (kbd "C-c C-c") 'recompile))
  
  (add-hook 'csharp-mode-hook 'omnisharp-setup)
  )

(defun omnisharp-lsp-setup ()
  (lsp)
  (company-mode)
  (flycheck-mode)

  (setq lsp-ui-sideline-enable nil)
  (setq lsp-completion-provider :none)

  (setq indent-tabs-mode nil)
  (setq c-syntactic-indentation t)
  (c-set-style "ellemtel")
  (setq c-basic-offset 4)
  (setq tab-width 4)

  (local-set-key (kbd "C-]") 'lsp-find-declaration)
  (local-set-key (kbd "C-}") 'dumb-jump-back)
  (local-set-key (kbd "C-c C-c") 'recompile))


(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (global-set-key (kbd "C-.") 'yas-expand)
  )

(use-package multiple-cursors
  :diminish
  :bind (
	 ("C-S-c C-S-c" . mc/edit-lines)
	 ("C-n" . mc/mark-next-like-this)
	 ("C-S-n" . mc/mark-previous-like-this)
	 )
  :config
  (multiple-cursors-mode 1)
)

(use-package which-key
  :defer 0
  :delight
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

;; key bind package
(use-package hydra
  :defer t)

(defhydra hydra-switch-buffer  (:timeout 40)
  "switch buffer"
  ("h" previous-buffer "left buffer")
  ("l" next-buffer "rigth buffer")

  ("SPC" hydra-navhjkl/body "back" :exit t))

(defhydra hydra-tools (:timeout 4 :hint nil)
  ("b" compile "compile")
  ("n" make-frame "new win")
  ("s" shell-command "shell")
  ("SPC" hydra-navhjkl/body :exit t)

  ("c" nil "cancel"))

;; easy navigation
(defhydra hydra-navwind (:timeout 4 :hint nil)
"
navwind mode
"
  ("j" windmove-down)
  ("k" windmove-up)
  ("h" windmove-left)
  ("l" windmove-right)
  ("w" other-window)

  ("J" windmove-swap-states-down)
  ("K" windmove-swap-states-up)
  ("H" windmove-swap-states-left)
  ("L" windmove-swap-states-right)
  ("W" window-swap-states)

  ("dj" windmove-delete-down)
  ("dk" windmove-delete-up)
  ("dh" windmove-delete-left)
  ("dl" windmove-delete-right)

  ("n" split-window-vertically)
  ("v" split-window-horizontally)
  ("Q" kill-current-buffer)
  ("q" delete-window)
  ("x" kill-buffer-and-window)

  ("c" nil "cancel"))

(use-package dired
  :hook (dired-mode . dired-hide-details-mode)
  :config
  (define-key dired-mode-map "a" nil)
  (define-key dired-mode-map "af" 'dired-create-empty-file)
  (define-key dired-mode-map "ad" 'dired-create-directory)
  )
  

(use-package dired-open
  :after dired
  :config
  (setq dired-open-extensions '(("png" . "sxiv")
			       ("mkv" . "mpv")
			       ("mp4" . "mpv")
			       ("jpg" . "sxiv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (define-key dired-mode-map "H" 'dired-hide-dotfiles-mode))

(use-package abbrev
  :delight)

(use-package helm-config)
(use-package helm
  :bind ("M-x" . helm-M-x)
  :bind
  (:map helm-map
        ("C-j" . helm-next-line)
        ("C-k" . helm-previous-line))
  (:map helm-find-files-map
        ("C-l" . helm-execute-persistent-action))
  :config
  (when (executable-find "ack-grep")
    (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
          helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

  (helm-mode 1))

;; (use-package counsel :ensure t
;;   :bind (("M-x" . counsel-M-x)))
;; (use-package ivy
;;   :delight
;;   :bind (:map ivy-minibuffer-map
;; 	      ("C-p" . previous-history-element)
;; 	      ("C-j" . ivy-next-line)
;; 	      ("C-k" . ivy-previous-line)
;; 	      ("C-l" . ivy-forward-char)
;; 	      ("C-h" . left-char))
;;   :config
;;   (ivy-mode 1)
;;   )

;; (use-package ivy-rich
;;   :after ivy
;;   :delight
;;   :init
;;   (ivy-rich-mode 1)
;;   )

;(use-package highlight-indent-guides :ensure t)
;(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)


(defhydra hydra-navtab (:timeout 4 :hint nil)
  "*tab mode*"
  ("h" tab-previous)
  ("l" tab-next)
  ("f" tab-bar-select-tab-by-name)

  ("n" tab-new)
  ("q" tab-close)

  ("b" hydra-switch-buffer/body :exit t)
  
  ("c" nil "cancel"))


(defvar __amay-nav-on nil)
(defun amay-nav-toggle()
  (interactive)
  (setq __amay-nav-on (not __amay-nav-on))
  (if __amay-nav-on
      (set-face-attribute 'mode-line nil :background "#503d3d")
      (amay-nav 0)
    )
  (if (not __amay-nav-on)
      (set-face-attribute 'mode-line nil :background "#3d5048")
    (amay-nav 1)
    )
  )

(defhydra hydra-amaynav (:timeout 4 :hint nil)
  ""
  ("<escape>" nil)
  ("C-SPC" nil)
  ("i" amay-nav-toggle)
  ("j" next-line)
  ("k" previous-line)
  ("h" left-char)
  ("l" right-char)
  ("ff" swiper :exit t)
  ("fr" replace-regexp :exit t)
  ("fs" imenu :exit t)
  ("F" amay/find :exit t)
  ("o" find-file :exit t)

  ("J" cua-scroll-up)
  ("K" cua-scroll-down)
  ("H" beginning-of-line)
  ("L" end-of-line)

  ("g" goto-line)

  ("C-h" left-word)
  ( "C-l" right-word)
  ("C-k" backward-paragraph)
  ("C-j" forward-paragraph)
  ("[" pop-to-mark-command)
  ;; ("]" lsp-find-definition)
  ("{" previous-buffer)
  ("}" next-buffer)
  ("m" (kbd "<mouse-1>"))
  
  ("u" undo)
  ("RET" amay/new-blank-line)
  ("a" mark-whole-buffer)
  ("s" save-buffer :exit t)
  ("Q" kill-buffer)
  ("q" delete-window)
  
  ("de" kill-line)
  ("dd" kill-whole-line)
  ("dw" kill-word)
  ("dW" backward-kill-word)
  ("z" newline)
  ("w" next-window-any-frame)
  ("W" previous-window-any-frame)

  (":w" save-buffer)
  (":q" kill-buffer-and-window)

  ("t" amay/open-terminal)

  ("x" delete-char)
  ("vp" mark-paragraph)
  ("vv" set-mark-command)
  ("vs" mark-sexp)
  ("vw" mark-word)
  ("y" kill-ring-save)
  ("X" kill-buffer-and-window)
  ("X" kill-region)
  ("p" yank)
  ("/" comment-line)
  )

;; enable easy copas
(cua-mode 1)

(global-unset-key (kbd "C-SPC"))
(global-unset-key (kbd "C-w"))
(global-unset-key (kbd "C-d"))
(global-unset-key (kbd "C-s"))
(global-unset-key (kbd "C-f"))

;; key binding
(global-set-key (kbd "C-f f") 'helm-find-files)
(global-set-key (kbd "C-f a") 'ff-get-other-file)
(global-set-key (kbd "C-f r") 'helm-regexp)
(global-set-key (kbd "C-f s") 'helm-imenu)
(global-set-key (kbd "C-S-f") 'amay/find)
(global-set-key (kbd "C-o") 'find-file)

;; (global-set-key (kbd "M-[") 'pop-to-mark-command)
;; (global-set-key (kbd "M-]") 'lsp-find-definition)

(global-set-key (kbd "<escape>") 'hydra-amaynav/body)
(global-set-key (kbd "C-SPC") 'hydra-amaynav/body)
(global-set-key (kbd "C-u") 'hydra-amaynav/body)

(global-set-key (kbd "") 'hydra-navhjkl/body)
(global-set-key (kbd "C-j") 'goto-line)

(global-set-key (kbd "C-w N") 'make-frame)
(global-set-key (kbd "C-w n") 'split-window-below)
(global-set-key (kbd "C-w v") 'split-window-right)

(global-set-key (kbd "C-w q") 'delete-window)
(global-set-key (kbd "C-w C-h") 'windmove-left)
(global-set-key (kbd "C-w C-j") 'windmove-down)
(global-set-key (kbd "C-w C-k") 'windmove-up)
(global-set-key (kbd "C-w C-l") 'windmove-right)

(winner-mode)
(global-set-key (kbd "C-w z") 'winner-undo)
(global-set-key (kbd "C-w r") 'winner-redo)
(global-set-key (kbd "C-w w") 'next-window-any-frame)
(global-set-key (kbd "C-w W") 'previous-window-any-frame)

;; (global-set-key (kbd "C-s d") 'lsp-describe-thing-at-point)
(global-set-key (kbd "C-s r") 'xref-find-references)

(global-set-key (kbd "C-b") 'compile)

(global-set-key (kbd "C-t") 'hydra-navtab/body)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6b1abd26f3e38be1823bd151a96117b288062c6cde5253823539c6926c3bb178" default))
 '(package-selected-packages
   '(rust-mode terraform-mode dockerfile-mode elpy anaconda-mode org-roam protobuf-mode lsp-python-ms python-mode go-imenu treemacs-projectile go-mode lua-mode php-mode ztree yasnippet-snippets yaml-mode winum which-key web-mode vterm visual-fill-column use-package sr-speedbar smooth-scrolling restclient-helm rainbow-delimiters projectile plantuml-mode perspective org-pdftools org-edit-latex org-bullets omnisharp neotree multiple-cursors magit lsp-ui lsp-p4 lsp-ivy ivy-rich highlight-indent-guides helm-lsp helm-google helm-company guru-mode google-this google-c-style global-tags ggtags general frames-only-mode flycheck-google-cpplint flycheck-clang-tidy exwm ewal-doom-themes evil eldoc-cmake eglot edwina dumb-jump dotnet doom-modeline dired-open dired-hide-dotfiles delight dap-mode csproj-mode counsel company-c-headers company-auctex command-log-mode color-theme-modern color-theme-buffer-local cmake-mode chess ccls buttons buffer-buttons autothemer auto-complete-auctex almost-mono-themes all-the-icons-ivy all-the-icons-dired ack)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
