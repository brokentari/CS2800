#|

 Lab 2 Problem Set.

 Make sure you are in ACL2s mode. This is essential! Note that you can
 only change the mode when the session is not running, so set the
 correct mode before starting the session.

 For each function definition, you must provide both contracts and a
 body.  You must also ALWAYS supply your own tests, and sufficiently
 many, in addition to the tests sometimes provided. The number of
 tests should reflect the data definitions relevant for the problem,
 and the difficulty of the function.

 Write tests using ACL2s' check= function.

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Use defdata to define a list of booleans (Boollist)

(defdata boollist ...)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Use defdata to define a list of natural numbers (Natlist)

(defdata natlist ...)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Use defdata to define a type consisting of booleans or nats (BoolNat)

(defdata boolnat ...)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Use defdata to define a list of natural numbers or booleans
; (NatBoollist)

(defdata natboollist ...)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Use defdata to define a non-empty list of rationals (ne-lor)

(defdata ne-lor ...)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; bodd : Boollist -> ??
;
; (bodd l) is t if an odd number of the elements in l are t,
; and nil otherwise.
;
; Define bodd. What should ?? be?

(definec bodd ...
  )

(check= (bodd '(nil t nil t)) nil)
(check= (bodd '(t nil t t)) t)
...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; n-times: TL x All x Int  -> Bool
;
; (n-times l a n) returns t if l contains a at least n times and nil otherwise.
;
; Define n-times

(definec n-times ...
  )
   
(check= (n-times '() 5 -1) t)
(check= (n-times '(4 a 5 b) 5 1) t)
(check= (n-times '(4 a 5 b) 5 3) nil)
...


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; count-bools: NatBoollist -> ??
;
; count-bools counts the number of booleans in the NatBoollist
;
; Define count-bools

(definec count-bools ...
  )

(check= (count-bools '(1 nil 4 5)) 1)
(check= (count-bools '(1 nil 4 2 5)) 1)
...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; compress : TL -> TL

; (compress l) replaces consecutive occurrences of an element
; by a single occurrence.
;
; Define compress

(definec compress 
  ...)

(check= (compress '(1 1 1 2 3 3 2 2 2 2)) '(1 2 3 2))
...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; delete-element: All x TL -> TL

; (delete-element: e l) deletes every occurrence of e in l
;
; Define delete-element

(definec delete-element ...)

(check= (delete-element '(1 0) '(1 0 (0 1) (1 0) ((1 0)) (1 0)))
        '(1 0 (0 1) ((1 0))))
(check= ...)
(check= ...)
...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; replace-occurrence: All x All x All -> All

; (replace-occurrence: old new x) replaces every occurrence of old by
; new in x
;
; Define replace-occurrence

(definec replace-occurrence ...)

(check= (replace-occurrence 1 2 1) 2)
(check= (replace-occurrence 1 2 '(0 . 1)) '(0 . 2))
(check= (replace-occurrence '(2 1) '(1 2) '(1 2 (1 2) (2 1) ((2 1))))
        '(1 2 (1 2) (1 2) ((1 2))))
(check= ...)
(check= ...)

...

; Fill in the ...'s and explain what is going on.

(check= (replace-occurrence nil 5 '((1 . 2) (1 nil 2))) ...)
