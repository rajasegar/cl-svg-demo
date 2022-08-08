(in-package :cl-user)
(defpackage cl-svg-demo.config
  (:use :cl)
  (:import-from :envy
                :config-env-var
                :defconfig)
  (:export :config
           :*application-root*
           :*static-directory*
           :*template-directory*
           ;; :*raw-svg-directory*
           ;; :*djula-svg-directory*
           :appenv
           :developmentp
           :productionp))
(in-package :cl-svg-demo.config)

(setf (config-env-var) "APP_ENV")

(defparameter *application-root*   (asdf:system-source-directory :cl-svg-demo))
(defparameter *static-directory*   (merge-pathnames #P"static/" *application-root*))
(defparameter *template-directory* (merge-pathnames #P"templates/" *application-root*))
;; (defparameter *raw-svg-directory* (merge-pathnames #P"static/svgs/" *application-root*))
;; (defparameter *djula-svg-directory* (merge-pathnames #P"templates/svgs/" *application-root*))

(defconfig :common
  `(:databases ((:maindb :sqlite3 :database-name ":memory:"))))

(defconfig |development|
  '())

(defconfig |production|
  '())

(defconfig |test|
  '())

(defun config (&optional key)
  (envy:config #.(package-name *package*) key))

(defun appenv ()
  (uiop:getenv (config-env-var #.(package-name *package*))))

(defun developmentp ()
  (string= (appenv) "development"))

(defun productionp ()
  (string= (appenv) "production"))
