;;; eshellar -*- lexical-binding: t; coding: utf-8; -*-

;;; Code:

(require 'cl-lib)

(defcustom eshellar (expand-file-name "eshellar" user-emacs-directory)
  "Directory to store bottles")

(defcustom eshellar:bottles '()
  "List of bottle names")

(cl-defun eshellar:init (&optional directory)
  (cl-letf* ((dir (if directory directory
                    eshellar))
             (bottles (eshellar:list-bottles dir)))
    (cl-mapc
     'eshellar:load-bottle
     bottles)))

(cl-defun eshellar:list-bottles (dir)
  (cl-letf ((bot-dir (expand-file-name "bottles" dir)))
    (if (file-exists-p bot-dir)
        (cl-mapcar
         (lambda (b) (expand-file-name (symbol-name b) bot-dir))
         eshellar:bottles)
      nil)))

(cl-defun eshellar:load-bottle (bottle)
  (cl-letf ((init (expand-file-name "init.el" bottle)))
    (if (file-exists-p init)
        (load init))))

(require 'eshellar-util "eshellar/util")

(provide 'eshellar)

;;; eshellar.el ends here
