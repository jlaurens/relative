`relative` package
==================

Building the documentation
==========================
```
pdflatex relative-doc
makeindex -s gind.ist relative-doc.idx
makeindex -s gglo.ist -o relative.glo relative.-docgls
pdflatex relative-doc
makeindex -s gind.ist relative-doc.idx
makeindex -s gglo.ist -o relative-doc.glo relative-doc.gls
pdflatex relative-doc
```

Clean the top folder
--------------------
```
rm -f relative.aux
rm -f relative.glo
rm -f relative.hd
rm -f relative.idx
rm -f relative.ilg
rm -f relative.ind
rm -f relative.log
rm -f relative.out
rm -f relative.pdf
```

Testing
=======

All the following commands are preformed from the directory containing `build.lua`.

Clean the testfiles folder
--------------------------
```
rm -f testfiles/*.aux
rm -f testfiles/*.log
rm -f testfiles/*.out
rm -f testfiles/*.pdf
rm -f testfiles/*.gz
```

Save the .tlg
-------------
```
texlua util.lua test save all
```

Test the .tlg for the test failures
-----------------------------------
```
texlua util.lua test tlg all
```

Check
-----
```
l3build check
```




-----

Copyright (C) 2020 jerome.laurens(AT)u-bourgogne.fr <br />
All rights reserved.
