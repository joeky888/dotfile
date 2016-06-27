Extracting page 10 to page 20 from input.pdf
=====
* gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dFirstPage=10 -dLastPage=20 -sOutputFile=output.pdf input.pdf

Merging 1.pdf, 2.pdf and 3.pdf
=====
* gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=output.pdf 1.pdf 2.pdf 3.pdf
