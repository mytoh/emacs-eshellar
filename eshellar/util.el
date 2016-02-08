;;; util -*- lexical-binding: t; coding: utf-8; -*-

;;; Code:

(require 'cl-lib)

(cl-defun eshellar:add-exec-path (path)
  (add-to-list 'exec-path (expand-file-name path)))

(cl-defun eshellar:add-alias (name def)
  (setq eshell-command-aliases-list
        (colle:conj
         (list name def)
         (colle:remove
          (lambda (l) (cl-equalp l (list name def)))
          eshell-command-aliases-list))))

(provide 'eshellar-util)

;;; util.el ends here
