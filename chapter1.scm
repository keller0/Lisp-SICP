;;;; 第一章代码 

;;;  SECTION使用;;;
;;;  书中的例子使用;:
;;;  注意:代码不保证能在不同环境下都可运行

;;;SECTION 1.1.1

;; interpreter examples

;: 486

;: (+ 137 349)
;: (- 1000 334)
;: (* 5 99)
;: (/ 10 5)
;: (+ 2.7 10)

;: (+ 21 35 12 7)
;: (* 25 4 12)

;: (+ (* 3 5) (- 10 6))

;: (+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))

;: (+ (* 3
;:       (+ (* 2 4)
;:          (+ 3 5)))
;:    (+ (- 10 7)
;:       6))

;;;SECTION 1.1.2

;: (define size 2)
;: size
;: (* 5 size)

;: (define pi 3.14159)
;: (define radius 10)
;: (* pi (* radius radius))
;: (define circumference (* 2 pi radius))
;: circumference


;;;SECTION 1.1.3

;: (* (+ 2 (* 4 6))
;:    (+ 3 5 7))


;;;SECTION 1.1.4

(define (square x) (* x x))

;: (square 21)
;: (square (+ 2 5))
;: (square (square 3))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

;: (sum-of-squares 3 4)

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

;: (f 5)


;;;SECTION 1.1.5

;: (f 5)
;: (sum-of-squares (+ 5 1) (* 5 2))
;: (+ (square 6) (square 10))
;: (+ (* 6 6) (* 10 10))
;: (+ 36 100)

;: (f 5)
;: (sum-of-squares (+ 5 1) (* 5 2))
;: (+    (square (+ 5 1))      (square (* 5 2))  )
;: (+    (* (+ 5 1) (+ 5 1))   (* (* 5 2) (* 5 2)))
;: (+         (* 6 6)             (* 10 10))
;: (+           36                   100)
;:                     136


;;;SECTION 1.1.6

(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))

(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))

(define (abs x)
  (if (< x 0)
      (- x)
      x))

;: (and (> x 5) (< x 10))

(define (>= x y)
  (or (> x y) (= x y)))

(define (>= x y)
  (not (< x y)))


;;EXERCISE 1.1
;: 10

;: (+ 5 3 4)

;: (- 9 1)

;: (/ 6 2)

;: (+ (* 2 4) (- 4 6))

;: (define a 3)

;: (define b (+ a 1))

;: (+ a b (* a b))

;: (= a b)

;: (if (and (> b a) (< b (* a b)))
;:     b
;:     a)

;: (cond ((= a 4) 6)
;:       ((= b 4) (+ 6 7 a))
;:       (else 25))

;: (+ 2 (if (> b a) b a))

;: (* (cond ((> a b) a)
;: 	 ((< a b) b)
;: 	 (else -1))
;:    (+ a 1))

;;EXERCISE 1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;;EXERCISE 1.5
(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

;: (test 0 (p))

;;;SECTION 1.1.7

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))


;: (sqrt 9)
;: (sqrt (+ 100 37))
;: (sqrt (+ (sqrt 2) (sqrt 3)))
;: (square (sqrt 1000))


;;EXERCISE 1.6
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;: (new-if (= 2 3) 0 5)

;: (new-if (= 1 1) 0 5)

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))


;;;SECTION 1.1.8

(define (square x) (* x x))

(define (square x) 
  (exp (double (log x))))

(define (double x) (+ x x))


;; As in 1.1.7
(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))


;; Block-structured
(define (sqrt x)
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1.0 x))

;; Taking advantage of lexical scoping
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))