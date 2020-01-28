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

CS 2800 Homework 1 - Spring 2020

This homework is done in groups. 

 * Groups should consist of 2-3 people.

 * All students should register for the class in the handin server at
     http://handins.ccs.neu.edu/courses

 * If you have never used the handin server, you can read about it here:
     http://www.ccs.neu.edu/home/blerner/handin-server/handin-server-guide.html

 * Students should set up their team with the handin server.

 * Submit the homework file (this file) on the homework sever.

 * You must list the names of ALL group members below, using the given
   format. This way we can confirm team membership with the handin
   server teams. If you fail to follow these instructions, it costs us
   time and it will cost you points, so please read carefully.

The format should be: FirstName1 LastName1, FirstName2 LastName2, ...
For example:
Names of ALL group members: Frank Sinatra, Billy Holiday

There will be a 10 pt penalty if your names do not follow this format.

Replace "..." below with the names as explained above.

Names of ALL group members: Saul Reyna, Ngoc Khanh Vy Le, Wing Tung Lam

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 For this homework you will need to use ACL2s.

 Technical instructions:

 - Open this file in ACL2s as hwk01.lisp

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

 - When done, save your file and submit it as hwk01.lisp

 - Do not submit the session file (which shows your interaction with the theorem
   prover). This is not part of your solution. Only submit the lisp file.

 Instructions for programming problems:

 For each function definition, you must provide both contracts and a body.

 You must also ALWAYS supply your own tests. This is in addition to the
 tests sometimes provided. Make sure you produce sufficiently many new test
 cases. This means: cover at least the possible scenarios according to the
 data definitions of the involved types. For example, a function taking two
 lists should have at least 4 tests: all combinations of each list being
 empty and non-empty.

 Beyond that, the number of tests should reflect the difficulty of the
 function. For very simple ones, the above coverage of the data definition
 cases may be sufficient. For complex functions with numerical output, you
 want to test whether it produces the correct output on a reasonable
 number of inputs.

 Use good judgment. For unreasonably few test cases we will deduct points.

 We will use ACL2s' check= function for tests. This is a two-argument
 function that rejects two inputs that do not evaluate equal. You can think
 of check= roughly as defined like this:

 (definec check= (x :all y :all) :bool
   :input-contract (equal x y)
   :output-contract (== (check= x y) t)
   t)

 That is, check= only accepts two inputs with equal value. For such inputs, t
 (or "pass") is returned. For other inputs, you get an error. If any
 check= test in your file does not pass, your file will be rejected.

 You can use any types, functions and macros listed on the ACL2s
 Language Reference (from class Webpage, click on "Lectures and Notes"
 and then on "ACL2s Language Reference").

 Since this is our first programming exercise, we will simplify the
 interaction with ACL2s somewhat. Instead of requiring ACL2s to prove
 termination and contracts, we allow ACL2s to proceed even if a proof
 fails.  However, if a counterexample is found, ACL2s will report it.
 See the lecture notes for more information.  This is achieved using
 the following directives (do not remove them):

|#

(set-defunc-termination-strictp nil)
(set-defunc-function-contract-strictp nil)
(set-defunc-body-contracts-strictp nil)

#| 

 Part I:
 Function definitions.

 In this part, you will be given a set of programming exercises. Since you
 already took a fantastic course on programming (CS2500), the problems are not
 entirely trivial. Make sure you give yourselves enough time to develop
 solutions and feel free to define helper functions as needed.

|# 


#|
r-last: TL -> TL

(r-last l) removes the last element of the given list
|#
(definec r-last (l :tl) :tl
  (cond ((endp l) nil)
        ((endp (cdr l)) nil)
        (t (cons (car l) (r-last (cdr l))))))

(check= (r-last '(1 2 3)) '(1 2))
(check= (r-last '(1)) '())
(check= (r-last '()) '())

#|
Define the function rr.
rr: Nat x TL -> TL

(rr n l) rotates the true list l to the right n times.
|#

(definec rr (n :nat l :tl) :tl
  (cond ((zp n) l)
        ((lendp l) l)
        (t (rr (- n 1)
               (app (list (nth (- (len l) 1) l))
                    (r-last l))))))

(check= (rr 1 '(1 2 3)) '(3 1 2))
(check= (rr 2 '(1 2 3)) '(2 3 1))
(check= (rr 3 '(1 2 3)) '(1 2 3))
(check= (rr 4 '(1 2 3)) '(3 1 2))
(check= (rr 0 '(1 2 3)) '(1 2 3))
(check= (rr 1 '()) '())

#|
Define the function err, an efficient version of rr.
err: Nat x TL -> TL

(err n l) returns the list obtained by rotating l to the right n times
but it does this efficiently because it actually never rotates more than
(len l) times.

|#

(definec err (n :nat l :tl) :tl
  (if (endp l)
    l
    (rr (mod n (len l)) l)))
   
(check= (err 1 '(1 2 3)) '(3 1 2))
(check= (err 2 '(1 2 3)) '(2 3 1))
(check= (err 3 '(1 2 3)) '(1 2 3))
(check= (err 4 '(1 2 3)) '(3 1 2))
(check= (err 0 '(1 2 3)) '(1 2 3))
(check= (err 1 '()) '())

#|
Make sure that err is efficient by timing it with a large n
and comparing the time with rr.

Replace the ...'s in the string below with the times you 
observed.
|#

(time$ (rr  10000000 '(a b c d e f g)))
(time$ (err 10000000 '(a b c d e f g)))

"rr took 1.7 seconds but err took 0.0 seconds"             

;; Here is a data definition for a bitvector.

(defdata bit (oneof 0 1))
(defdata bitvector (listof bit))

;; For example

(check= (bitvectorp '(0 1 0 0 1 0 0)) t)
(check= (bitvectorp '(1 a 1 0)) nil)

#|
We can use bitvectors to represent natural numbers as follows.
The list

(0 0 1)

corresponds to the number 4 because the first 0 is the "low-order" bit
of the number which means it corresponds to 2^0=1 if the bit is 1 and
0 otherwise. The next Boolean corresponds to 2^1=2 if 1 and 0
otherwise and so on. So the above number is:

0 + 0 + 2^2 = 4.

As another example, 31 is

(1 1 1 1 1)

or

(1 1 1 1 1 0 0)

or ...

Define the function n-to-b that given a natural number, returns a
bitvector list of minimal length, corresponding to that number.
|#

(definec n-to-b (n :nat) :bitvector
  (cond ((zp n) '())
        ((= (mod n 2) 1)
         (cons 1 (n-to-b (floor n 2))))
        ((= (mod n 2) 0)
         (cons 0 (n-to-b (floor n 2))))))


(check= (n-to-b 0)  '())
(check= (n-to-b 7)  '(1 1 1)) 
(check= (n-to-b 10) '(0 1 0 1)) 
(check= (n-to-b 2) '(0 1))
(check= (n-to-b 1495) '(1 1 1 0 1 0 1 1 1 0 1))

#|
Define the function b-to-n that given a bitvector, returns
the  corresponding natural number.
|#

#|
b-to-n : BOOLVECTOR -> NAT

(b-to-n boolvector) returns the corresponding natural number
to the given bitvector
|#
(definec b-to-n (l :bitvector) :nat
  (cond ((endp l) 0)
        (t (+ 
            (* (car (rr 1 l)) 
               (expt 2 (- (len l) 1)))
            (b-to-n (cdr (rr 1 l)))))))

(check= (b-to-n '(0 1 0 1)) 10)  
(check= (b-to-n '(1 1 1)) 7) 
(check= (b-to-n '(0 0 1)) 4) 
(check= (b-to-n '(1 1 1 1 1)) 31) 
(check= (b-to-n ()) 0)
(check= (b-to-n '(1 1 1 0 1 0 1 1 1 0 1)) 1495)

#|

The permutations of a (true) list are all the lists you can obtain by
swapping any two of its elements (repeatedly). For example, starting
with the list

(1 2 3)

I can obtain

(3 2 1)

by swapping 1 and 3.

So the permutations of (1 2 3) are

(1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1)

Notice that if the list is of length n and all of its elements are distinct, it
has n! (n factorial) permutations.

Given a list, say (a b c d e), we can define any of its permutations using a
list of *distinct* natural numbers from 0 to the length of the list - 1, which
tell us how to reorder the elements of the list.  Let us call this list of
distinct natural numbers an arrangement.  For example applying the
arrangement (4 0 2 1 3) to the list (a b c d e) yields (e a c b d).

Define the function find-arrangement that given two lists, either returns nil if
they are not permutations of one another or returns an arrangement such that
applying the arrangement to the first list yields the second list. Note that if
the lists have repeated elements, then more than one arrangement will work. In
such cases, it does not matter which of these arrangements you return.

|#

#|
equal-elemnts: TL x TL -> Bool

(equal-elemnts tl tl) checks if all the elemnts in the first 
list are present in the second one
|#

(definec equal-elemnts (list1 :tl list2 :tl) :boolean
  (cond ((and (endp list1) (consp list2)) t)
        ((endp list1) t)
        (t (and (if (in (car list1) list2) t nil)
                (equal-elemnts (cdr list1) list2)))))

(check= (equal-elemnts '(a b c) '(a b b)) nil)
(check= (equal-elemnts '(a a) '(a a)) t)
(check= (equal-elemnts '(a b c) '(a c b)) t)
(check= (equal-elemnts '() '()) t)
(check= (equal-elemnts '() '(a b c)) t)
(check= (equal-elemnts '(a b c) '()) nil)

#|
convert-nat-arr: Nat x TL -> TL

(convert-nat-arr nat tl) converts the given list of whatever
elemnts and assigns a number for every elemtent in the list.
The natural number has to be the length of the list
|#

(definec convert-nat-arr (n :nat l :tl) :tl
  (cond ((endp l) nil)
        (t (cons (- n (len l)) (convert-nat-arr n (cdr l))))))

(check= (convert-nat-arr (len '(a b c)) '(a b c)) '(0 1 2))
(check= (convert-nat-arr (len '(a a)) '(a a)) '(0 1))
(check= (convert-nat-arr (len '()) '()) '())
(check= (convert-nat-arr (len '(a)) '(a)) '(0))

#|
nat-permutation : TL x TL x TL -> TL

(nat-permutation tl tl tl) returns the number combination of the 
second list, using the first list and its numeric representation 
as reference
|#

(definec nat-permutation (l1 :tl l2 :tl conv :tl) :tl
  (cond ((endp l1) nil)
        ((endp l2) nil)
        (t (if (equal (car l1) (car l2))
             (cons (car conv) (nat-permutation (cdr l1) (cdr l2) (cdr conv)))
             (nat-permutation (rr 1 l1) l2 (rr 1 conv))))))

(check= (nat-permutation '(a b c) '(a c b) '(0 1 2)) '(0 2 1))
(check= (nat-permutation '(a a) '(a a) '(0 1)) '(0 1))
(check= (nat-permutation '(a b c d) '(b d c a) '(0 1 2 3)) '(1 3 2 0))

#|
find-arrangement: TL x TL -> TL

(find-arrangement tl tl) returns the combination of numbers that represents
the given permutation of the original list
|#

(definec find-arrangement (l1 :tl l2 :tl) :tl
  (if (and (equal-elemnts l1 l2)
           (equal-elemnts l2 l1))
    (nat-permutation l1 l2 (convert-nat-arr (len l1) l1)) nil))

(check= (find-arrangement '(a b c) '(a b b)) nil)
(check= (find-arrangement '(a b c) '(a c b)) '(0 2 1))
(check= (find-arrangement '(a a) '(a a)) '(0 1))
(check= (find-arrangement '(a b c d) '(b d c a)) '(1 3 2 0))
(check= (find-arrangement '() '(a b c)) nil)
(check= (find-arrangement '(a b c) '()) nil)#|ACL2s-ToDo-Line|#
#|xeuibz3zzzzzz3z3|#
;; in the above check= you can use '(1 0) instead of '(0 1) if you wish
;; since both arrangements work


#|

Recall the following definitions from the lecture notes.

(definec listp (l :all) :bool 
  (or (consp l)
      (equal l () )))

(definec endp (l :list) :bool
  (atom l))

(definec true-listp (l :all) :bool
  (if (consp l)
      (true-listp (cdr l))
    (equal l ())))

(definec binary-append (x :tl y :all) :all
  (if (endp x)
      y
    (cons (first x) (binary-append (rest x) y))))

This exercise will require you to use what you learned solving
recurrence relations from discrete.

We will explore the difference between static and dynamic
type checking. 

A. What is the computational complexity of listp?

B. What is the computational complexity of endp?

C. What is the computational complexity of true-listp?

D. What is the computational complexity of binary-append?

To answer the above questions, we will assume (just for this exercise)
that the following operations have a cost of 1:

 cons, first, rest, consp, atom, or, equal, not, if

We will also assume for this first set of questions that static
contract checking is used.  With static contract checking, ACL2s
checks that the arguments to the function satisfy their contract only
once, for the top-level call. For example, if you type:

(binary-append '(1 2 3 4) '(5 6))

ACL2s checks that '(1 2 3 4) is a true-list and no other contracts.

Remember also that we want the worst-case complexity.  So if the
function has an if-then-else, you must compute separately the
complexity of the then branch, the else branch, and then take the
worst case (i.e., the maximum), plus the complexity of the if
condition itself.

To get you going, we will give the complexity of listp as an example.
Checking the contract statically takes no time, since the type of

x is :all. 

Independently of the size of x, there are 3 operations: (consp x),
(equal x nil), and the or. So the complexity is O(3)=O(1), that is,
constant time. 

Notice that we want the complexity of the functions assuming that the
top-level checking has been already been done.

ANSWER B: The time complexity is O(2)=O(1), since the the function
checks the contract, making sure the input is a list, resulting in a
runtime of 1. Afterwards, the inputted list is checked with atom, 
resulting in another runtime of 1.

ANSWER C: The time complexity is O(3n+3)=O(n). When the input is an
empty list, the run time would be 3: the if, consp, and the equal. For
every other element that is not NIL, the if, consp and cdr of the inputted
list will give a runtime of 3, which will be run for every other element of
the list, resulting in a runtime of 3n.

ANSWER D: The time complexity is O(8n+5)=O(n). Since one of the contracts
checks that the first list is a true list, we can use the time complexity
from before to know that the run time is O(3n+3). Then, when the first list
is empty, the runtime would be 2 (if, endp). For every other element in the 
list, the runtime would be 5n (if, endp, cons, first, rest), resulting in
(5n+2) + (3n+3) = (8n+5).

One way of implementing dynamic checking is to have every function
dynamically check its input contracts. Think about how you might do
that before reading further. So, the above definitions get transformed
into the following. In essence, we are forcing contract checking to
happen dynamically, during runtime.

(definec listp (x :all) :bool
  (or (consp x)
      (equal x nil)))

(definec endp (x :all) :bool
  (if (listp x)
      (atom x)
    (error)))

(definec true-listp (x :all) :bool
  (if (consp x)
      (true-listp (rest x))
    (equal x nil)))

(definec binary-append (x :tl y :all) :all
  (if (true-listp x)
      (if (endp x)
          y
        (cons (first x) (binary-append (rest x) y)))
    (error)))


What is the computational complexity of the above modified functions?
You can assume that error has cost 1.

ANSWER A: The time complexity is O(3) = O(1) [constant time]. Since the contracts 
of the operations used in listp are (:all) or (:all X :all), they take no runtime.
However, the function itself uses or, consp, equal), resulting in a 
runtime of 3. 

ANSWER B: The time complexity is O(6)=O(1). Since the contracts for all the 
operations used in endp are (:all) or (:all X :all), the runtime is zero. For
any input, the runtime would 6 (if, listp [has a runtime of 3], atom, error).

ANSWER C: The time complexity is O(4n+3)=O(n). The contracts on every operation
other than rest, which is :list,  are (:all) or (:all X :all), resulting in a 
runtime of 1. When the input is not a list, the runtime would be 3 (if, consp, equal). 
For the worst case, the runtime would be 4n, since every element would go through 
if, consp, rest, and the contract for rest. 

ANSWER D: The time complexity is O(8n^2+35n+22)=O(n^2). 
- When the input is not a true list, the runtime would be 8n+8, since 
the contract for the first list checks if its a true list, which is (4n+3). Then,
the runtime is 4n+5 (if, true-listp [has a runtime of 4n+3], error)
-The second best case is when the input is a true list and is NIL, where the runtime is 
O(8n+14). The contract-checking takes a runtime of 4n+3, plus the runtime of the operations
on the input, which is 4n+11 (if, true-listp [has a runtime of 4n+3], if, endp [has a runtime of 6]
-The worst case is when the functions runs through every element in the list. The runtime for a single 
element would be (4n+3)[contract checking for binary-append] + the runtime on the operations on
the element (if, true-listp [runtime of 4n+3], if, endp [runtime of 6], cons , first [runtime of 2], rest[runtime of 2]),
which totals to (4n+3) + (4n+16).
This runtime will run for n elements in the list, resulting in n(8n+19) = O(8n^2+19n)
Adding all the runtimes results in (8n^2+19n)+(8n+8)+(8n+14)=(8n^2+35n+22)


|#
