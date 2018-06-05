(in-package :cl-user)
(defpackage common-lisp-blog
  (:use :cl
		:cl-env)
  (:import-from :common-lisp-blog.config
                :config)
  (:import-from :clack
                :clackup)
  (:export :start
           :stop))
(in-package :common-lisp-blog)

(defvar *appfile-path*
  (asdf:system-relative-pathname :common-lisp-blog #P"app.lisp"))

(defvar *env*
  (asdf:system-relative-pathname :common-lisp-blog #P".env"))

(defvar *handler* nil)

(defun start (&rest args &key server port debug &allow-other-keys)
  (declare (ignore server port debug))
  (when *handler*
    (restart-case (error "Server is already running.")
      (restart-server ()
        :report "Restart the server"
        (stop))))
  (setf *handler*
        (apply #'clackup *appfile-path* args)))

(defun stop ()
  (prog1
      (clack:stop *handler*)
    (setf *handler* nil)))
