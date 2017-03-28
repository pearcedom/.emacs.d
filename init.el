(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; use pacakge functionality
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (setq use-package-always-ensure t)
  (require 'use-package)
  )

(use-package diminish)

;; me
(setq user-full-name "Dominic Pearce"
            user-mail-address "dominic.pearce@outlook.com")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#110F13" "#B13120" "#719F34" "#CEAE3E" "#7C9FC9" "#7868B5" "#009090" "#F4EAD5"])
 '(custom-enabled-themes (quote (molokai)))
 '(custom-safe-themes
   (quote
	("bc40f613df8e0d8f31c5eb3380b61f587e1b5bc439212e03d4ea44b26b4f408a" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "cdf96318f1671344564ba74ef75cc2a3f4692b2bee77de9ce9ff5f165de60b1f" "a4bd55761752bddac75bad0a78f8c52081a1effb33b69354e30a64869b5a40b9" "9f3181dc1fabe5d58bbbda8c48ef7ece59b01bed606cfb868dd147e8b36af97c" "b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" default)))
 '(fci-rule-character-color "#202020")
 '(fci-rule-color "#202020")
 '(fringe-mode 4 nil (fringe))
 '(main-line-color1 "#1E1E1E")
 '(main-line-color2 "#111111")
 '(main-line-separator-style (quote chamfer))
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(vc-annotate-background "#181e26")
 '(vc-annotate-color-map
   (quote
	((20 . "#98be65")
	 (40 . "#afaf6c")
	 (60 . "#d7af79")
	 (80 . "#ECBE7B")
	 (100 . "#f1a179")
	 (120 . "#e4946c")
	 (140 . "#da8548")
	 (160 . "#d78787")
	 (180 . "#d787af")
	 (200 . "#c678dd")
	 (220 . "#e479af")
	 (240 . "#f16c87")
	 (260 . "#ff6c6b")
	 (280 . "#d25a5a")
	 (300 . "#a65656")
	 (320 . "#7a5252")
	 (340 . "#525252")
	 (360 . "#525252"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'ess-site)

;; line numbers
;; (global-linum-mode t)

;; bracket matching
(electric-pair-mode 1)

;; bracket matching
(use-package rainbow-delimiters
	     :config
	     (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
	     )

;; linting
(use-package flycheck
  :init
  (add-hook 'prog-mode-hook (lambda () (flycheck-mode)))
  )

;; line width
(setq-default fill-column 120)

;; cursor line highlighting
;; (global-hl-line-mode)

;; highlight git changes
(use-package git-gutter+
  :config
  (global-git-gutter+-mode)
  )

;; command suggestions
(use-package which-key
  :diminish which-key-mode
  :init
  (setq which-key-idle-delay 2.5)
  (which-key-mode)
  )

;; easy yes or no prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;; double check quit
(setq confirm-kill-emacs 'y-or-n-p)

;; collect and store backups together
					; From http://www.emacswiki.org/emacs/BackupDirectory
					; and http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq
 backup-by-copying t ; Ensure backups are copied, not renamed. Important for symlinks
 backup-directory-alist '(("" . "~/.emacs-backups")) ; Keep backups in ~/.emacs-backups, not the same directory tree
 delete-old-versions t ; Delete old versions without prompting
 kept-new-versions 10 ; Keep multiple versioned backup files
 kept-old-versions 0 ; Don't keep any beyond that
 version-control t) ; Use versioned backups

(setq vc-make-backup-files t) ; Backup even when it's a version controlled project

;; font size
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
;; C-x C-0 restores the default font size

;; don't show default start screen
(setq inhibit-startup-message t)

;; tabs as spaces
(setq-default tab-width 4)
					;(setq-default tab-always-indent 'complete)

;; auto indentation
(electric-indent-mode)


;; visible terminal bell
(setq visible-bell 1)

;; emojis
(use-package emojify
  :init
  (add-hook 'org-mode-hook 'emojify-mode))

;; smooth scroll
(setq scroll-step 1)
(setq scroll-conservatively 10000)

;; pane movement
(windmove-default-keybindings 'meta)
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <down>") 'windmove-down)

;; yaml highlighting
(use-package yaml-mode)

;; code folding
(use-package yafolding
  :config
  (add-hook 'prog-mode-hook (lambda()  (yafolding-mode)))
  )

;; mouse support for terminals
(when (not (window-system))
  (xterm-mouse-mode +1))

;; recent files!
(use-package recentf
  :diminish
  :config
  (recentf-mode)
  :bind
  ("C-x C-r" . recentf-open-files)
  )

;;git
(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  )

;; spell check
(add-hook 'prog-mode-hook (lambda () (flyspell-prog-mode)))
(add-hook 'text-mode-hook (lambda () (flyspell-mode)))

(eval-after-load "flyspell"
  '(progn
										;     (define-key flyspell-mouse-map [down-mouse-2] nil)
										;     (define-key flyspell-mouse-map [mouse-2] #'flyspell-correct-word))
	 (add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
	 (add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
	 )
  )

;; snippets
(use-package yasnippet
  :config (yas-global-mode 1)
  )


;; soft wrap lines
(autoload 'longlines-mode "longlines.el" "Minor mode for editing long lines." t)

;; allow uppercase conversion
(put 'upcase-region 'disabled nil)

;; prose linting
(flycheck-define-checker proselint
						 "A linter for prose."
						 :command ("proselint" source-inplace)
						 :error-patterns
						 ((warning line-start (file-name) ":" line ":" column ": "
								   (id (one-or-more (not (any " "))))
								   (message) line-end))
						 :modes (text-mode markdown-mode org-mode))
(add-to-list 'flycheck-checkers 'proselint)

(add-to-list 'load-path "~/.emacs.d/julia-shell-mode/")
(require 'julia-shell)

(defun my-julia-mode-hooks ()
  (require 'julia-shell-mode))
(add-hook 'julia-mode-hook 'my-julia-mode-hooks)
(define-key julia-mode-map (kbd "C-c C-c") 'julia-shell-run-region-or-line)
(define-key julia-mode-map (kbd "C-c C-s") 'julia-shell-save-and-go)


;; neotree for project file/folder display
(add-to-list 'load-path "~/.emacs.d/neotree")
  (require 'neotree)
  (global-set-key [f8] 'neotree-toggle)

;; dashboard on start up
(require 'dashboard)
(dashboard-setup-startup-hook)


;; minimap
(require 'sublimity)
;; (require 'sublimity-scroll)
;; (require 'sublimity-map) ;; experimental
;; (require 'sublimity-attractive)
;; (sublimity-mode 1)

;; multiple cursors
(require 'multiple-cursors)

;; jedi for python
(add-hook 'python-mode-hook 'jedi:setup)

;; powerline
(require 'powerline)
(powerline-default-theme)

;; mode icons
;;(require 'mode-icons)

;; smex
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
										; when Smex is auto-initialized on its first run.

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(fringe-mode 0)


;;powerline
;;add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
;;(require 'powerline)
;;(require 'cl)
