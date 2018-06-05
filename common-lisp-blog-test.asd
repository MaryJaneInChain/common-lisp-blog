(defsystem "common-lisp-blog-test"
  :defsystem-depends-on ("prove-asdf")
  :author "MaryJaneInChain"
  :license ""
  :depends-on ("common-lisp-blog"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "common-lisp-blog"))))
  :description "Test system for common-lisp-blog"
  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
