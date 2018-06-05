(in-package :cl-user)
(defpackage common-lisp-blog.web
  (:use :cl
        :caveman2
        :common-lisp-blog.config
        :common-lisp-blog.view
        :common-lisp-blog.db
        :datafly
        :sxql)
  (:export :*web*))
(in-package :common-lisp-blog.web)

;; for @route annotation
(syntax:use-syntax :annot)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;
;; Routing rules
(defroute "/" ()
  (render #P"index.html"
		  (list :global
				(list :title (getenv "TITLE")
					  :description (getenv "DESCRIPTION")))))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
