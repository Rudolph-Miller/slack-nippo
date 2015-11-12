#|
  This file is a part of slack-nippo project.
  Copyright (c) 2015 Rudolph Miller (chopsticks.tk.ppfm@gmail.com)
|#

(in-package :cl-user)
(defpackage slack-nippo-asd
  (:use :cl :asdf))
(in-package :slack-nippo-asd)

(defsystem slack-nippo
  :version "0.1"
  :author "Rudolph Miller"
  :license "MIT"
  :homepage "https://github.com/Rudolph-Miller/slack-nippo"
  :depends-on (:cl-syntax
               :cl-syntax-annot
               :quri
               :flexi-streams
               :dexador
               :jonathan
               :anaphora)
  :components ((:module "src"
                :serial t
                :components
                ((:file "util")
                 (:file "fetch")
                 (:file "channel")
                 (:file "message")
                 (:file "slack-nippo"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.md"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op slack-nippo-test))))
