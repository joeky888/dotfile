Extracting page 10 to page 20 from input.pdf
=====
* gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dFirstPage=10 -dLastPage=20 -sOutputFile=output.pdf input.pdf

Merging 1.pdf, 2.pdf and 3.pdf
=====
* gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=output.pdf 1.pdf 2.pdf 3.pdf

Remove password from input.pdf
=====
* gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=output.pdf -c .setpdfwrite -f input.pdf

Invert input.pdf color
=====
* gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=output.pdf -c "{1 exch sub}{1 exch sub}{1 exch sub}{1 exch sub} setcolortransfer" -f input.pdf

Convert a input.pdf to greyscale
=====
* gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -sOutputFile=output.pdf Course01.pdf

Multiple pages pdf to one long page pdf (N-up)
=====
* Currently this is not available on Cygwin
* sudo apt-fast install texlive-extra-utils texlive-latex-recommended --no-install-recommends -y
* Vertically
```sh
pdfjam input.pdf --nup 1x2 --no-landscape --outfile merge.pdf
```
* Horizontally
```sh
pdfjam input.pdf --nup 2x1 --landscape --outfile merge.pdf
```
* Or just using online pdf tools [](http://www.pdfdo.com/pdf-pages-merge.aspx)

Convert PDF to Postscript and vice versa
=====
```sh
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=output.ps input.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dHaveTrueTypes=true -dEmbedAllFonts=true -dSubsetFonts=false -o output.pdf input.ps
```

