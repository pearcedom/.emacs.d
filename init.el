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
 '(custom-enabled-themes (quote (molokai)))
 '(custom-safe-themes
   (quote
    ("b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" default))))
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
(windmove-default-keybindings)
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
