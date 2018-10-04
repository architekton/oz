(load "../query.scm")

(define rel '((son Adam Cain)
              (son Cain Enoch)
              (son Enoch Irad)
              (son Irad Mehujael)
              (son Mehujael Methushael)
              (son Methushael Lamech)
              (wife Lamech Ada)
              (son Ada Jabal)
              (son Ada Jubal)
              ((great grandson) Adam Irad)

              (rule (grandson ?s ?g)
                    (and (son ?s ?f)
                         (son ?f ?g)))

              (rule (son ?m ?s)
                    (and (wife ?w ?m)
                         (son ?s ?w)))

              (rule (ends-in-grandson) (grandson))

              (rule (ends-in-grandson (?great . ?rel))
                    (ends-in-grandson ?rel))

              (rule ((great . ?rel) ?x ?y)
                    (and (ends-in-grandson ?rel)
                         (son ?x ?z)
                         (?rel ?z ?y)))

              ))

(initialize-data-base rel)
(query-driver-loop)

((great grandson) ?g ?ggs)

(?relationship Adam Irad)
; infinite loop here use 4.67
