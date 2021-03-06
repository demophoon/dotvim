;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; vim: ft=lisp
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun my/current-session ()
  (interactive)
  (goto-char (point-max))
  (search-backward "Session ")
  (org-narrow-to-subtree)
  (goto-char (point-max))
  )

(defun my/jira-ticket-template ()
  (interactive)
  (shell-command-to-string (format "~/.local/bin/jira-ticket %s" (read-string "Jira Ticket: ")))
  )

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(html
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     ;; auto-completion
     ;; better-defaults
     emacs-lisp
     ;; git
     ;; markdown
     multiple-cursors
     neotree
     (org :variables org-enable-reveal-js-support t)
     org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control
     graphviz
     appt
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '()

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Inconsolata"
                               :size 24
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)

   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

(setq neo-theme 'nerd)

;; (setq appt-time-msg-list nil)
(setq appt-display-interval '5)
(setq
  appt-message-warning-time '15
  appt-display-mode-line nil
  appt-display-interval 'window)
(appt-activate 1)
(display-time)

(org-agenda-to-appt)
(run-at-time "24:01" 900 'org-agenda-to-appt)
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)

(defun my/notify-user (min-to-app new-time msg)
  (shell-command (concat "/usr/bin/notify-send"
                         " 'Org-mode'"
                         " '" msg "'")))

(setq appt-disp-window-function (function my/notify-user))

;; Follow symlinks in to git repos
(setq vc-follow-symlinks t)

;; Setup reveal slide deck
;;(require 'ox-reveal)
(setq Org-Reveal-root "file:///home/britt/Nextcloud/Org/Slides/Reveal/")
(setq Org-Reveal-title-slide nil)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)

(setq org-todo-keywords
      '(
        (sequence "TODO(t)" "IN_PROGRESS(p)" "BLOCKED(!)" "SCHEDULED(s)" "IN_CR(r)" "|" "DONE(d)")
        ))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
        ("IN_PROGRESS" . "yellow")
        ("SCHEDULED" . "yellow")
        ("IN_CR" . "yellow")
        ("BLOCKED" . (:foreground "white" :background "red" :weight bold))
        ))

(setq org-tag-alist '(
                      (:startgroup . nil)
                      ("Work" . ?w) ("Personal" . ?p)
                      (:endgroup . nil)
                      (:startgroup . nil)
                      ("Meeting" . ?m) ("Tips" . ?t) ("Misc" . ?x)
                      ("Finance" . ?f) ("Errand" . ?e) ("Fun" ?F)
                      (:endgroup . nil)
                      ("Archived" . ?A)
                      ))

(setq org-tag-faces
      '(("Archived" . (:foreground "#606060"))
        ))

;; Make Org mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; Add these files to Org mode agenda
(setq org-agenda-files (list "~/Nextcloud/Org/"
                             "~/Nextcloud/Org/Calendars/"))

(setq org-refile-targets '((nil :maxlevel . 9)
                           (org-agenda-files :maxlevel . 9)
                           ("~/Nextcloud/Org/Archives/Work.org" :maxlevel . 9)
                           ("~/Nextcloud/Org/Archives/Personal.org" :maxlevel . 9)))
;;(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path t)

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cr" 'org-refile)

(setq org-capture-templates (list))

;; Work Tasks
;; ================================================================================
(add-to-list 'org-capture-templates '("w" "Work"))
(add-to-list 'org-capture-templates '("wt" "Todo" entry (file+headline "~/Nextcloud/Org/Work.org" "Tasks")
                                      "* TODO %?" :prepend t))
(add-to-list 'org-capture-templates '("wj" "Jira Ticket (CircleCI)" entry (file+headline "~/Nextcloud/Org/Work.org" "Sprint Tickets")
(function my/jira-ticket-template) :prepend t))
(add-to-list 'org-capture-templates '("w1" "1:1" entry (file+headline "~/Nextcloud/Org/Work.org" "Meetings")
 "* TODO %u %^{Who are you meeting with?} / Britt   :1on1:
%T
** Pre-meeting notes
** Notes
** Action Items" :prepend t))

(add-to-list 'org-capture-templates '("wm" "Generic" entry (file+headline "~/Nextcloud/Org/Work.org" "Meetings")
"* TODO %u %?
%T
** Pre-meeting notes
** Notes
** Action Items" :prepend t))
(add-to-list 'org-capture-templates '("wn" "Note" entry (file+headline "~/Nextcloud/Org/Work.org" "Notes")
"* %u %?
%T" :prepend t))

;; Personal
;; ================================================================================
(add-to-list 'org-capture-templates '("p" "Personal"))
(add-to-list 'org-capture-templates '("pt" "Todo" entry (file+headline "~/Nextcloud/Org/Personal.org" "Tasks")
                                      "* TODO %?" :prepend t))
(add-to-list 'org-capture-templates '("pp" "Project" entry (file+headline "~/Nextcloud/Org/Personal.org" "Projects")
                                      "* TODO %?" :prepend t))
(add-to-list 'org-capture-templates '("pj" "Journal" entry (file+olp+datetree "~/Nextcloud/Org/Journal.org")
"* Comments - %U
:PROPERTIES:
:Mood: %^{Rate your mood from 1-10:}
:Severity: %^{Rate severity of mood from 1-10:}
:END:
%?" :prepend t :tree-type week))

(add-to-list 'org-capture-templates '("pm" "Meeting" entry (file+headline "~/Nextcloud/Org/Personal.org" "Meetings")
"* %u %?
%T
** Pre-meeting notes
** Notes
** Action Items" :prepend t))

;; Blog Post Template
;; ================================================================================
(add-to-list 'org-capture-templates '("b" "Blog" entry (file+headline "~/Nextcloud/Org/Blogs.org" "Blogs")
 "* Draft %?
** Notes
" :prepend t))

;; D&d templates
;; ================================================================================
(add-to-list 'org-capture-templates '("d" "D&D"))

(defun my/add-dnd-campaign (campaign-name)
  (let ((short-hand (concat "d" (downcase (substring campaign-name 0 1))))
        (dnd-filename (concat "~/Nextcloud/dnd/" (downcase campaign-name) "/dnd.org"))
        )
    (add-to-list 'org-capture-templates (list short-hand campaign-name))
    (add-to-list 'org-capture-templates (list (concat short-hand "s") "Session" 'entry (list 'file+headline dnd-filename "Sessions")
     "* Session %^{Session number}
%?
"))

    (add-to-list 'org-capture-templates (list (concat short-hand "n") "Quick Note" 'plain (list 'file+function dnd-filename 'my/current-session)
"
%?"))

    (add-to-list 'org-capture-templates (list (concat short-hand "c") "Character" 'entry (list 'file+headline dnd-filename "Characters")
     "* %^{Character name} %^g
%^{Met_Location}p
%?

** Bonds
** Appearance
"))

    (add-to-list 'org-capture-templates (list (concat short-hand "g") "Group" 'entry (list 'file+headline dnd-filename "Groups")
     "* %^{Group name}
%^{Met_Location}p
%?

** Bonds
"))

    (add-to-list 'org-capture-templates (list (concat short-hand "l") "Location" 'entry (list 'file+headline dnd-filename "Locations")
     "* %^{Location name}
%?
"))

    (add-to-list 'org-capture-templates (list (concat short-hand "q") "Quest" 'entry (list 'file+headline dnd-filename "Quests")
     "* TODO %^{Quest name}
%?

** Reward
"))

    ;; Items
    (add-to-list 'org-capture-templates (list (concat short-hand "i") "Item"))

    ;; Individual Item
    (add-to-list 'org-capture-templates (list (concat short-hand "ii") "Your Item" 'table-line (list 'file+olp dnd-filename "Items" "Individual")
     "| %^{Item Name} | %^{Quantity} | %^{Cost} | =(%\2 * %\3) |"
     :immediate-finish t :table-line-pos "II-1"))

    ;; Group Item
    (add-to-list 'org-capture-templates (list (concat short-hand "ig") "Group Item" 'table-line (list 'file+olp dnd-filename "Items" "Group")
     "| %^{Item Name} | %^{Quantity} | %^{Cost} | =(%\2 * %\3) |"
     :immediate-finish t :table-line-pos "II-1"))

    )
  )

(let ((campaigns (list "Saltmarsh" "Waterdeep")))
    (mapc 'my/add-dnd-campaign campaigns)
  )



    (setq org-log-done 'time)

;; Disable Mouse
  ;; Dummy function
  (defun silence ()
    (interactive))
  ;; Don't jump the cursor around in the window on clicking
  (define-key evil-motion-state-map [down-mouse-1] 'silence)
  ;; also avoid any '<mouse-1> is undefined' when setting to 'undefined
  (define-key evil-motion-state-map [mouse-1] 'silence)

;; C-hjkl
(global-set-key (kbd "C-h") 'evil-window-left)
(global-set-key (kbd "C-j") 'evil-window-down)
(global-set-key (kbd "C-k") 'evil-window-up)
(global-set-key (kbd "C-l") 'evil-window-right)

  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-Y-yank-to-eol nil)
 '(org-agenda-custom-commands
   (quote
    (("t" "Unfiled Tasks" alltodo ""
      ((org-agenda-tag-filter-preset
        (quote
         ("+Mobile")))))
     ("r" . "Review")
     ("ra" "Overall Review" agenda ""
      ((org-agenda-span 8)
       (org-agenda-start-day "-1w")
       (org-agenda-start-on-weekday 1)
       (org-agenda-log-mode-items
        (quote
         (state)))
       (org-agenda-show-log t)
       (org-agenda-start-with-log-mode t)
       (org-agenda-skip-function
        (quote
         (org-agenda-skip-entry-if
          (quote todo)
          (quote todo))))))
     ("rA" "Ready for Archive" tags "ARCHIVE:Work|ARCHIVE:Personal"
      ((org-agenda-log-mode-items t)
       (org-agenda-show-log t)
       (org-agenda-start-with-log-mode t)
       (org-agenda-archives-mode t)
       (org-agenda-overriding-header "Mark with 'm' and Archive with 'B$'")))
     ("rw" "Work Standup" agenda ""
      ((org-agenda-span 8)
       (org-agenda-start-day "-1w")
       (org-agenda-start-on-weekday 1)
       (org-agenda-log-mode-items
        (quote
         (state)))
       (org-agenda-show-log t)
       (org-agenda-start-with-log-mode t)
       (org-agenda-skip-function
        (quote
         (org-agenda-skip-entry-if
          (quote todo)
          (quote todo))))
       (org-agenda-tag-filter-preset
        (quote
         ("+Work")))))
     ("rp" "Personal Week" agenda ""
      ((org-agenda-span
        (quote fortnight))
       (org-agenda-start-day "-1w")
       (org-agenda-start-on-weekday 1)
       (org-agenda-log-mode-items
        (quote
         (state)))
       (org-agenda-show-log t)
       (org-agenda-start-with-log-mode t)
       (org-agenda-skip-function
        (quote
         (org-agenda-skip-entry-if
          (quote todo)
          (quote todo))))
       (org-agenda-tag-filter-preset
        (quote
         ("-Work")))))
     ("w" "Work Agenda"
      ((todo "BLOCKED"
             ((org-agenda-overriding-header "Blocked Items")))
       (tags-todo "Work:GTD_Today"
                  ((org-agenda-skip-function
                    (quote
                     (org-agenda-skip-entry-if
                      (quote todo)
                      (quote done)
                      (quote in_progress))))
                   (org-agenda-overriding-header "Today's Goals")))
       (tags-todo "Work:JIRA"
                  ((org-agenda-overriding-header "Open Tickets")))
       (tags-todo "Work:Tasks|Work:Meeting-1on1"
                  ((org-agenda-overriding-header "Tasks")))
       (tags-todo "1on1"
                  ((org-agenda-overriding-header "1 on 1 Agenda Items")
                   (org-agenda-prefix-format ""))))
      nil)
     ("p" "Personal Agenda"
      ((todo "BLOCKED" nil)
       (tags-todo "Personal:Tasks"
                  ((org-agenda-overriding-header "Tasks")))
       (tags-todo "Blogs"
                  ((org-agenda-overriding-header "Blogs"))))
      nil)
     ("n" "Agenda and all TODOs"
      ((agenda "" nil)
       (alltodo "" nil))
      nil))))
 '(org-stuck-projects
   (quote
    ("+LEVEL=2/-DONE"
     ("TODO" "NEXT" "NEXTACTION" "IN_PROGRESS" "CANCELED" "DELEGATED" "ASKED")
     nil "")))
 '(package-selected-packages
   (quote
    (ox-reveal ws-butler writeroom-mode winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toc-org tagedit symon string-inflection spaceline-all-the-icons slim-mode scss-mode sass-mode restart-emacs request rainbow-delimiters pug-mode prettier-js popwin persp-mode pcre2el password-generator paradox overseer org-projectile org-present org-pomodoro org-mime org-download org-bullets org-brain open-junk-file neotree nameless move-text macrostep lorem-ipsum linum-relative link-hint less-css-mode indent-guide impatient-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-xref helm-themes helm-swoop helm-purpose helm-projectile helm-org-rifle helm-mode-manager helm-make helm-flx helm-descbinds helm-css-scss helm-ag google-translate golden-ratio gnuplot font-lock+ flx-ido fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-org evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu emmet-mode elisp-slime-nav editorconfig dumb-jump dotenv-mode doom-modeline diminish define-word counsel-projectile column-enforce-mode clean-aindent-mode centered-cursor-mode auto-highlight-symbol auto-compile aggressive-indent ace-window ace-link ace-jump-helm-line))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
