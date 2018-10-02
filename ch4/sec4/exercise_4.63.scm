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

              (rule (grandson ?s ?g)
                    (and (son ?s ?f)
                         (son ?f ?g)))

              (rule (son ?m ?s)
                    (and (wife ?w ?m)
                         (son ?s ?w)))

  ))

(initialize-data-base rel)
(query-driver-loop)

(grandson Cain ?g)
(grandson ?g Methushael)

(son ?m Lamech)

