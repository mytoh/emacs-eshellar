;;; util -*- lexical-binding: t; coding: utf-8; -*-

;;; Code:

(require 'cl-lib)

(cl-defun eshellar:add-exec-path (path)
          (add-to-list 'exec-path (expand-file-name path)))

(cl-defun eshellar:add-alias (name def)
          (add-to-list 'eshell-command-aliases-list (list name def)))

(provide 'eshellar-util)

;;; util.el ends here
