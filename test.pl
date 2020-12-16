baum(blatt(X)) :- atom(X).
baum(knoten(A,B,C)) :- atom(B), baum(A), baum(C).


baumToString(baum(blatt(X)), [X]).
baumToString(baum(knoten(A,B,C)), S) :- baumToString(baum(A), LINKS), baumToString(baum(C), RECHTS), append(LINKS,[B|RECHTS],S).