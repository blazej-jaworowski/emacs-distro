;; Stop custom system from putting garbage in this file

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

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

;; Visual setup

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(set-face-attribute 'default nil :font "Hack Nerd Font Mono" :height 130)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(column-number-mode)
(global-display-line-numbers-mode t)

(setq visible-bell t)
(setq enable-recursive-minibuffers t)

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
(define-key minimal-map (kbd "C-?") 'describe-bindings)
(use-global-map minimal-map)

(setq function-key-map (make-sparse-keymap))
(setq key-translation-map (make-sparse-keymap))
(setq input-decode-map (make-sparse-keymap))
;; (setq minibuffer-local-map (make-sparse-keymap))

;; Setup

(use-package evil
    :config
    (evil-mode 1)
    (setq evil-want-minibuffer t)
    (setq evil-motion-state-map (make-sparse-keymap))
    (setq evil-normal-state-map (make-sparse-keymap))
    (setq evil-insert-state-map character-map)
    (setq evil-visual-state-map (make-sparse-keymap))
    (evil-define-key 'motion 'global
        "j" 'evil-backward-char
        "k" 'evil-next-line
        "K" '(lambda () (interactive) (evil-next-line 10))
        "l" 'evil-previous-line
        "L" '(lambda () (interactive) (evil-previous-line 10))
        ";" 'evil-forward-char
        ":" 'evil-ex
        "gg" 'evil-goto-first-line
        "G" 'evil-goto-line
        "^" 'evil-first-non-blank
        "$" 'evil-end-of-line
        "b" 'evil-backward-word-begin
        "e" 'evil-forward-word-end
        "w" 'evil-forward-word-begin
        "0" 'evil-beginning-of-line
        "/" 'evil-search-forward
        "?" 'evil-search-backward
        "n" 'evil-search-next
        "N" 'evil-search-previous
        "V" 'evil-visual-line
        "\C-v" 'evil-visual-block
        "v" 'evil-visual-char
        "[[" 'evil-backward-paragraph
        "]]" 'evil-forward-paragraph
        "(" 'evil-previous-open-paren
        ")" 'evil-next-open-paren
        "{" 'evil-previous-open-brace
        "}" 'evil-next-open-brace
        [down-mouse-1] 'evil-mouse-drag-region
        "\C-o" 'evil-jump-forward
        "\C-i" 'evil-jump-backward
        " j" 'evil-window-left
        " k" 'evil-window-down
        " l" 'evil-window-up
        " ;" 'evil-window-right
        " v" 'evil-window-vsplit
        " c" 'evil-window-split
        " q" 'evil-quit
        " =" 'balance-windows
        "y" 'evil-yank
        "q" 'evil-record-macro
        "@" 'evil-execute-macro
        "1" 'digit-arg
        "2" 'digit-argument
        "3" 'digit-argument
        "4" 'digit-argument
        "5" 'digit-argument
        "6" 'digit-argument
        "7" 'digit-argument
        "8" 'digit-argument
        "9" 'digit-argument
    )
    (evil-define-key 'normal 'global
        "<" 'evil-shift-left
        ">" 'evil-shift-right
        "a" 'evil-append
        "A" 'evil-append-line
        "i" 'evil-insert
        "I" 'evil-insert-line
        "o" 'evil-open-below
        "O" 'evil-open-above
        "p" 'evil-paste-after
        "P" 'evil-paste-before
        "d" 'evil-delete
        "x" 'evil-delete-char
        "r" 'evil-replace
        "s" 'evil-substitute
        "u" 'evil-undo
        "U" 'evil-redo
    )
    (evil-define-key 'visual 'global
        "\e" 'evil-exit-visual-state
    )
    (evil-define-key 'insert 'global
        "\e" 'evil-normal-state
    )
)

(use-package vertico
    :config
    (setq vertico-count 20)
    (vertico-mode)
    (setq vertico-map (make-keymap))
    (evil-define-key 'motion vertico-map
        "k" 'vertico-next
        "K" '(lambda () (interactive) (vertico-next 10))
        "l" 'vertico-previous
        "L" '(lambda () (interactive) (vertico-previous 10))
        "gg" 'vertico-first
        "G" 'vertico-last
        "\e" 'keyboard-escape-quit
        "f" 'vertico-quick-jump
    )
    (evil-define-key '(motion insert) vertico-map
        (kbd "<down>") 'vertico-next
        (kbd "<up>") 'vertico-previous
        "\t" 'vertico-insert
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
        " ff" 'consult-find
        " fg" 'consult-ripgrep
    )
)

(use-package avy
    :config
    (evil-define-key 'motion 'global
        "f" 'avy-goto-char-2
    )
)

(use-package amx)

(setq function-key-map (make-sparse-keymap))
(setq key-translation-map (make-sparse-keymap))
(setq input-decode-map (make-sparse-keymap))
