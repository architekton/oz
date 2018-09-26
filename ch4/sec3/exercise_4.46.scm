;  (define (maybe-extend verb-phrase)
;    (amb verb-phrase
;         (maybe-extend (list 'verb-phrase
;                             verb-phrase
;                             (parse-prepositional-phrase)))))

; this would suffer from infinite recursion



