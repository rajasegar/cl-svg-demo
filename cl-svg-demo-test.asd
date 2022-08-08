(defsystem "cl-svg-demo-test"
  :defsystem-depends-on ("prove-asdf")
  :author "Rajasegar Chandran"
  :license ""
  :depends-on ("cl-svg-demo"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "cl-svg-demo"))))
  :description "Test system for cl-svg-demo"
  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
