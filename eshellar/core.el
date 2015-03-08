;;; core -*- lexical-binding: t; coding: utf-8; -*-

;;; Code:

(require 'cl-lib)
(require 'seq)
(require 'eshellar-vars "eshellar/vars")

(cl-defun eshellar:init ()
  (seq-each
   #'eshellar:init-cellar
   eshellar:cellars))

(cl-defun eshellar:init-cellar (directory)
  (cl-letf* ((dir (expand-file-name directory))
             (bottles (eshellar:list-bottles dir)))
    (seq-each
     #'eshellar:load-bottle
     bottles)))

(cl-defun eshellar:list-bottles (dir)
  (cl-letf ((bot-dir (expand-file-name "bottles" dir)))
    (if (file-exists-p bot-dir)
        (seq-map
         (lambda (b) (expand-file-name (symbol-name b) bot-dir))
         eshellar:bottles)
      nil)))

(cl-defun eshellar:load-bottle (bottle)
  (eshellar:bottle-init-el bottle)
  (eshellar:bottle-bin-path bottle))

(cl-defun eshellar:bottle-init-el (bottle)
  (cl-letf ((init (expand-file-name "init.el" bottle)))
    (if (file-exists-p init)
        (load init))))

(cl-defun eshellar:bottle-bin-path (bottle)
  (cl-letf ((bin (file-name-as-directory (expand-file-name "bin" bottle))))
    (if (file-directory-p bin)
        (eshellar:add-exec-path bin))))

(provide 'eshellar-core)

;;; core.el ends here
