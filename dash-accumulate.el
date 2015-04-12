;;; dash-accumulate.el --- Accumulation functions proposed for dash  -*- lexical-binding: t; -*-

;; Copyright (C) 2015  Michael Pontus

;; Author: Michael Pontus <m.pontus@gmail.com>
;; Keywords: extensions

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:



;; Collect arguments for first argument FUNCTION. FUNCTION will be
;; called with single argument, which it will use to call upon with
;; arguments which will be added to final result. If PRED is a
;; function, it will determine applicable argument lists by accepting
;; them as only argument and returning non-nil.

;;;###autoload
(defun -accumulate (function &optional pred)
  (let (return) (funcall function
     (function (lambda (&rest args)
       (when (or (not pred) (funcall pred args))
         (!cons args return)))))
       (nreverse return)))

;;; Depending on the choice of primary function, one of the below can
;;; add (non-)anaphoric variant to them.

;;;###autoload
(defmacro --accumulate (form &optional pred)
  `(-accumulate (function (lambda (it) ,form)) ,pred))

;;; This function enabled anaphoric form below, alas it still fails
;;; tests and I spent a lot of time unsuccessfully trying to figure
;;; out why.

;; (defun -accumulate (function &optional pred)
;;   (--accumulate (funcall function it) pred))

;; Collect arguments for `it' during execution of FORM. If PRED is a
;; function it is called with list of arguments as a single argument
;; to determine if it will be included in result.

;;; FIXME: TEST FAIL

;; (defmacro --accumulate (form &optional pred)
;;   (declare (debug (form lambda-form)))
;;   (let ((r (make-symbol "result")))
;;     `(let (,r) (funcall
;;         (function (lambda (it) ,form))
;;         (function (lambda (&rest args)
;;           (when (or (not pred) (funcall pred args))
;;             (!cons args ,r)))))
;;        (nreverse ,r))))


(provide 'dash-accumulate)
;;; dash-accumulate.el ends here
