(setq cc-ide-packages
      '(
        cc-mode
        ;; cmake-ide
        ;; company
        ;; irony
        ;; counsel
        ;; company-irony
        ;; company-irony-c-headers
        ;; irony-eldoc
        ;; flycheck
        ;; flycheck-irony
        rtags
        ))

(defun cc-ide/init-cc-mode ()
  (use-package cc-mode
    :defer t
    :config
    (progn
      (require 'compile)
      (c-toggle-auto-newline 1)
      (spacemacs/set-leader-keys-for-major-mode 'c-mode
        "ga" 'projectile-find-other-file
        "gA" 'projectile-find-other-file-other-window)
      (spacemacs/set-leader-keys-for-major-mode 'c++-mode
        "ga" 'projectile-find-other-file
        "gA" 'projectile-find-other-file-other-window))))



(defun rtags-evil-standard-keybindings (mode)
  (evil-leader/set-key-for-mode mode
    "r." 'rtags-find-symbol-at-point
    "r," 'rtags-find-references-at-point
    "rv" 'rtags-find-virtuals-at-point
    "rV" 'rtags-print-enum-value-at-point
    "r/" 'rtags-find-all-references-at-point
    "rY" 'rtags-cycle-overlays-on-screen
    "r>" 'rtags-find-symbol
    "r<" 'rtags-find-references
    "r[" 'rtags-location-stack-back
    "r]" 'rtags-location-stack-forward
    "rD" 'rtags-diagnostics
    "rG" 'rtags-guess-function-at-point
    "rp" 'rtags-set-current-project
    "rP" 'rtags-print-dependencies
    "re" 'rtags-reparse-file
    "rE" 'rtags-preprocess-file
    "rR" 'rtags-rename-symbol
    "rM" 'rtags-symbol-info
    "rS" 'rtags-display-summary
    "rO" 'rtags-goto-offset
    "r;" 'rtags-find-file
    "rF" 'rtags-fixit
    "rL" 'rtags-copy-and-print-current-location
    "rX" 'rtags-fix-fixit-at-point
    "rB" 'rtags-show-rtags-buffer
    "rI" 'rtags-imenu
    "rT" 'rtags-taglist
    "rh" 'rtags-print-class-hierarchy
    "ra" 'rtags-print-source-arguments
    )
  )


;; For each package, define a function rtags/init-<package-name>
;;
(defun cc-ide/init-rtags ()
  "Initialize my package"
  (use-package rtags
    :init
    ;;(evil-set-initial-state 'rtags-mode 'emacs)
    ;;(rtags-enable-standard-keybindings c-mode-base-map)
    ;; :ensure company
    :config
    (progn
      ;; (require 'company-rtags)
      ;; (add-to-list 'company-backends 'company-rtags)
      ;; (setq company-rtags-begin-after-member-access t)
      ;; (setq rtags-completions-enabled t)
      ;;(rtags-diagnostics)
      (require 'rtags)
      ;; (setq rtags-autostart-diagnostics t)
      (define-key evil-normal-state-map (kbd "RET") 'rtags-select-other-window)
      (define-key evil-normal-state-map (kbd "M-RET") 'rtags-select)
      (define-key evil-normal-state-map (kbd "q") 'rtags-bury-or-delete)

      (rtags-evil-standard-keybindings 'c-mode)
      (rtags-evil-standard-keybindings 'c++-mode)
      )
    )
  )

;; (defun cc-ide/init-rtags ()
;;   (use-package rtags
;;     :defer t
;;     :init
;;     (progn
;;       (require 'rtags)
;;       (setq rtags-autostart-diagnostics t)
;;       (rtags-enable-standard-keybindings)
;;       (setq rtags-use-helm t))))

;; (defun cc-ide/init-irony ()
;;   (add-hook 'c++-mode-hook 'irony-mode)
;;   (add-hook 'c-mode-hook 'irony-mode)
;;   (defun my-irony-mode-hook ()
;;     (define-key irony-mode-map
;;       [remap completion-at-point] 'counsel-irony)
;;     (define-key irony-mode-map
;;       [remap complete-symbol] 'counsel-irony))
;;   (add-hook 'irony-mode-hook 'my-irony-mode-hook)
;;   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))


;; (defun cc-ide/init-cmake-ide ()
;;   (cmake-ide-setup))

;; (defun cc-ide/post-init-company ()
;;   (spacemacs|add-company-hook c-mode-common))

;; (defun cc-ide/init-irony ()
;;   (use-package irony
;;     :defer t
;;     :commands (irony-mode irony-install-server)
;;     :init
;;     (progn
;;       ;; (add-hook 'c-mode-hook 'irony-mode)
;;       (add-hook 'c++-mode-hook 'irony-mode))
;;     :config
;;     (progn
;;       (setq irony-user-dir (f-slash (f-join user-home-directory "bin" "irony")))
;;       (setq irony-server-install-prefix irony-user-dir)
;;       (add-hook 'c++-mode-hook (lambda () (setq irony-additional-clang-options '("-std=c++11"))))
;;       (defun irony/irony-mode-hook ()
;;         (define-key irony-mode-map [remap completion-at-point] 'irony-completion-at-point-async)
;;         (define-key irony-mode-map [remap complete-symbol] 'irony-completion-at-point-async))

;;       (add-hook 'irony-mode-hook 'irony/irony-mode-hook)
;;       (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))))

;; (when (configuration-layer/layer-usedp 'auto-completion)
;;   (defun cc-ide/init-company-irony ()
;;     (use-package company-irony
;;       :if (configuration-layer/package-usedp 'company)
;;       :commands (company-irony)
;;       :defer t
;;       :init
;;       (progn
;;         (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
;;         (push 'company-irony company-backends-c-mode-common)))))

;; (when (configuration-layer/layer-usedp 'auto-completion)
;;   (defun cc-ide/init-company-irony-c-headers ()
;;     (use-package company-irony-c-headers
;;       :if (configuration-layer/package-usedp 'company)
;;       :defer t
;;       :commands (company-irony-c-headers)
;;       :init
;;       (push 'company-irony-c-headers company-backends-c-mode-common))))

;; (defun cc-ide/init-irony-eldoc ()
;;   (use-package irony-eldoc
;;     :commands (irony-eldoc)
;;     :init
;;     (add-hook 'irony-mode-hook 'irony-eldoc)))

;; (defun cc-ide/post-init-flycheck ()
;;   (dolist (mode '(c-mode c++-mode))
;;     (spacemacs/add-flycheck-hook mode)))

;; (when (configuration-layer/layer-usedp 'syntax-checking)
;;   (defun cc-ide/init-flycheck-irony ()
;;     (use-package flycheck-irony
;;       :if (configuration-layer/package-usedp 'flycheck)
;;       :defer t
;;       :init (add-hook 'irony-mode-hook 'flycheck-irony-setup))))

