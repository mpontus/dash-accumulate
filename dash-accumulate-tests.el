;;; dash-accumulate-tests.el --- Tests for accumulation function  -*- lexical-binding: t; -*-

;; Copyright (C) 2015  Michael Pontus

;; Author: Michael Pontus <m.pontus@gmail.com>
;; Keywords:

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

(ert-deftest -accumulate-test-without-pred ()
  "Test that `-accumulate' collects arguments it is being called with."
  (cl-labels ((test (fn) (mapc (-applify fn) '((1) (2 3) (4 5 6)))))
    (should (equal (-accumulate #'test) '((1) (2 3) (4 5 6))))))

(ert-deftest -accumulate-test-with-pred ()
  "Test that `-accumulate' will filter applicable arglists using pred."
  (cl-labels ((test (fn) (mapc fn (number-sequence 1 5))))
    (should (equal (-accumulate #'test (-applify 'oddp)) '((1) (3) (5))))))

(ert-deftest --accumulate-test-without-pred ()
  "Test that arguments applied to `it' too will show up in results."
  (cl-labels ((test (fn) (mapc fn '((1) (2 3) (4 5 6)))))
    (should (equal (--accumulate (test (-applify it))) '((1) (2 3) (4 5 6))))))

(ert-deftest --accumulate-test-with-pred ()
  "Test that PRED will prevent `it' from being called with wrong args."
  (cl-labels ((test (fn) (mapc (-applify fn) '((1) (2 3) (4 5 6)))))
    (should (equal (--accumulate (test it) (-not 'cdr)) '((1))))))


(provide 'dash-accumulate-tests)
;;; dash-accumulate-tests.el ends here
