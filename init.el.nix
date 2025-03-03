pkgs:
''
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Basic settings for quick startup and convenience
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'bind-key)

;; Startup speed, annoyance suppression
(setq gc-cons-threshold 10000000)
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)

;; Silence stupid startup message
(setq inhibit-startup-echo-area-message (user-login-name))

;; Default frame configuration: full screen, good-looking title bar on macOS
(setq frame-resize-pixelwise t)
(tool-bar-mode -1)                      ; All these tools are in the menu-bar anyway
(menu-bar-mode -1)                      ; All these tools are in the M-x anyway
(setq default-frame-alist '((fullscreen . maximized)

                            ;; You can turn off scroll bars by uncommenting these lines:
                            ;; (vertical-scroll-bars . nil)
                            ;; (horizontal-scroll-bars . nil)

                            ;; Setting the face in here prevents flashes of
                            ;; color as the theme gets activated
                            (background-color . "#000000")
                            (ns-appearance . dark)
                            (ns-transparent-titlebar . t)))
; emacs was destroying my hard links : (
(setq backup-by-copying-when-linked t)

; don't pollute my directories with autosaves
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
 '(custom-safe-themes
   '("871b064b53235facde040f6bdfa28d03d9f4b966d8ce28fb1725313731a2bcc8" "a5270d86fac30303c5910be7403467662d7601b821af2ff0c4eb181153ebfc0a" "98ef36d4487bf5e816f89b1b1240d45755ec382c7029302f36ca6626faf44bbd" "ba323a013c25b355eb9a0550541573d535831c557674c8d59b9ac6aa720c21d3" "046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012" "d445c7b530713eac282ecdeea07a8fa59692c83045bf84dd112dd738c7bcad1d" default))
 '(package-selected-packages
   '(idris-mode evil-leader geiser-racket macrostep-geiser geiser-chez srfi erc-hl-nicks scheme-complete evil-commentary evil-surround evil-goggles evil paredit org-roam evil-org lsp-scheme counsel general all-the-icons-ivy frog-jump-buffer chess rainbow-delimiters which-key)))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

;;; Minimal init.el

;;; Contents:
;;;
;;;  - Basic settings
;;;  - Discovery aids
;;;  - Minibuffer/completion settings
;;;  - Interface enhancements/defaults
;;;  - Tab-bar configuration
;;;  - Theme
;;;  - Optional extras
;;;  - Built-in customization framework


;; set these first so emacs doesn't freak out about theme safety


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-goggles-change-face ((t (:inherit diff-removed))))
 '(evil-goggles-delete-face ((t (:inherit diff-removed))))
 '(evil-goggles-paste-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-add-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-change-face ((t (:inherit diff-changed))))
 '(evil-goggles-undo-redo-remove-face ((t (:inherit diff-removed))))
 '(evil-goggles-yank-face ((t (:inherit diff-changed)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Basic settings
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Package initialization
;;
;; We'll stick to the built-in GNU and non-GNU ELPAs (Emacs Lisp Package
;; Archive) for the base install, but there are some other ELPAs you could look
;; at if you want more packages. MELPA in particular is very popular. See
;; instructions at:
;;
;;    https://melpa.org/#/getting-started
;;
(with-eval-after-load 'package
    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
    (package-initialize))


;; If you want to turn off the welcome screen, uncomment this
(setq inhibit-splash-screen t)

(setq initial-major-mode 'fundamental-mode)  ; default mode for the *scratch* buffer
(setq display-time-default-load-average nil) ; this information is useless for most

;; Automatically reread from disk if the underlying file changes
(setq auto-revert-interval 1)
(setq auto-revert-check-vc-info t)
(global-auto-revert-mode)

;; Save history of minibuffer
(savehist-mode)

;; Move through windows with Ctrl-<arrow keys>
(windmove-default-keybindings 'control) ; You can use other modifiers here

;; Fix archaic defaults
(setq sentence-end-double-space nil)

;; Make right-click do something sensible
(when (display-graphic-p)
  (context-menu-mode))

;; Don't litter file system with *~ backup files; put them all inside
;; ~/.emacs.d/backup or wherever
(defun bedrock--backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* ((backupRootDir "~/.emacs.d/emacs-backup/")
         (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path
         (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") )))
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath))
(setq make-backup-file-name-function 'bedrock--backup-file-name)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Discovery aids
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; which-key: shows a popup of available keybindings when typing a long key
;; sequence (e.g. C-x ...)
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Minibuffer/completion settings
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; For help, see: https://www.masteringemacs.org/article/understanding-minibuffer-completion

(setq enable-recursive-minibuffers t)                ; Use the minibuffer whilst in the minibuffer
(setq completion-cycle-threshold 1)                  ; TAB cycles candidates
(setq completions-detailed t)                        ; Show annotations
(setq tab-always-indent 'complete)                   ; When I hit TAB, try to complete, otherwise, indent
(setq completion-styles '(basic initials substring)) ; Different styles to match input to candidates

(setq completion-auto-help 'always)                  ; Open completion always; `lazy' another option
(setq completions-max-height 20)                     ; This is arbitrary
(setq completions-detailed t)
(setq completions-format 'one-column)
(setq completions-group t)
(setq completion-auto-select 'second-tab)            ; Much more eager
;(setq completion-auto-select t)                     ; See `C-h v completion-auto-select' for more possible values

(keymap-set minibuffer-mode-map "TAB" 'minibuffer-complete) ; TAB acts more like how it does in the shell

;; For a fancier built-in completion option, try ido-mode or fido-mode. See also
;; the file extras/base.el
;(fido-vertical-mode)
;(setq icomplete-delay-completions-threshold 4000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Interface enhancements/defaults
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Mode line information
(setq line-number-mode t)                        ; Show current line in modeline
(setq column-number-mode t)                      ; Show column as well

(setq x-underline-at-descent-line nil)           ; Prettier underlines
(setq switch-to-buffer-obey-display-actions t)   ; Make switching buffers more consistent

(setq-default show-trailing-whitespace nil)      ; By default, don't underline trailing spaces
(setq-default indicate-buffer-boundaries 'left)  ; Show buffer top and bottom in the margin

;; Enable horizontal scrolling
(setq mouse-wheel-tilt-scroll t)
(setq mouse-wheel-flip-direction t)

;; We won't set these, but they're good to know about
;; I will. Thanks!
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Misc. UI tweaks
(blink-cursor-mode -1)                                ; Steady cursor
(pixel-scroll-precision-mode)                         ; Smooth scrolling

;; Use common keystrokes by default
; (cua-mode)

;; Display line numbers in programming mode
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq-default display-line-numbers-width 3)           ; Set a minimum width

;; Nice line wrapping when working with text
(add-hook 'text-mode-hook 'visual-line-mode)

;; mix format
(add-hook 'after-save-hook
  '(lambda ()
     (when (eq major-mode 'elixir-ts-mode)
       (shell-command-to-string (format "mix format %s" (buffer-file-name))))))

;; Modes to highlight the current line with
(let ((hl-line-hooks '(text-mode-hook prog-mode-hook)))
  (mapc (lambda (hook) (add-hook hook 'hl-line-mode)) hl-line-hooks))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Tab-bar configuration
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Show the tab-bar as soon as tab-bar functions are invoked
(setq tab-bar-show 0)

;; Add the time to the tab-bar, if visible
;(add-to-list 'tab-bar-format 'tab-bar-format-align-right 'append)
;(add-to-list 'tab-bar-format 'tab-bar-format-global 'append)
;(setq display-time-format "%a %F %T")
;(setq display-time-interval 1)
;(display-time-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Theme
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package emacs
  :config
  (load-theme 'doom-gruvbox t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Optional extras
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Uncomment the (load-file …) lines or copy code from the extras/ elisp files
;; as desired

;; UI/UX enhancements mostly focused on minibuffer and autocompletion interfaces
;; These ones are *strongly* recommended!
; (load-file (expand-file-name "extras/base.el" user-emacs-directory))

; ;; Packages for software development
; (load-file (expand-file-name "extras/dev.el" user-emacs-directory))

; ;; Vim-bindings in Emacs (evil-mode configuration)
; (load-file (expand-file-name "extras/vim-like.el" user-emacs-directory))

; ;; scheme-relevant stuff (includes slime)
; (load-file (expand-file-name "extras/scheme.el" user-emacs-directory))

;; Org-mode configuration
;; WARNING: need to customize things inside the elisp file before use! See
;; the file extras/org-intro.txt for help.
; (load-file (expand-file-name "extras/org.el" user-emacs-directory))

;; Email configuration in Emacs
;; WARNING: needs the `mu' program installed; see the elisp file for more
;; details.
;(load-file (expand-file-name "extras/email.el" user-emacs-directory))

;; Tools for academic researchers
;(load-file (expand-file-name "extras/researcher.el" user-emacs-directory))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Built-in customization framework
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq w32-recognize-altgr nil)
(scroll-bar-mode -1)

(use-package all-the-icons-ivy
  :ensure t)

(use-package counsel
  :ensure t)

;; (set-fringe-mode 'minimal)

(use-package general
  :ensure t)

(use-package lsp-mode
  :ensure t)
;;; Emacs Bedrock
;;;
;;; Extra config: Base UI enhancements

;;; Usage: Append or require this file from init.el to enable various UI/UX
;;; enhancements.

;;; Contents:
;;;
;;;  - Motion aids
;;;  - Power-ups: Embark and Consult
;;;  - Minibuffer and completion

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Motion aids
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package avy
  :ensure t
  :demand t
  :bind (("C-c j" . avy-goto-line)
         ("s-j"   . avy-goto-char-timer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Power-ups: Embark and Consult
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Consult: Misc. enhanced commands
(use-package consult
  :ensure t
  ;; Other good things to bind: consult-ripgrep, consult-line-multi,
  ;; consult-history, consult-outline
  :bind (("C-x b" . consult-buffer) ; orig. switch-to-buffer
         ("M-y" . consult-yank-pop) ; orig. yank-pop
         ("C-s" . consult-line))    ; orig. isearch
  :config
  ;; Narrowing lets you restrict results to certain groups of candidates
  (setq consult-narrow-key "<"))

(use-package embark
  :ensure t
  :demand t
  :after avy
  :bind (("C-c a" . embark-act))        ; bind this to an easy key to hit
  :init
  ;; Add the option to run embark when using avy
  (defun bedrock/avy-action-embark (pt)
    (unwind-protect
        (save-excursion
          (goto-char pt)
          (embark-act))
      (select-window
       (cdr (ring-ref avy-ring 0))))
    t)

  ;; After invoking avy-goto-char-timer, hit "." to run embark at the next
  ;; candidate you select
  (setf (alist-get ?. avy-dispatch-alist) 'bedrock/avy-action-embark))

(use-package embark-consult
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Minibuffer and completion
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Vertico: better vertical completion for minibuffer commands
(use-package vertico
  :ensure t
  :init
  ;; You'll want to make sure that e.g. fido-mode isn't enabled
  (vertico-mode))

(use-package vertico-directory
  :after vertico
  :bind (:map vertico-map
              ("M-DEL" . vertico-directory-delete-word)))

;; Marginalia: annotations for minibuffer
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

;; Popup completion-at-point
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :bind
  (:map corfu-map
        ("SPC" . corfu-insert-separator)
        ("C-n" . corfu-next)
        ("C-p" . corfu-previous)))

;; Part of corfu
(use-package corfu-popupinfo
  :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom
  (corfu-popupinfo-delay '(0.25 . 0.1))
  (corfu-popupinfo-hide nil)
  :config
  (corfu-popupinfo-mode))

;; Make corfu popup come up in terminal overlay
(use-package corfu-terminal
  :if (not (display-graphic-p))
  :ensure t
  :config
  (corfu-terminal-mode))

;; Pretty icons for corfu
(use-package kind-icon
  :if (display-graphic-p)
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package eshell
  :bind (("C-r" . consult-history)))

;; Orderless: powerful completion style
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)))
;;; Emacs Bedrock
;;;
;;; Extra config: Development tools

;;; Usage: Append or require this file from init.el for some software
;;; development-focused packages.
;;;
;;; It is **STRONGLY** recommended that you use the base.el config if you want to
;;; use Eglot. Lots of completion things will work better.
;;;
;;; This will try to use tree-sitter modes for many languages. Please run
;;;
;;;   M-x treesit-install-language-grammar
;;;
;;; Before trying to use a treesit mode.

;;; Contents:
;;;
;;;  - Built-in config for developers
;;;  - Version Control
;;;  - Common file types
;;;  - Eglot, the built-in LSP client for Emacs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Built-in config for developers
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package emacs
  :config
  ;; Treesitter config

  ;; Tell Emacs to prefer the treesitter mode
  ;; You'll want to run the command `M-x treesit-install-language-grammar' before editing.
  (setq major-mode-remap-alist
        '((yaml-mode . yaml-ts-mode)
          (bash-mode . bash-ts-mode)
          (js2-mode . js-ts-mode)
          (typescript-mode . typescript-ts-mode)
          (json-mode . json-ts-mode)
          (css-mode . css-ts-mode)
          (python-mode . python-ts-mode)
          (elixir-mode . elixir-ts-mode)))
  (add-to-list 'auto-mode-alist
    '("\\.ex\\'" . elixir-mode))
  (add-to-list 'auto-mode-alist
    '("\\.exs\\'" . elixir-mode))

  :hook
  ;; Auto parenthesis matching
  (prog-mode . electric-pair-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Version Control
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Magit: best Git client to ever exist
(use-package magit
  :ensure t
  :bind ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Common file types
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package markdown-mode
  :hook ((markdown-mode . visual-line-mode)))

(use-package yaml-mode
  :ensure t)

(use-package json-mode
  :ensure t)

;; Emacs ships with a lot of popular programming language modes. If it's not
;; built in, you're almost certain to find a mode for the language you're
;; looking for with a quick Internet search.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Eglot, the built-in LSP client for Emacs
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package eglot
  ;; no :ensure t here because it's built-in

  ;; Configure hooks to automatically turn-on eglot for selected modes
  :hook
  ; (((python-mode ruby-mode) . eglot))
  ((elixir-ts-mode . eglot-ensure))

  :custom
  ;; let's try a higher idle time, elixir-ls is a bit finicky
  (eglot-send-changes-idle-time 0.5)

  :config
  (fset #'jsonrpc--log-event #'ignore)  ; massive perf boost---don't log every event
  ;; Sometimes you need to tell Eglot where to find the language server
  (add-to-list 'eglot-server-programs
               '(elixir-ts-mode "${pkgs.elixir-ls}/bin/elixir-ls"))
  )

; oorg
  ;;   ;;;;     ;;;;
;;  ;; ;;  ;; ;;
;;  ;; ;;;;   ;;
;;  ;; ;;  ;; ;;  ;;
  ;;   ;;  ;;   ;;;;

;;; Emacs Bedrock
;;;
;;; Extra config: Org-mode starter config

;;; Usage: Append or require this file from init.el for some software
;;; development-focused packages.
;;;
;;; Org-mode is a fantastically powerful package. It does a lot of things, which
;;; makes it a little difficult to understand at first.
;;;
;;; We will configure Org-mode in phases. Work with each phase as you are
;;; comfortable.
;;;
;;; YOU NEED TO CONFIGURE SOME VARIABLES! The most important variable is the
;;; `org-directory', which tells org-mode where to look to find your agenda
;;; files.

;;; See "org-intro.txt" for a high-level overview.

;;; Contents:
;;;
;;;  - Critical variables
;;;  - Phase 1: editing and exporting files
;;;  - Phase 2: todos, agenda generation, and task tracking
;;;  - Phase 3: extensions (org-roam, etc.)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Critical variables
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; These variables need to be set for Org-mode's full power to be unlocked!
;;;
;;; You can read the documentation for any variable with `C-h v'. If you have
;;; Consult configured (see the `base.el' file) then it should help you find
;;; what you're looking for.

;;; Phase 1 variables

;;; Phase 2 variables

;; Agenda variables
(setq org-directory "~/Documents/org/") ; Non-absolute paths for agenda and
                                        ; capture templates will look here.
(setq org-agenda-files '("inbox.org" "work.org"))

;; Default tags
(setq org-tag-alist '(
                      ;; locale
                      (:startgroup)
                      ("home" . ?h)
                      ("work" . ?w)
                      ("school" . ?s)
                      (:endgroup)
                      (:newline)
                      ;; scale
                      (:startgroup)
                      ("one-shot" . ?o)
                      ("project" . ?j)
                      ("tiny" . ?t)
                      (:endgroup)
                      ;; misc
                      ("meta")
                      ("review")
                      ("reading")))

;; Org-refile: where should org-refile look?
(setq org-refile-targets 'FIXME)

;;; Phase 3 variables

;; Org-roam variables
(setq org-roam-directory "~/Documents/org-roam/")
(setq org-roam-index-file "~/Documents/org-roam/index.org")

;;; Optional variables

;; Advanced: Custom link types
;; This example is for linking a person's 7-character ID to their page on the
;; free genealogy website Family Search.
(setq org-link-abbrev-alist
      '(("family_search" . "https://www.familysearch.org/tree/person/details/%s")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Phase 1: editing and exporting files
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org
  :hook ((org-mode . visual-line-mode)  ; wrap lines at word breaks
         (org-mode . flyspell-mode))    ; spell checking!

  :bind (:map global-map
              ("C-c l s" . org-store-link)          ; Mnemonic: link → store
              ("C-c l i" . org-insert-link-global)) ; Mnemonic: link → insert
  :config
  (require 'oc-csl)                     ; citation support
  (add-to-list 'org-export-backends 'md)

  ;; Make org-open-at-point follow file links in the same window
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)

  ;; Make exporting quotes better
  (setq org-export-with-smart-quotes t)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Phase 2: todos, agenda generation, and task tracking
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Yes, you can have multiple use-package declarations. It's best if their
;; configs don't overlap. Once you've reached Phase 2, I'd recommend merging the
;; config from Phase 1. I've broken it up here for the sake of clarity.
(use-package org
  :config
  ;; Instead of just two states (TODO, DONE) we set up a few different states
  ;; that a task can be in.
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAITING(w@/!)" "STARTED(s!)" "|" "DONE(d!)" "OBSOLETE(o@)")))

  ;; Refile configuration
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-use-outline-path 'file)

  (setq org-capture-templates
        '(("c" "Default Capture" entry (file "inbox.org")
           "* TODO %?\n%U\n%i")
          ;; Capture and keep an org-link to the thing we're currently working with
          ("r" "Capture with Reference" entry (file "inbox.org")
           "* TODO %?\n%U\n%i\n%a")
          ;; Define a section
          ("w" "Work")
          ("wm" "Work meeting" entry (file+headline "work.org" "Meetings")
           "** TODO %?\n%U\n%i\n%a")
          ("wr" "Work report" entry (file+headline "work.org" "Reports")
           "** TODO %?\n%U\n%i\n%a")))

    (setq org-agenda-custom-commands
          '(("n" "Agenda and All Todos"
             ((agenda)
              (todo)))
            ("w" "Work" agenda ""
             ((org-agenda-files '("work.org")))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Phase 3: extensions (org-roam, etc.)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org-roam
  :ensure t
  :config
  (org-roam-db-autosync-mode)
  ;; Dedicated side window for backlinks
  (add-to-list 'display-buffer-alist
               '("\\*org-roam\\*"
                 (display-buffer-in-side-window)
                 (side . right)
                 (window-width . 0.4)
                 (window-height . fit-window-to-buffer))))

;; Pretty web interface for org-roam
;(use-package org-roam-ui
;  :ensure t
;  :after org-roam
;  :config
;  (setq org-roam-ui-sync-theme t
;        org-roam-ui-follow t
;        org-roam-ui-update-on-save t
;        org-roam-ui-open-on-start t))


; scm
;;;;;; ;;;;;; ;;  ;; ;;;;;; ;;      ;; ;;;;;;
;;     ;;     ;;  ;; ;;     ;;;;  ;;;; ;;
;;;;;; ;;     ;;;;;; ;;;;   ;;  ;;  ;; ;;;;
    ;; ;;     ;;  ;; ;;     ;;      ;; ;;
;;;;;; ;;;;;; ;;  ;; ;;;;;; ;;      ;; ;;;;;;

(setq scheme-program-name "scheme")

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode . enable-paredit-mode)
         (eval-expression-minibuffer-setup . enable-paredit-mode)
         (ielm-mode . enable-paredit-mode)
         (lisp-mode . enable-paredit-mode)
         (lisp-interaction-mode . enable-paredit-mode)
         (scheme-mode . enable-paredit-mode)
         ;; (inferior-scheme-mode . enable-paredit-mode)
         ;(slime-repl-mode . enable-paredit-mode)
         (sly-repl-mode . enable-paredit-mode)
         (clojure-mode . enable-paredit-mode)
         (clojurescript-mode . enable-paredit-mode)
         (cider-repl-mode . enable-paredit-mode)
         (cider-mode . enable-paredit-mode)
         (clojure-mode . enable-paredit-mode))
  :config
  (show-paren-mode t))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'lisp-mode-hook       #'rainbow-delimiters-mode)
  (add-hook 'scheme-mode-hook     #'rainbow-delimiters-mode)
  )

; gsr
; (use-package geiser-chez
;   :ensure t
;   :config
  (setq geiser-active-implementations '(chez guile gambit racket))
  ;(setq geiser-chez-binary "/usr/bin/chez")
  (setq geiser-repl-query-on-kill-p nil)
  ; )

(use-package macrostep-geiser
  :ensure t
  )

; if necessary
;; (use-package company
;;   :ensure t)

;; (use-package lsp-scheme
;;   :ensure t
;;   :init
;;   (add-hook 'scheme-mode-hook #'lsp-scheme-guile)
;;   :config
;;   )

;; (use-package scheme-complete
;;   :ensure t
;;   :config
;;   )

(use-package lispyville
  :init
  (general-add-hook '(emacs-lisp-mode-hook lisp-mode-hook scheme-mode-hook) #'lispyville-mode)
  :config)

;(use-package slime :ensure t
;  :init
;  (setq slime-contribs                     '(slime-fancy)
;        slime-complete-symbol-function     'slime-fuzzy-complete-symbol
;        slime-net-coding-system            'utf-8-unix
;        slime-lisp-implementations         '((sbcl ("${pkgs.sbcl}/bin/sbcl"))))
;  :config
;  (setq common-lisp-hyperspec-root         "${pkgs.sbclPackages.hyperspec}/docs/"
;        ;common-lisp-hyperspec-symbol-table (concat common-lisp-hyperspec-root "Data/Map_Sym.txt")
;        ;common-lisp-hyperspec-issuex-table (concat common-lisp-hyperspec-root "Data/Map_IssX.txt")
;        ))

(use-package sly :ensure t
  :init
  (setq inferior-lisp-program "${pkgs.sbcl}/bin/sbcl"
        sly-symbol-completion-mode nil)
  :config
  (setq common-lisp-hyperspec-root         "${pkgs.sbclPackages.hyperspec}/docs/"
        ;common-lisp-hyperspec-symbol-table (concat common-lisp-hyperspec-root "Data/Map_Sym.txt")
        ;common-lisp-hyperspec-issuex-table (concat common-lisp-hyperspec-root "Data/Map_IssX.txt")
        )
  ;(define-key sly-prefix-map (kbd "<down>") 'sly-next-completion)
  )

(defun toggle-parens ()
  "toggle between rainbow and dim parens"
  (interactive)
  (rainbow-delimiters-mode)
  (paren-face-mode))

(add-hook 'sly-db-hook 'turn-off-evil-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Core Packages
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;evl
;;;;;; ;;      ;; ;;;;;; ;;
;;     ;;      ;;   ;;   ;;
;;;;     ;;  ;;     ;;   ;;
;;       ;;  ;;     ;;   ;;
;;;;;;     ;;     ;;;;;; ;;;;;;

(use-package evil
  :ensure t

  :init
  (setq evil-respect-visual-line-mode t)
  (evil-set-undo-system 'undo-redo)

  ;; Enable this if you want C-u to scroll up, more like pure Vim
  ;(setq evil-want-C-u-scroll t)

  :config
  ; >:D
  (evil-mode 1)

  ;; Configuring initial major mode for some modes
  ; (evil-set-initial-state 'vterm-mode 'emacs)

    (evil-global-set-key 'visual " ssr" 'geiser-eval-region)
  )

(defun use-new-config ()
  (shell-command "sudo nixos-rebuild switch")
  (restart-emacs))

(defun geiser-or-sly-doc ()
  (if sly-mode
    (sly-documentation)
    (geiser-doc-symbol-at-point)))

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (setq evil-leader/leader "<SPC>")
  (evil-leader/set-key
    ; very general
    "w" 'evil-save
    ; u => unicode
    "u" 'insert-char

    "g" 'magit

    ; mgmt of modes i want to toggle more often
    "mp" 'paredit-mode
    "ms" 'text-scale-adjust

    ; buffers
    "be" 'counsel-switch-buffer
    ;; gonna try to stick to C-w commands
    ;; "bn" 'evil-buffer
    ;; "bs" 'evil-split-buffer
    ;; "bv" 'evil-window

    ; config mgmt
    "ce" 'open-init.el
    ; "cev" 'open-vim-like.el
    ; "ces" 'open-scheme.el
    "cr" 'use-new-config

    ; scheme
    ; si => scheme inferior (avoids conflicts)
    "sir" 'geiser-chez
    "sil" 'geiser-load-file
    ; it's funny how you find the thing you really need eventually
    "sii" 'geiser-repl-switch
    ; (not scheme, sorry)
    "sis" 'sly

    ; ss => scheme send
    "sss" 'geiser-eval-last-sexp
    ;; "ssr" 'geiser-eval-region
    "ssd" 'geiser-eval-definition
    ; ssa => scheme send all
    "ssa" 'geiser-eval-buffer

    ; scheme/lispy-editing
    "swp" 'paredit-wrap-round
    "swb" 'paredit-wrap-square
    "swc" 'paredit-wrap-curly
    "swa" 'paredit-wrap-angled

    ; gonna just port most of my vscode stuff even though i don't hate the C-<left> stuff
    "sh" 'paredit-backward-slurp-sexp
    "sl" 'paredit-forward-slurp-sexp
    "bh" 'paredit-backward-barf-sexp
    "bl" 'paredit-forward-barf-sexp

    "st" 'transpose-sexps
    "s?" 'paredit-convolute-sexps

    "sk" 'backward-sexp
    "sj" 'forward-sexp

    "sd" 'geiser-or-sly-doc

    ; killing is common enough to be worth its own prefix
    ; non-lisp killing is more than covered by normal vim stuff lol
    "kh" 'backward-kill-sexp
    "kl" 'kill-sexp

    ; irc
    "il" 'erc-tls
    "ij" 'erc-join-channel
    "ic" 'erc-switch-to-buffer
    "is" 'erc-server-select
    "ia" 'erc-track-switch-buffer

    ; clojure
    "cii" 'cider-jack-in
    "cim" 'cider-inspire-me

    ; cs => clojure send
    ; css lol
    "css" 'cider-eval-last-sexp
    "csa" 'cider-eval-buffer
    "csd" 'cider-eval-defun-at-point
    "csn" 'cider-ns-reload

    ; cf => clojure fix?
    "cfl" 'clojure-move-to-let
    "cfp" 'clojure-cyle-privacy
    "cfi" 'clojure-toggle-ignore
    "cff" 'clojure-thread-first-all
    "cfl" 'clojure-thread-last-all

    ; cd => clojure doc
    "cd" 'cider-doc

    ; haskell
    "hg" 'haskell-hoogle
    ))

(use-package evil-goggles
  :ensure t

  :init
  (setq evil-goggles-pulse t)
  ; i don't like how deleted stuff says so long
  (setq evil-goggles-blocking-duration 0.1)

  :config
  (evil-goggles-mode)
  (evil-goggles-use-diff-faces))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

(use-package evil-org
  :ensure t
  :config
  (evil-commentary-mode))

; hi nix
; hi .emacs.d

; erc
(use-package erc-hl-nicks
  :ensure t)

(erc-log-mode)
(setq erc-nick-uniquifier "`"
      erc-nick "mehbark"
      erc-autojoin-channels-alist '(("Libera.Chat" "#scheme" "#chez" "#lisp" "#commonlisp" "#racket" "#clojure" "#chicken" "#emacs" "#s-expressions"))
      erc-interpret-mirc-color t
      erc-sasl-mechanism "plain"
      erc-sasl-user "mehbark"
      erc-save-buffer-on-part t
      erc-save-queries-on-quit nil
      erc-log-write-after-send t
      erc-log-write-after-insert t
      erc-kill-buffer-on-part t
      erc-kill-server-buffer-on-quit t
      erc-hide-list '("JOIN" "PART" "QUIT"))

; critical functionality
(require 'zone)
;(setq zone-timer (run-with-idle-timer 120 t 'zone))

; hsk
(use-package direnv
  :ensure t
  :config
  (direnv-mode))

; yay
(setq confirm-kill-processes nil)
(setq auto-save-interval 100)

(use-package maxima
  :init
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0)
	  maxima-display-maxima-buffer nil)
  (add-to-list 'auto-mode-alist
		 (cons "\\.mac\\'" 'maxima-mode))
  (add-to-list 'interpreter-mode-alist
		 (cons "maxima" 'maxima-mode)))
''
