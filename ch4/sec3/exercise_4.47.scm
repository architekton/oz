(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 'verb-phrase
             (parse-verb-phrase)
             (parse-prepositional-phrase))))

; If the order of amb expressions remains as is, it works until there are no
; solutions remaining. If we switch the order we immediately get an infinite
; loop. However both result in an infinite loop, they do not work correctly.
