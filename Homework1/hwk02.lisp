; ****************** BEGIN INITIALIZATION FOR ACL2s MODE ****************** ;
; (Nothing to see here!  Your actual file is after this initialization code);
(make-event
 (er-progn
  (set-deferred-ttag-notes t state)
  (value '(value-triple :invisible))))

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading the CCG book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "acl2s/ccg/ccg" :uncertified-okp nil :dir :system :ttags ((:ccg)) :load-compiled-file nil);v4.0 change

;Common base theory for all modes.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s base theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "acl2s/base-theory" :dir :system :ttags :all)


#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s customizations book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "acl2s/custom" :dir :system :ttags :all)

;; guard-checking-on is in *protected-system-state-globals* so any
;; changes are reverted back to what they were if you try setting this
;; with make-event. So, in order to avoid the use of progn! and trust
;; tags (which would not have been a big deal) in custom.lisp, I
;; decided to add this here.
;; 
;; How to check (f-get-global 'guard-checking-on state)
;; (acl2::set-guard-checking :nowarn)
(acl2::set-guard-checking :all)

;Settings common to all ACL2s modes
(acl2s-common-settings)
;(acl2::xdoc acl2s::defunc) ;; 3 seconds is too much time to spare -- commenting out [2015-02-01 Sun]

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s customizations book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "acl2s/acl2s-sigs" :dir :system :ttags :all)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem setting up ACL2s mode.") (value :invisible))

(acl2::xdoc acl2s::defunc) ; almost 3 seconds

; Non-events:
;(set-guard-checking :none)

(set-inhibit-warnings! "Invariant-risk" "theory")

(in-package "ACL2")
(redef+)
(defun print-ttag-note (val active-book-name include-bookp deferred-p state)
  (declare (xargs :stobjs state)
	   (ignore val active-book-name include-bookp deferred-p))
  state)

(defun print-deferred-ttag-notes-summary (state)
  (declare (xargs :stobjs state))
  state)

(defun notify-on-defttag (val active-book-name include-bookp state)
  (declare (xargs :stobjs state)
	   (ignore val active-book-name include-bookp))
  state)
(redef-)

(acl2::in-package "ACL2S")

; ******************* END INITIALIZATION FOR ACL2s MODE ******************* ;
;$ACL2s-SMode$;ACL2s
#|

CS 2800 Homework 2 - Spring 2020

 - Due on Tuesday, January 28 by 10:00 pm.

 - But you *must* have your team request made by midnight of Saturday, 
   January 25. (If you are already a member of a team from homework
   1, you're all set.)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 For this homework you will need to use ACL2s.

 Technical instructions:

 - Open this file in ACL2s as hwk02.lisp

 - Make sure you are in ACL2s mode. This is essential! Note that you can
   only change the mode when the session is not running, so set the correct
   mode before starting the session.

 - Insert your solutions into this file where indicated (usually as "...")

 - Only add to the file. Do not remove or comment out anything pre-existing.

 - Make sure the entire file is accepted by ACL2s. In particular, there must
   be no "..." left in the code. If you don't finish all problems, comment
   the unfinished ones out. Comments should also be used for any English
   text that you may add. This file already contains many comments, so you
   can see what the syntax is.

 - When done, save your file and submit it as hwk02.lisp

 - Do not submit the session file (which shows your interaction with the theorem
   prover). This is not part of your solution. Only submit the lisp file.

Instructions for programming problems:

For each function definition you must provide contracts, a body,
check= tests *and* test? forms (property-based testing).  For each
data definition you must provide check= tests *and* test?
forms (property-based testing).  This is in addition to the tests
sometimes provided. Make sure you produce sufficiently many new test
cases and at least two intersting test? forms.  

For function definitions, make sure to provide as many tests as the
data definitions dictate. For example, a function taking two lists
should have at least 4 tests: all combinations of each list being
empty and non-empty.  Beyond that, the number of tests should reflect
the difficulty of the function. For very simple ones, the above
coverage of the data definition cases may be sufficient. For complex
functions with numerical output, you want to test whether it produces
the correct output on a reasonable number of inputs.

Use good judgment. For unreasonably few test cases and properties we
will deduct points.

You can use any types, functions and macros listed on the ACL2s
Language Reference (from class Webpage, click on "Lectures and Notes"
and then on "ACL2s Language Reference").

|#

#|

 Instead of requiring ACL2s to prove termination and contracts, we
 allow ACL2s to proceed even if a proof fails.  However, if a
 counterexample is found, ACL2s will report it.  See the lecture notes
 for more information.  This is achieved using the following
 directives (do not remove them):

|#

(set-defunc-termination-strictp nil)
(set-defunc-function-contract-strictp nil)
(set-defunc-body-contracts-strictp nil)

; This directive forces ACL2s to generate contract theorems that
; correspond to what we describe in the lecture notes.
(set-defunc-generalize-contract-thm nil)

#|
 We will continue with the last lab, where we used ACL2s to define the
 syntax and semantics of SAEL (Simple Arithmetic Expression Language). 

 In this homework, we will use ACL2s to define the syntax and
 semantics of two AEL (Arithmetic Expression Language), so make sure
 you have done the lab already.

 An arithmetic expression, aexpr, extends saexpr with variables. It is
 one of the following:

- a rational number (we use the builtin type rational)

- a variable (we use the builtin type var)

- a list of the form 
    (- <aexpr>)
  where <aexpr> is an arithmetic expression

- a list of the form
    (<aexpr> <boper> <aexpr>)
  where <boper> is one of +, -, or * (the same as SAEL)
  and both <aexpr>'s are arithmetic expressions.

|#

; Vars are just a restricted set of the symbols. 
; The specifics of which symbols are vars is not all that important
; for our purposes. All we need to know is that vars are symbols and
; they do not include any of the AEL operators. Examples of vars include
; symbols such as x, y, z, etc.

(check= (varp '-) nil)
(check= (varp '+) nil)
(check= (varp '*) nil)
(check= (varp '/) nil)
(check= (varp 'x) t)
(check= (varp 'x1) t)
(check= (varp 'y) t)

; The defdata-subtype-strict form, below, is used to check that one
; type is a subtype of another type. This is a proof of the claim that
; var is a subtype of symbol.

(defdata-subtype-strict var symbol)

; To see that symbol is not a subtype of var, we can use test? to
; obtain a counterexample to the claim. The must-fail form succeeds
; iff the test? form fails, i.e., it finds a counterexample.

(must-fail (test? (implies (symbolp x)
                           (varp x))))

;;; Use defdata to define boper the binary operators (same as lab):

(defdata boper (enum '(+ - *)))

(check= (boperp '*) t)
(check= (boperp '^) nil)
(check= (boperp '/) nil)
(check= (boperp '+) t)
(check= (boperp '%) nil)
(check= (boperp '+) t)
(check= (boperp '-) t)

;;; Use defdata to define aexpr with an inductive data definition:

(defdata aexpr
  (oneof rational
         var
         (list '- aexpr)
         (list aexpr boper aexpr)))

(check= (aexprp '45/3) t)
(check= (aexprp '((x + y) - (- z))) t)
(check= (aexprp '(x + y + z)) nil)
(check= (aexprp '()) nil)
(check= (aexprp 3) t)
(check= (aexprp '(- 10)) t)

;; What should the following check= forms evaluate to? Make sure you
;; understand each argument that aexprp gets for input.

(check= (aexprp  12) t)
(check= (aexprp '12) t)
(check= (aexprp ''12) nil)

(check= (aexprp  (- 45)) t)
(check= (aexprp '(- 45)) t)
(check= (aexprp ''(- 45)) nil)

(check= (aexprp  (+ 1/2 45)) t)
(check= (aexprp '(+ 1/2 45)) nil)
(check= (aexprp ''(+ 1/2 45)) nil)

(check= (aexprp  (expt 2 3)) t)
(check= (aexprp '(expt 2 3)) nil)
(check= (aexprp ''(expt 2 3)) nil)

(check= (aexprp (car (cons 1 "hi there"))) t)
(check= (aexprp (+ (car (cons 1 "hi there")) 12)) t)
(check= (aexprp '(+ (car (cons 1 "hi there")) 12)) nil)
(check= (aexprp '((car (cons 1 "hi there")) + 12)) nil)
(check= (aexprp `(,(car (cons 1 "hi there")) + 12)) t)

#|

 We have now defined AEL expressions in ACL2s. In fact, the use of
 defdata made this pretty easy and gave us a recognizer, aexprp, for
 AEL expressions.

 Notice that AEL expressions are not a subset of ACL2s expressions.
 - Provide an example of an AEL expression that is not 
   a legal ACL2s expression.
 - Provide an example of an ACL2s expression that is not 
   a legal AEL expression.
 
 - '(10 + (- 10)) is a AEL expression that is not a legal ACL2s expression
 - '(/ 10 2) is an example of an ACL2s expression that is not an legal AEL expression

|#

; Next, we will define the semantics of arithmetic expressions.
; The main issue in extending the lab to deal with aexpr's is to deal
; with vars. The idea is that to evaluate a var, we have to know what
; value it has. We will use assignments to do that.

;; An assignment is an alist from vars to rationals.  An alist is
;; just a list of conses; each cons pairs together a variable and its
;; associated value. When looking up a variable in an alist, we take
;; the first binding we find, as we scan the list from left to right.

(defdata assignment (alistof var rational))

(check= (assignmentp '((x . 1) (y . 1/2))) t)
(check= (assignmentp '((z . 5) (p . 5/10))) t)
(check= (assignmentp '((x 3) (c 0))) nil)

;; This is nil because (1) and (1/2) are lists, not rationals.
(check= (assignmentp '((x 1) (y 1/2))) nil)

;; Define aeval, a function that given an aexpr and an assignment
;; evaluates the expression, using the assignment to determine the
;; values of vars appearing in the expression.

;; If a var appears in the aexpr but not in the assignment, then the
;; value of the var should be 1.

;; Remember to use the "template" that defdatas give rise to as per 
;; Section 2.13 of the lecture notes.  You will need the following helper
;; function to lookup the value of v in a (remember to return 1 if v
;; isn't in a).

(definec lookup (v :var a :assignment) :rational
  (cond ((endp a) 1)
        (t (if (equal (car (car a)) v)
             (cdr (car a)) (lookup v (cdr a))))))

(check= (lookup 'x '((x . 2))) 2)
(check= (lookup 'y '((x . 2) (y . 3))) 3)
(check= (lookup 'z '((x . 2) (y . 3))) 1)

(definec aeval (e :aexpr a :assignment) :rational
  (cond ((rationalp e) e)
        ((varp e) (lookup e a))
        ((equal (car e) '-) (- (aeval (cadr e) a)))
        (t (cond ((equal (cadr e) '+) (+ (aeval (car e) a) (aeval (caddr e) a)))
                 ((equal (cadr e) '-) (- (aeval (car e) a) (aeval (caddr e) a)))
                 ((equal (cadr e) '*) (* (aeval (car e) a) (aeval (caddr e) a)))))))

(check= (aeval '((x + y) - (- z))
               '((y . 3/2) (z . 1/2)))
        3)
(check= (aeval '(5 * 10) nil) 50)
(check= (aeval '((x + y) - (- z)) nil) 3)

#|

 Congratulations! You have formally defined the syntax and semantics
 of AEL. The data definition for aexpr defines the syntax: it tells
 us what objects in the ACL2s universe are legal aexps.
 
 Let us unpack the above check= form.

 The first argument to aeval is

 A: '((x + y) - (- z)), which is an ACL2s expression that evaluates to:

 B: ((x + y) - (- z)), which is not an ACL2s expression, but is an AEL
                       expression; this is what aeval gets as input

 The meaning of this expression is given by aeval and depends on the
 meaning of x, y and z, which are provided by the assignment and are:
 1, 3/2 and 1/2, respectively.
 
|#


;; Specify the following properties using aeval.

;; 1. -A = (- (- (- A))), in AEL, for any rational A.

(test? (implies (and (aexprp (- a))
                     (rationalp a))
                (aeval '(- '(- '(- a))) '())))

;; 3. (A - B) = (A + (- B)), in AEL, for any rationals A and B.

(test? (implies (and (rationalp a)
                     (rationalp b)
                     (aexprp '(a - b)))
                (aeval '(a + '(- b)) '())))

;; 4. (A * (B + C)) = ((A * B) + (A * C)), in AEL, for any rationals A, B & C.

(test? (implies (and (rationalp a)
                     (rationalp b)
                     (rationalp c)
                     (aexprp '(a * '(b + c))))
                (aeval '('(a * b) + '(a * c)) '())))

;; 5. (E1 - E2) = (E1 + (- E2)), in AEL, for any aexprs E1 and E2.

(test? (implies (and (aexprp e1)
                     (aexprp e2)
                     (aexprp '(e1 - e2)))
                (aeval '(e1 + '(- e2)) '())))

;; 6. (E1 * (E2 + E3)) = ((E1 * E2) + (E1 * E3)), in AEL,
;;    for any aexpr's E1, E2, E3.

(test? (implies (and (aexprp e1)
                     (aexprp e2)
                     (aexprp e3)
                     (aexprp '(e1 * '(e2 + e3))))
                (aeval '('(e1 * e2) + '(e1 * e3)) '())))


;;; AEL2 language with division
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

Let's extend our language to include division. We can call the
extended language AEL2 for "AEL revision 2." First, we have to extend
the syntax of expressions by including / in the set of possible
operators.

|#

(defdata boper2 (enum '(+ / * -)))

(check= (boper2p '*) t)
(check= (boper2p '^) nil)
(check= (boper2p '/) t)
(check= (boper2p '>) nil)

;;; Use defdata to define aexpr2 with an inductive data definition:

(defdata aexpr2
  (oneof rational
         var
         (list '- aexpr2)
         (list aexpr2 boper2 aexpr2)))

(check= (aexpr2p '45/3) t)
(check= (aexpr2p '((x + y) - (- z))) t)
(check= (aexpr2p '(x + y + z)) nil)
(check= (aexpr2p '(5 / 3)) t)
(check= (aexpr2p (/ 10 2)) t)
(check= (aexpr2p '(/ 10 2)) nil)

#| 
A new issue has arisen! Addition, subtraction, negation and multiplication
are well defined for all rationals... but division is not. This is a
legal AEL2 computation

    (3 / (5 - 2))

but this is not

    (3 / (5 - (2 + 3)))

because we cannot divide by zero.

We'll handle this by introducing a special error value.
|#

(defdata er 'error)
(defdata rat-or-err (oneof rational er))

(check= (rat-or-errp 5)      t)
(check= (rat-or-errp 'error) t)
(check= (rat-or-errp "five") nil)

(check= (rat-or-errp  (+ 2 3))   t)
(check= (rat-or-errp '(+ 2 3)) nil)
(check= (rat-or-errp '(2 + 3)) nil)

#| We'll now say that an AEL2 expression can evaluate to a rational
   (if everything goes well), or to the error value (if an error
   occurs anywhere in the evaluation of the expression).

   See the check='s to see examples the idea; add a few of your own.

   Note that you can reuse the lookup function from your evaluator
   aeval in your definition of the extended aeval2 for AEL2 expressions.
|#

(definec aeval2 (e :aexpr2 a :assignment) :rat-or-err
  (cond ((rationalp e) e)
        ((varp e) (lookup e a))
        ((equal (cadr e) '/) (if (or (erp (aeval2 (car e) a)) 
                                     (erp (aeval2 (caddr e) a))) 'error
                               (if (equal (aeval2 (caddr e) a) 0) 'error
                                 (/ (aeval2 (car e) a) (aeval2 (caddr e) a)))))
        ((equal (car e) '-) (if (erp (aeval2 (cadr e) a)) 'error
                              (- (aeval2 (cadr e) a))))
        (t (if (or (erp (aeval2 (car e) a)) (erp (aeval2 (caddr e) a))) 'error
             (cond ((equal (cadr e) '+) (+ (aeval2 (car e) a) (aeval2 (caddr e) a)))
                   ((equal (cadr e) '-) (- (aeval2 (car e) a) (aeval2 (caddr e) a)))
                   ((equal (cadr e) '*) (* (aeval2 (car e) a) (aeval2 (caddr e) a))))))))


(check= (aeval2 '((x + y) - (- z))
                '((y . 3/2) (z . 1/2)))
        3)
(check= (aeval2 '(3 / (5 - (2 + 3))) '()) 'error)
(check= (aeval2 '(3 / (5 - 2)) '()) 1)
(check= (aeval2 '(10 / (4 / 2)) '()) 5)
(check= (aeval2 '(0 / 3) '()) 0)
(check= (aeval2 '(X / Y) '((x . 3) (y . 0))) 'error)
(check= (aeval '(b * (y + z)) '((b . 2) (y . 4) (z . 5))) 18)
#|
Now provide test? forms to check these two facts... if they are true.
If either of these "facts" is, in fact, just sort-of a fact, which is
to say, not actually a fact at all, repair the claim so that it is an
*actual* fact.

By "repair the claim," we mean that you need to come up with a way to
alter the claim so that it correctly captures the general idea of the
original, buggy claim.

- ((E1 + E2) / E3) = ((E1 / E3) + (E2 / E3)), 
  for any expressions E1, E2 & E3.

- (1 / (E1 / E2)) = (E2 / E1), 
  for any expression E1 and E2.
|#

(test? (implies (and (not (zp (aeval2 e3 '())))
                     (aexpr2p e1)
                     (aexpr2p e2)
                     (aexpr2p e3)
                     (aexpr2p '('(e1 + e2) / e3)))
                (aeval2 '('(e1 / e3) + '(e3 / e2)) '())))

(test? (implies (and (aexpr2p e1)
                     (aexpr2p e2)
                     (not (zp (aeval2 e1 '())))
                     (not (zp (aeval2 e2 '())))
                     (aexpr2p '(1 / '(e1 / e2))))
                (aeval2 '(e2 / e1) '())))#|ACL2s-ToDo-Line|#


