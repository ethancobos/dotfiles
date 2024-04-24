
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ethan Cobos"
      user-mail-address "ethan.cobos@tufts.edu")

;; ************************************ Font and Theme ************************************ ;;

(setq doom-font                (font-spec :family "JetBrainsMonoNL Nerd Font" :size 12)
      doom-big-font            (font-spec :family "JetBrainsMonoNL Nerd Font" :size 24))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :weight normal :slant normal))

(defvar dark-mode t)
(load-theme 'catppuccin t)
(defun toggle-theme ()
    (interactive)
    (if dark-mode
        (progn
            (setq catppuccin-flavor 'latte)
            (catppuccin-reload)
            (setq dark-mode nil))
        (progn
            (setq catppuccin-flavor 'mocha)
            (catppuccin-reload)
            (setq dark-mode t)
       )
    )
)

(global-set-key (kbd "C-c t") 'toggle-theme)

;; ************************************ Centaur Tabs ************************************ ;;

(global-set-key (kbd "<backtab>") 'centaur-tabs-backward)
(after! evil
  (define-key evil-normal-state-map (kbd "<C-tab>") 'centaur-tabs-forward))


;; ************************************ Misc ************************************ ;;

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Sets the initial window size of doom emacs
(setq initial-frame-alist
      '((top . 0)
        (left . 0)
        (width . 157)
        (height . 38)
        (menu-bar-lines . 0)))


;; ************************************ NeoTree ************************************ ;;

(with-eval-after-load 'doom-themes
  (doom-themes-neotree-config))
(setq doom-themes-neotree-file-icons t)

;; ********************************* Custom Faces ********************************** ;;

(custom-set-faces!
  '(neo-file-link-face
    :underline nil
    :foreground "#cdd6f4")
  '(neo-dir-link-face
    :bold nil
    :underline nil
    :foreground "#89b4fa")
  '(doom-themes-neotree-text-file-face
    :foreground "#f9e2af")
  '(doom-themes-neotree-data-file-face
    :foreground "#a6e3a1")
  '(doom-themes-neotree-media-file-face
    :foreground "#eba0ac")
  '(spell-fu-incorrect-face
    :underline (:style wave
                :color "#f5c2e7")))

;; ********************************** Spell-fu *********************************** ;;

(setq spell-fu-word-delimit-camel-case t)
