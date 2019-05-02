;;; package --- Emacs configuration

;;; Commentary:
;;; This is a hopefully OS agnostic installation file for
;;; Emacs.  It is designed to simply be put on a host machine and work
;;; without any manual intervention.

;;; Code:

;; Produce backtraces when errors occur
;; (setq debug-on-error t)

;; List of packageso to install - list packages currently installed with C-h v package-activated-list
;; (setq package-list '())
(setq package-list '(ace-window auctex auto-complete avy color-theme-sanityinc-tomorrow direx docker-tramp dockerfile-mode elpy company epc ctable concurrent ess exec-path-from-shell find-file-in-project flycheck dash highlight-indentation ivy julia-mode markdown-mode+ markdown-mode multiple-cursors paradox hydra lv phi-search php-mode pkg-info epl popup python-environment deferred pyvenv s smart-mode-line-powerline-theme smart-mode-line rich-minority powerline spinner web-mode yaml-mode yasnippet))

(require 'package)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t))

(package-initialize)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; install any packages in package-list, if they are not installed already
(let ((refreshed nil))
  (when (not package-archive-contents)
    (package-refresh-contents)
    (setq refreshed t))
  (dolist (pkg package-list)
    (when (and (not (package-installed-p pkg))
             (assoc pkg package-archive-contents))
      (unless refreshed
        (package-refresh-contents)
        (setq refreshed t))
      (package-install pkg))))


(defun package-list-unaccounted-packages ()
  "Like `package-list-packages', but shows only the packages that
  are installed and are not in `jpk-packages'.  Useful for
  cleaning out unwanted packages."
  (interactive)
  (package-show-package-list
   (remove-if-not (lambda (x) (and (not (memq x jpk-packages))
                            (not (package-built-in-p x))
                            (package-installed-p x)))
                  (mapcar 'car package-archive-contents))))

;; Custom variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
 '(custom-safe-themes
   (quote
    ("b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(elpy-eldoc-show-current-function nil)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen nil)
 '(initial-major-mode (quote text-mode))
 '(initial-scratch-message "")
 '(package-check-signature t)
 '(package-enable-at-startup nil)
 '(package-selected-packages
   (quote
    (julia-mode ess yaml-mode web-mode smart-mode-line-powerline-theme python-environment php-mode phi-search paradox auctex ace-window multiple-cursors markdown-mode+ flycheck exec-path-from-shell epc elpy dockerfile-mode docker-tramp direx color-theme-sanityinc-tomorrow avy auto-complete)))
 '(paradox-automatically-star t))

;; Custom themes
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(color-theme-sanityinc-tomorrow-bright)

;; Make bottom line pretty
(setq sml/theme 'light-powerline)
(sml/setup)

;;;;; Backup settings
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))) ;; makes emacs backup to a hidden folder called ".emacsbackups" in the home directory
(setq backup-by-copying t) ;; make backup a completely new copy, no links or ties to original file
(setq delete-old-versions t ;; delete old backups automatically
  kept-new-versions 6 ;; Keep the newest 6 backups when a new backup is made
  kept-old-versions 2 ;; Keep the oldest 2 backups when a new backup is made
  version-control t) ;; keep numbered backups

;;;;; History file
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;;;;; Plugins
;;(load "faith.el")

;;;;; Tab control
(setq-default indent-tabs-mode nil) ;; replaces tabs with spaces
(setq-default tab-width 4) ;; places 4 spaces per tab

;;;;; Recognize miscellaneous file types
(add-to-list 'auto-mode-alist '("\\.ys\\'" . asm-mode)) ;; opens y86 files as an assembly file

;;;;; Tramp and remote access
(setq password-cache-expiry nil) ;; stops emacs from asking password when connected to a remote server all the time

;; ;;;;; Toggle transparency with C-c t
;; (defun toggle-transparency ()
;;   (interactive)
;;   (let ((alpha (frame-parameter nil 'alpha)))
;;     (set-frame-parameter
;;      nil 'alpha
;;      (if (eql (cond ((numberp alpha) alpha)
;;                     ((numberp (cdr alpha)) (cdr alpha))
;;                     ;; Also handle undocumented (<active> <inactive>) form.
;;                     ((numberp (cadr alpha)) (cadr alpha)))
;;               100)
;;          '(85 . 50) '(100 . 100)))))
;; (global-set-key (kbd "C-c t") 'toggle-transparency)

;;;;; Enable transparency
(set-frame-parameter (selected-frame) 'alpha '(85 . 85))
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))

;;;;; Disable toolbar, menubar, and scrollbar
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;;;;; Show line numbers
(global-display-line-numbers-mode t)

;; @description :: Switches to the last used buffer in a window
;; @keys :: C-c b
(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(global-set-key (kbd "C-c b") 'switch-to-previous-buffer)

(transient-mark-mode 1)

;; Enable org-mode
(require 'org)

;; Show line at 80 characters
;; (add-hook 'prog-mode-hook 'fci-mode)

;; Paradox API Token
(setq paradox-github-token "6cf315bfa5a23803ca768d6148f60adc7bea6f47")

;; Remove the command that freezes emacs (why even have this?)
(global-unset-key (kbd "C-x C-z"))

(global-flycheck-mode)

;; Auto-complete-mode
(require 'auto-complete)
(global-auto-complete-mode t)
(defun auto-complete-mode-maybe ()
  "No maybe for you.  Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))

(global-set-key (kbd "C-x o") 'ace-window)

(setq flycheck-python-pylint-executable "/usr/local/lib/python3.6/site-packages/pylint/__main__.py")

;; Multiple cursor keybindings
(require 'multiple-cursors)
(global-set-key (kbd "C-c m c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M->") 'mc/unmark-next-like-this)
(global-set-key (kbd "C-M-<") 'mc/unmark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Replacement for search that works with multiple cursors
(require 'phi-search)
(global-set-key (kbd "C-c C-s") 'phi-search)
(global-set-key (kbd "C-c C-r") 'phi-search-backward)

;; Always reload buffers when they have been changed
(global-auto-revert-mode)

;; Enable ido-mode for better buffer switching
(ido-mode 1)
(setq ido-separator "\n") ;; and give each buffer its own line

;; Enable php major mode
(autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; Keep path from enviornment
(exec-path-from-shell-initialize)

;; Latex flymake checking
;; (defun flymake-get-tex-args (file-name)
;; (list "pdflatex"
;; (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

;; (add-hook 'LaTeX-mode-hook 'flymake-mode)

;; Run latex with -shell-escape option
(add-hook 'TeX-mode-hook
  (lambda ()
    (setq TeX-command-extra-options "-shell-escape")
  )
)

;; Disable LaTeX syntax highlighting in literal regions
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq LaTeX-verbatim-environments-local '("Verbatim" "lstlisting" "minted"))
(setq LaTeX-verbatim-macros-with-braces-local '("url" "href" "mintinline"))

(setq TeX-view-program-selection
      (quote
       ((output-dvi "Evince")
        (output-pdf "Evince")
        (output-html "Evince"))))


;; Close all buffers except for the current one C-x x
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (cdr (buffer-list (current-buffer)))))
(global-set-key (kbd "C-x x") 'kill-other-buffers)

;; Kill all buffers C-x c
(defun kill-all-buffers ()
  "Kill all buffers."
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-x c") 'kill-all-buffers)

;; Find what's changed in beffer since last save
(defun diff-current-buffer ()
  "Find the differences between current buffer and the last saved buffer."
  (interactive)
  (diff-buffer-with-file (current-buffer)))
(global-set-key (kbd "C-x ?") 'diff-current-buffer)

;; Delete trailing whitespace before saving file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Start elpy for python editing
(elpy-enable)

;; Consider camel case two seperate words
(global-subword-mode)

;; Auto complete for python
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:environment-root "jedi")
;; (setq jedi:environment-virtualenv
;;       (list "virtualenv3" "--system-site-packages"))
;; (setq jedi:complete-on-dot t)

;; Jump to next line that is at the same indentation level as the current line
(defun jump-to-same-indent (direction)
  "Takes an argument DIRECTION and jumps to the nth line that has the same level of indentation as the current line."
  (interactive "P")
  (let ((start-indent (current-indentation)))
    (while
      (and (not (bobp))
           (zerop (forward-line (or direction 1)))
           (or (= (current-indentation) 0)
           (> (current-indentation) start-indent)))))
  (back-to-indentation))
(global-set-key [?\M-p] #'(lambda () (interactive) (jump-to-same-indent -1)))
(global-set-key [?\M-n] 'jump-to-same-indent)

;; Swaps the buffers between the next window and the current window.
(defun swap-buffers ()
  "Swaps the buffers between the next window and the current window."
  (interactive)
  (select-window (next-window))
  (switch-to-previous-buffer)
  (select-window (previous-window))
  (switch-to-previous-buffer))
(global-set-key (kbd "C-c s") 'swap-buffers)

;; Enable web mode for web development
(require 'web-mode) ;; Do I need to add .css and .js to this or is that automatic?
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; Make regex isearch the default search
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Bound imenu to make navigating functions easier
(global-set-key (kbd "C-'") 'imenu)


;; Inhibit startup
(setq inhibit-startup-screen t
      initial-buffer-choice nil)


(provide '.emacs)
;;; .emacs ends here
