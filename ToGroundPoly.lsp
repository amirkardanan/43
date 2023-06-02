(princ "\n[Info] Type TGP to run. [Info]")
(defun c:tgp ()
	(setq ocecho (getvar "cmdecho"))
	(setvar "cmdecho" 0)
	(setq ce_c (getvar "cecolor"))
	(setq ce_lt (getvar "celtype"))
	(setq ce_lw (getvar "celweight"))
	(setq ce_lt_g (getvar "PLINEGEN"))
	(setq d (ssget '((0 . "*POLYLINE,LINE"))))
	(setq t (sslength d))
	(setq i 0)
	(setq om (getvar "osmode"))
	(setq 3dom (getvar "3dosmode"))
	(setvar "osmode" 0)
	(setvar "3dosmode" 0)
	(setvar "cecolor" "bylayer")
	(setvar "celtype" "bylayer")
	(setvar "celweight" -1)
	(while (< i t)
	(setq len '())
	(setq vl_name (vlax-ename->vla-object (ssname d i)))
	
	
	(if (/= (cdr (assoc 0 (entget (ssname d i)))) "LINE")
	(progn
	(if (and 
	(/= "AcDb3dPolyline" (vlax-get-property vl_name 'objectname))
	(/= "AcDb2dPolyline" (vlax-get-property vl_name 'objectname)))
	(progn
	
	(if (= :vlax-true (vlax-get-property vl_name 'LinetypeGeneration))
	(setvar "PLINEGEN" 1)
	(setvar "PLINEGEN" 0)
	)
	
	(setq x (cdr (assoc -1 (entget (ssname d i)))))
	(cond (
	(= :vlax-true (vlax-get-property vl_name 'closed))
	(setq close 1)
	(setq tt (vlax-curve-getendparam vl_name))
	)
	(T 
	(setq close 0)
	(setq tt (1+ (vlax-curve-getendparam vl_name)))
	)
	)
	(setq j 0)
	(setq y (vlax-curve-getPointAtParam x j))
	(while (/= y '())
	(setq len (append len y))
	(setq j (+ 1 j))
	(setq y (vlax-curve-getPointAtParam x j)))
	(setq ii 0)
	(setq tt2 (/ (vl-list-length len) 3))
	(setq lll '())
	(while (< ii tt2)
	(setq lll (cons (list (nth (* ii 3) len) (nth (+ 1 (* ii 3)) len)) lll))
	(setq ii (+ 1 ii)))
	(setq lll (reverse lll))
	(setq ii 0)
	(setq bulges '())
	(while (< ii tt)
	(setq bulges (append bulges (list (vla-getbulge vl_name ii))))
	(setq ii (+ 1 ii)))
	(setq ii 0)
	(setq wid1 0 wid2 0 wids1 '() wids2 '())
	(while (< ii tt)
	(vla-getwidth vl_name ii 'wid1 'wid2)
	;(print wid1)
	;(print wid2)
	(setq wids1 (append wids1 (list wid1))
	      wids2 (append wids2 (list wid2)))
	(setq ii (+ 1 ii)))
	
	
	
	
	
	
	
	;(print "2Dpoly")
	
;	(setq x (cdr (assoc -1 (entget (ssname d i)))))
;	(setq j 0)
;	(setq y (vlax-curve-getPointAtParam x j))
;	(while (/= y '())
;	(setq len (append len y))
;	(setq j (+ 1 j))
;	(setq y (vlax-curve-getPointAtParam x j)))
;	(setq ii 0)
;	(setq tt (/ (vl-list-length len) 3))
;	(setq tt1 (vlax-curve-getendparam vl_name))
;	(setq bulges '())
;	(while (< ii tt1)
;	(setq bulges (append bulges (list (vla-getbulge vl_name ii))))
;	(setq ii (+ 1 ii)))
;	(if (/= tt tt1)
;	(setq bulges (append bulges '(0))))
;	(setq ii 0)
;	(setq lll '())
;	(while (< ii tt)
;	(setq lll (cons (list (nth (* ii 3) len) (nth (+ 1 (* ii 3)) len)) lll))
;	(setq ii (+ 1 ii)))
;	(setq lll (reverse lll))



	(LWPoly1 lll bulges wids1 wids2 (assoc 43 (entget (ssname d i))) (assoc 8 (entget (ssname d i))) (assoc 62 (entget (ssname d i))) (assoc 6 (entget (ssname d i)))
	(assoc 48 (entget (ssname d i))) (assoc 370 (entget (ssname d i))) close)
	
	)
	(progn
	;(print "3Dpoly")
	
	(setq x (cdr (assoc -1 (entget (ssname d i)))))
	(setq j 0)
	(setq y (vlax-curve-getPointAtParam x j))
	(while (/= y '())
	(setq len (append len y))
	(setq j (+ 1 j))
	(setq y (vlax-curve-getPointAtParam x j)))
	(setq tt (/ (vl-list-length len) 3))
	(setq ii 0)
	(setq lll '())
	(while (< ii tt)
	(setq lll (cons (list (nth (* ii 3) len) (nth (+ 1 (* ii 3)) len)) lll))
	(setq ii (+ 1 ii)))
	(setq lll (reverse lll))
	(lwpoly lll (assoc 8 (entget (ssname d i))) (assoc 62 (entget (ssname d i))) (assoc 6 (entget (ssname d i)))
	(assoc 48 (entget (ssname d i))) (assoc 370 (entget (ssname d i))) 0)
	
	
	)
	)
	)
	(progn
	;(print "Line")
	
	(setq len (append len (cdr (assoc 10 (entget (ssname d i))))))
	(setq len (append len (cdr (assoc 11 (entget (ssname d i))))))
	(setq tt (/ (vl-list-length len) 3))
	(setq ii 0)
	(setq lll '())
	(while (< ii tt)
	(setq lll (cons (list (nth (* ii 3) len) (nth (+ 1 (* ii 3)) len)) lll))
	(setq ii (+ 1 ii)))
	(setq lll (reverse lll))
	(lwpoly lll (assoc 8 (entget (ssname d i))) (assoc 62 (entget (ssname d i))) (assoc 6 (entget (ssname d i)))
	(assoc 48 (entget (ssname d i))) (assoc 370 (entget (ssname d i))) 0)
	
	
	)
	)
	
	
	
	;(if (/= (cdr (assoc 0 (entget (ssname d i)))) "LINE")
	;(progn
	;(if (/= "AcDb3dPolyline" (vlax-get-property vl_name 'objectname))
	;(progn
	
	
	;)
	;(progn
	
	;)
	;)
	;(progn
	
	;)
	;)
	;)
	(setq i (+ 1 i)))
	(initget 1 "Yes No")
	(setq op2 (getkword "\nErase Selected Polylines? [Yes/No] "))
	(setvar "osmode" om)
	(setvar "3dosmode" 3dom)
	(if (= op2 "Yes")
	(command "erase" d ""))
	(setvar "cecolor" ce_c)
	(setvar "celtype" ce_lt)
	(setvar "celweight" ce_lw)
	(setvar "PLINEGEN" ce_lt_g)
	(setvar "cmdecho" ocecho)
	)
	
	(defun LWPoly (lst lay col lt lts lw cls) ; LM's entmake functions
 (entmakex 
   (append 
     (vl-remove nil (list 
       (cons 0 "LWPOLYLINE")
       (cons 100 "AcDbEntity")
       (cons 100 "AcDbPolyline")
       (cons 90 (length lst))
	   (if (/= nil lay) lay)
	   (if (/= nil col) col)
	   (if (/= nil lt) lt)
	   (if (/= nil lts) lts)
	   (if (/= nil lw) lw)
       (cons 70 cls)
     ))
     (mapcar (function (lambda (p) (cons 10 p))) lst)
   )
 )
)

	(defun LWPoly1 (lst bulg width1 width2 gw lay col lt lts lw cls / lll1 a i tt) ; LM's entmake functions
 (setq i 0)
 (setq a (mapcar (function (lambda (p r a b) (list (cons 10 p) (cons 40 a) (cons 41 b) (cons 42 r)))) lst bulg width1 width2))
 (setq tt (length lst))
 (while (< i tt)
	(setq lll1 (append lll1  (nth i a)))
	(setq i (+ 1 i)))
 (entmakex 
   (append 
     (vl-remove nil (list 
       (cons 0 "LWPOLYLINE")
       (cons 100 "AcDbEntity")
       (cons 100 "AcDbPolyline")
       (cons 90 tt)
	   gw
	   (if (/= nil lay) lay)
	   (if (/= nil col) col)
	   (if (/= nil lt) lt)
	   (if (/= nil lts) lts)
	   (if (/= nil lw) lw)
       (cons 70 cls)
     ))
	 lll1
   )
 )
)