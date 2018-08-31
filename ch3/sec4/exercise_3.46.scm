; Suppose this process gets called by 2 threads at the same time.
; They might both check the condition which will be false.
; Then they will both proceed to set the mutex as acquired.
