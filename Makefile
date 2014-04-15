NAME=carte
PAGE=fgp
ALL=$(NAME)-$(PAGE)
DEST=$(ALL).ps
VIEWER=zathura

all : $(DEST)

$(DEST) : $(ALL).dvi
	dvips -t a4 -f < $< > $@

$(ALL).dvi : $(NAME)-page.tex $(ALL).tex images/*.ps
	latex $<
	mv $(NAME)-page.dvi $@

$(ALL).tex : $(NAME).tex
	cp $< $@.tmp
	sed -e '/^\\begin{document}/,/^\\end{document}/!d' \
	-e '/^\\begin{document}/d' \
	-e '/^\\end{document}/d'  $< > $@

clean :
	@touch $(ALL).tex carte.log carte.ps carte.pdf carte.dvi carte.aux
	@rm -v $(ALL).* *.log *.ps *.pdf *.dvi *.aux

rec : clean all

view : $(DEST)
	$(VIEWER) $< > /dev/null 2>&1

example :
	$(VIEWER) ../visit_card_1.8/carte-page-img-fgp.ps > /dev/null 2>&1 &

.PHONY: view rec clean all example


