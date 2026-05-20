;;; init-elfeed.el --- Programming development -*- lexical-binding: t -*-
;;; commentary:

;;; code:
(use-package elfeed
  :quelpa (elfeed :fetcher github :repo "emacs-elfeed/elfeed")
  :ensure t
  :custom
  ;; (elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory)) ; uncomment this line and 
  ;; (elfeed-db-directory "~/plrjorg/elfeed") ; comment this line if you want elfeed to write to your .emacs.d
  ;; (elfeed-enclosure-default-dir "~/plrjorg/Downloads/") ; or wherever you want downloads to go
  (elfeed-search-remain-on-entry t)
  (elfeed-search-title-max-width 100)
  (elfeed-search-title-min-width 30)
  (elfeed-search-trailing-width 25)
  (elfeed-show-truncate-long-urls t)
  (elfeed-sort-order 'descending)
  :bind
  (:map elfeed-search-mode-map
        ("w" . elfeed-search-yank)
        ("R" . elfeed-update)
        ("Q" . elfeed-kill-buffer)
        )
  (:map elfeed-show-mode-map
        ("S"     . elfeed-show-new-live-search) ; moved to free up 's'
        ("c"     . (lambda () (interactive) (org-capture nil "capture")))
        ("e"     . email-elfeed-entry)
        ("f"     . elfeed-show-fetch-full-text)
        ("w"     . elfeed-show-yank)
        )
  :hook
  (elfeed-show-mode . visual-line-mode) ; make reading pretty
  (elfeed-show-mode . olivetti-mode   ) ; make reading pretty
  )

;; elfeed-org
(use-package elfeed-org
  :ensure t
  :after elfeed
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org")))

(with-eval-after-load 'elfeed
  (elfeed-org))

(provide 'init-elfeed)

;;; init-elfeed.el ends here
