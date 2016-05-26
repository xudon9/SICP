(load "arithmetic.scm")

(install-rectangular-package)
(install-polar-package)
(install-complex-package)

(define z (make-complex-from-real-imag 3 4))
(magnitude z)
