;; Stop custom system from putting garbage in this file

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq backup-directory-alist `(("." . "~/.saves")))
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; Set up package repos

(require 'package)

(setq package-archives '(
    ("melpa" . "https://melpa.org/packages/")
    ("org" . "https://orgmode.org/elpa/")
    ("elpa" . "https://elpa.gnu.org/packages/")
))

(package-initialize)
(unless package-archive-contents
    (package-refresh-contents))

;; Set up use-package

(unless (package-installed-p 'use-package)
    (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(setq package-check-signature nil)
(use-package gnu-elpa-keyring-update
    :config
    (gnu-elpa-keyring-update)
)
(setq package-check-signature 'allow-unsigned)

;; Visual setup

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(set-face-attribute 'default nil :font "Hack Nerd Font Mono" :height 110)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(column-number-mode)
(global-display-line-numbers-mode t)

(setq visible-bell t)
(setq enable-recursive-minibuffers t)

(setq confirm-kill-processes nil)

(use-package gruvbox-theme
    :config
    (load-theme 'gruvbox-dark-hard)
)

(use-package doom-modeline
    :init
    (doom-modeline-mode 1)
)

(use-package nerd-icons
    :custom
    (nerd-icons-font-family "Hack Nerd Font Mono")
)

;; Remove all bindings

(setq character-map (make-keymap))
(substitute-key-definition 'self-insert-command 'self-insert-command
    character-map global-map)
(define-key character-map (kbd "RET") 'newline)
(define-key character-map (kbd "DEL") 'backward-delete-char-untabify)
(define-key character-map (kbd "TAB") 'indent-for-tab-command)
(define-key character-map (kbd "<up>") 'previous-line)
(define-key character-map (kbd "<down>") 'next-line)
(define-key character-map (kbd "<left>") 'left-char)
(define-key character-map (kbd "<right>") 'right-char)

(setq minimal-map (make-keymap))
(define-key minimal-map (kbd "<mouse-4>") 'mwheel-scroll)
(define-key minimal-map (kbd "<mouse-5>") 'mwheel-scroll)
(define-key minimal-map (kbd "<mouse-7>") 'mwheel-scroll)
(define-key minimal-map (kbd "<mouse-1>") 'mouse-set-point)
(define-key minimal-map (kbd "<escape>") 'ignore)
(define-key minimal-map (kbd "C-?") 'describe-bindings)
(use-global-map minimal-map)

(setq y-or-n-p-map (make-keymap))
(setq lisp-interaction-mode-map (make-keymap))

(electric-pair-mode)

;; Setup

(use-package undo-tree
    :init
    (setq undo-tree-map (make-sparse-keymap))
    :config
    (setq evil-undo-system 'undo-tree)
    (global-undo-tree-mode)
    (setq undo-tree-auto-save-history t)
)

(use-package evil
    :config
    (evil-mode 1)
    (setq evil-want-minibuffer t)
    (setq evil-motion-state-map (make-sparse-keymap))
    (setq evil-normal-state-map (make-sparse-keymap))
    (setq evil-insert-state-map character-map)
    (setq evil-visual-state-map (make-sparse-keymap))
    (evil-define-key 'motion 'global
        (kbd "j") 'evil-backward-char
        (kbd "k") 'evil-next-line
        (kbd "K") '(lambda () (interactive) (evil-next-line 10))
        (kbd "l") 'evil-previous-line
        (kbd "L") '(lambda () (interactive) (evil-previous-line 10))
        (kbd ";") 'evil-forward-char
        (kbd ":") 'evil-ex
        (kbd "g g") 'evil-goto-first-line
        (kbd "G") 'evil-goto-line
        (kbd "^") 'evil-first-non-blank
        (kbd "$") 'evil-end-of-line
        (kbd "b") 'evil-backward-word-begin
        (kbd "e") 'evil-forward-word-end
        (kbd "w") 'evil-forward-word-begin
        (kbd "0") 'evil-beginning-of-line
        (kbd "/") 'evil-search-forward
        (kbd "?") 'evil-search-backward
        (kbd "n") 'evil-search-next
        (kbd "N") 'evil-search-previous
        (kbd "V") 'evil-visual-line
        (kbd "C-v") 'evil-visual-block
        (kbd "v") 'evil-visual-char
        (kbd "[ [") 'evil-backward-paragraph
        (kbd "] ]") 'evil-forward-paragraph
        (kbd "(") 'evil-previous-open-paren
        (kbd ")") 'evil-next-open-paren
        (kbd "{") 'evil-previous-open-brace
        (kbd "}") 'evil-next-open-brace
        (kbd "<down-mouse-1>") 'evil-mouse-drag-region
        (kbd "C-o") 'evil-jump-forward
        (kbd "C-i") 'evil-jump-backward
        (kbd "SPC j") 'evil-window-left
        (kbd "SPC k") 'evil-window-down
        (kbd "SPC l") 'evil-window-up
        (kbd "SPC ;") 'evil-window-right
        (kbd "SPC v") 'evil-window-vsplit
        (kbd "SPC c") 'evil-window-split
        (kbd "SPC x") 'evil-quit
        (kbd "SPC =") 'balance-windows
        (kbd "y") 'evil-yank
        (kbd "q") 'evil-record-macro
        (kbd "@") 'evil-execute-macro
        (kbd "1") 'digit-argument
        (kbd "2") 'digit-argument
        (kbd "3") 'digit-argument
        (kbd "4") 'digit-argument
        (kbd "5") 'digit-argument
        (kbd "6") 'digit-argument
        (kbd "7") 'digit-argument
        (kbd "8") 'digit-argument
        (kbd "9") 'digit-argument
        (kbd "SPC /") 'comment-line
    )
    (evil-define-key 'normal 'global
        (kbd "<") 'evil-shift-left
        (kbd ">") 'evil-shift-right
        (kbd "a") 'evil-append
        (kbd "A") 'evil-append-line
        (kbd "i") 'evil-insert
        (kbd "I") 'evil-insert-line
        (kbd "o") 'evil-open-below
        (kbd "O") 'evil-open-above
        (kbd "p") 'evil-paste-after
        (kbd "P") 'evil-paste-before
        (kbd "d") 'evil-delete
        (kbd "x") 'evil-delete-char
        (kbd "r") 'evil-replace
        (kbd "s") 'evil-substitute
        (kbd "u") 'evil-undo
        (kbd "C-u") 'evil-redo
    )
    (evil-define-key 'visual 'global
        (kbd "<escape>") 'evil-exit-visual-state
    )
    (evil-define-key 'insert 'global
        (kbd "<escape>") 'evil-normal-state
    )
    (evil-define-key '(motion insert) 'global
        (kbd "C-j") 'shell
    )
)

(add-hook 'minibuffer-setup-hook '(lambda () (interactive) (evil-insert-state)))

(use-package vertico
    :config
    (setq vertico-count 20)
    (vertico-mode)
    (setq vertico-map (make-keymap))
    (evil-define-key 'motion vertico-map
        (kbd "k") 'vertico-next
        (kbd "K") '(lambda () (interactive) (vertico-next 10))
        (kbd "l") 'vertico-previous
        (kbd "L") '(lambda () (interactive) (vertico-previous 10))
        (kbd "g g") 'vertico-first
        (kbd "G") 'vertico-last
        (kbd "<escape>") 'keyboard-escape-quit
        (kbd "f") 'vertico-quick-jump
    )
    (evil-define-key '(motion insert) vertico-map
        (kbd "<down>") 'vertico-next
        (kbd "<up>") 'vertico-previous
        (kbd "TAB") 'vertico-insert
        (kbd "RET") 'vertico-exit
    )
)

(use-package orderless)

(use-package marginalia
    :config
    (marginalia-mode)
)

(use-package consult
    :config
    (evil-define-key 'motion 'global
        (kbd "SPC f f") 'consult-find
        (kbd "SPC f g") 'consult-ripgrep
        (kbd "SPC f b") 'consult-buffer
    )
    :custom
    (consult-async-refresh-delay 0.0)
    (consult-async-input-throttle 0.0)
    (consult-async-input-debounce 0.0)
    (consult-async-min-input 1)
)

(use-package avy
    :config
    (evil-define-key 'motion 'global
        (kbd "f") 'avy-goto-char-2
    )
)

(setq shell-mode-map (make-sparse-keymap))
(evil-define-key 'insert shell-mode-map
    (kbd "RET") 'comint-send-input
    (kbd "<down>") 'comint-next-input
    (kbd "<up>") 'comint-previous-input
)
(evil-define-key 'normal shell-mode-map
    (kbd "RET") '(lambda ()
        (interactive)
        (if (eq (+ (marker-position (point-marker)) 1) (point-max))
            (comint-send-input)
            (let ((text (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
                (goto-char (point-max))
                (insert text)
            )
        )
    )
)
(evil-define-key 'visual shell-mode-map
    (kbd "RET") '(lambda ()
        (interactive)
        (let ((text (buffer-substring-no-properties evil-visual-beginning evil-visual-end)))
            (goto-char (point-max))
            (insert text)
        )
    )
)
(defun goto-end ()
    (goto-char (point-max))
)
(add-hook 'shell-mode-hook '(lambda ()
    (add-hook 'evil-insert-state-entry-hook 'goto-end nil t)
))
(add-hook 'change-major-mode-hook '(lambda ()
    (remove-hook 'evil-insert-state-entry-hook 'goto-end t)
))
(setq comint-prompt-read-only t)
(setq comint-mode-map (make-keymap))
(evil-define-key 'insert shell-mode-map
    (kbd "C-u") 'comint-kill-input
    (kbd "C-w") 'backward-kill-word
    (kbd "C-c") 'comint-interrupt-subjob
    (kbd "C-d") 'comint-send-eof
    (kbd "C-z") 'comint-stop-subjob
    (kbd "C-\\") 'comint-quit-subjob
)

(use-package amx)

(use-package lsp-mode
    :hook (
        (python-mode . lsp)
        (rust-mode . lsp)
        (c-mode . lsp)
        (c++-mode . lsp)
        (elisp-mode . lsp)
    )
    :custom
    (eldoc-idle-delay 0.0)
    :config
    (setq lsp-command-map (make-sparse-keymap))
    (evil-define-key 'normal 'lsp-command-map
        (kbd "g d") 'lsp-find-definition
        (kbd "g r") 'lsp-find-references

        (kbd "SPC d r") 'lsp-rename
        (kbd "SPC d a") 'lsp-execute-code-action
        (kbd "SPC d f") 'lsp-format-region
        (kbd "SPC d F") 'lsp-format-buffer

        (kbd "SPC q") 'consult-lsp-diagnostics
        (kbd "SPC Q") 'flymake-show-project-diagnostics
    )
    (setq gc-cons-threshold 100000000)
    (setq read-process-output-max (* 1024 1024))
    (setq lsp-idle-delay 0.1)
    (setq lsp-use-plists t)
    (setq lsp-modeline-diagnostics-enable nil)
    (setq xref-show-xrefs-function 'consult-xref)
    (setq xref-show-definitions-function 'consult-xref)
)
(use-package consult-lsp)

(use-package company
    :hook (after-init . global-company-mode)
    :config
    (setq
        company-idle-delay 0.0
        company-minimum-prefix-length 1
        company-selection-wrap-around t
    )
)

(use-package vlf
    :custom
    (vlf-application 'dont-ask)
)
(setq large-file-warning-threshold nil)

(use-package whitespace-cleanup-mode
    :custom
    (global-whitespace-cleanup-mode)
)
