Disable bold and italic font
=====
* :echo $VIMRUNTIME
* $ cd %VIMRUNTIME%
* In /syntax
* $ sudo sed -i 's/=bold/=NONE/g' *.vim
* $ sudo sed -i 's/=italic/=NONE/g' *.vim
