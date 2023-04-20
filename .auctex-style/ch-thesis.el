
(TeX-add-style-hook
 "ch-thesis"
 (lambda ()
   (TeX-add-symbols
    '("nref" ["text"] TeX-arg-label ignore)
    )
   (font-latex-add-keywords '(("nref" "[{"))
                            'reference)
   )
 :latex)
