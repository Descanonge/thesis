# Thesis

Graphics are not included (folder resources).

Result available at https://theses.hal.science/tel-04249198

The compilation is done with a Makefile that call latexmk. It uses LuaTex.
Each chapter can be compiled independently.

The main document is [master.tex]. It defines some preamble stuff and includes all other tex files.

- [cover page](tex/front_page.tex)
- [front matter](tex/front_matter.tex)
- [introduction](tex/intro.tex)
- [methodology ](tex/méthodes.tex)
- [results on Chl](tex/res_chl.tex)
- [results on phenology](tex/res_phénologie.tex)
- [conclusion](tex/conclusion.tex)
- [perspectives](tex/perspectives.tex)
- [code appendix](tex/annexes_sms.tex), [other appendices](tex/annexes_autres.tex), and [bibliograpy](tex/biblio.tex)

The preamble is split up in multiple .sty files.
- [ch-thesis.sty](src/ch-thesis.sty): main one and includes subfiles when needed
- [bib-setup.sty](src/bib-setup.sty): biblatex setup
- [gls-setup.sty](src/gls-setup.sty): glossary setup
- [cref-setup.sty](src/cref-setup.sty): cross-references (cleveref mainly)
- [siunit-setup.sty](src/siunit-setup.sty): siunitx setup, defines units and convenience commands

A lot of code is using LaTeX3 features available through different packages.
See (interface3)[https://mirrors.ircam.fr/pub/CTAN/macros/latex/contrib/l3kernel/interface3.pdf] documentations for commands references.
