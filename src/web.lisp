(in-package :cl-user)
(defpackage cl-svg-demo.web
  (:use :cl
        :caveman2
        :cl-svg-demo.config
        :cl-svg-demo.view
        :cl-svg-demo.db
        :datafly
        :sxql)
  (:export :*web*))
(in-package :cl-svg-demo.web)

;; for @route annotation
(syntax:use-syntax :annot)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

(cl-djula-svg:copy-svg (merge-pathnames #P"static/svgs/" *application-root*) (merge-pathnames #P"templates/svgs/" *application-root*))

;;
;; Routing rules

(defroute "/" ()
  (render #P"index.html"))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
