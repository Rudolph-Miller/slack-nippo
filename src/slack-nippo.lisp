(in-package :cl-user)
(defpackage slack-nippo
  (:use :cl
        :annot.doc
        :slack-nippo.trello
        :slack-nippo.channel
        :slack-nippo.message
        :slack-nippo.format)
  (:import-from :local-time
                :today
                :clone-timestamp
                :subzone-offset
                :timezone-subzones
                :*default-timezone*
                :nsec-of
                :sec-of
                :timestamp-
                :timestamp+)
  (:shadow :id
           :name))
(in-package :slack-nippo)

(syntax:use-syntax :annot)

(defparameter *nippo-hour* 5)

(defun make-nippo (channel-name &key (date (today)) (stream t))
  (get-cards "To Do" "Task")
  (let* ((date (clone-timestamp date))
         (offset (subzone-offset
                  (elt (timezone-subzones *default-timezone*) 0)))
         (today (progn (setf (nsec-of date) 0)
                       (setf (sec-of date) 0)
                       (timestamp- date offset :sec)))
         (oldest (timestamp+ today *nippo-hour* :hour))
         (latest (timestamp+ oldest 1 :day))
         (channel (get-channel channel-name))
         (messages (get-messages channel
                                 :oldest oldest
                                 :latest latest
                                 :count 10000)))
    (format-messages messages stream)))
