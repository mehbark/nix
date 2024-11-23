#lang pie

(claim Either.mapRight
       (Pi ([L U] [OldRightT U] [NewRightT U] )
           (-> (-> OldRightT NewRightT) (Either L OldRightT)
               (Either L NewRightT))))
(define Either.mapRight (lambda (L _b OldRightT) (lambda (f either)
                                     (ind-Either
                                      either
                                      (lambda (oldEither) (Either L NewRightT))
                                      (lambda (l) (left l))
                                      (lambda (r) (right (f r)))))))
