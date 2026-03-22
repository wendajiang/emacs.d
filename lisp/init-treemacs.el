;; init-treemacs.el --- Initialize treemacs.	-*- lexical-binding: t -*-


;;; Commentary:
;;
;; Treemacs: A tree layout file explorer.
;;

;;; Code:


;; A tree layout file explorer
(use-package treemacs
  :functions (treemacs-follow-mode
              treemacs-filewatch-mode
              treemacs-git-mode
              treemacs-set-scope-type)
  :custom-face
  (cfrs-border-color ((t (:inherit posframe-border))))
  :bind (([f8]        . treemacs)
         ("M-0"       . treemacs-select-window)
         ("C-x t 1"   . treemacs-delete-other-windows)
         ("C-x t t"   . treemacs)
         ("C-x t b"   . treemacs-bookmark)
         ("C-x t C-t" . treemacs-find-file)
         ("C-x t M-t" . treemacs-find-tag)
         :map treemacs-mode-map
         ([mouse-1]   . treemacs-single-click-expand-action))
  :config
  (progn
    (setq treemacs-collapse-dirs           (if treemacs-python-executable 3 0)
          treemacs-missing-project-action  'remove
          treemacs-user-mode-line-format   'none
          treemacs-sorting                 'alphabetic-asc
          treemacs-follow-after-init       t
          treemacs-width                   30
	  treemacs-project-follow-mode     t
	  treemacs-project-follow-cleanup  t
          treemacs-no-png-images           nil)
    )

  ;; (treemacs-follow-mode t)
  (treemacs-tag-follow-mode t)
  (treemacs-filewatch-mode t)
  (pcase (cons (not (null (executable-find "git")))
               (not (null (executable-find "python3"))))
    (`(t . t)
     (treemacs-git-mode 'deferred))
    (`(t . _)
     (treemacs-git-mode 'simple)))

  (use-package treemacs-evil
    :after (treemacs evil)
    :ensure t)

  (use-package treemacs-projectile
    :after (treemacs projectile)
    :ensure t)
  

  (use-package treemacs-icons-dired
    :hook (dired-mode . treemacs-icons-dired-enable-once)
    :ensure t)
    

  (use-package treemacs-magit
    :after (treemacs magit)
    :demand t)

  (use-package treemacs-perspective
    :after (treemacs perspective)
    :ensure t
    :config (treemacs-set-scope-type 'Perspectives))

  (use-package treemacs-tab-bar
    :after (treemacs)
    :demand t
    :config (treemacs-set-scope-type 'Tabs)))

(treemacs-start-on-boot)

(provide 'init-treemacs)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-treemacs.el ends here
