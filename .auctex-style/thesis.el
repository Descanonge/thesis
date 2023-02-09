;;; .auctex-style Custom project style

(TeX-add-style-hook
 "thesis"
 (lambda ()
   (TeX-add-symbols
    '("refunsection" TeX-arg-ref)
    '("chapref" TeX-arg-ref TeX-arg-ref)
    '("resol" "N over" "M")
    '("dataset" [TeX-arg-ref 0 "sec:donnees-"]))
   (LaTeX-section-list-add-locally '("unsection" 2))
   (LaTeX-section-list-add-locally '("unsubsection" 3))
   LaTeX-dialect)
 )
