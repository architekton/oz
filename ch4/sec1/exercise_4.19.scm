; a)
; Ben or alyssa, Ben's is more of an imperative style, which we are more
; used to in other programming languages. Alyssa's throws an error, which is
; also acceptable.

; b)
; Produce the topological ordering of the definitions dependancies by
; scanning every definition into a directed acyclic graph. If there is a cycle
; we cannot evaluate two definitions depending on eachother anyway, therefore
; it must be acyclic. The topological ordering will produce the definitions
; which we can evaluate first, and we can proceed to evaluate the definitions
; in the valid ordering.
