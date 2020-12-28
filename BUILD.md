`relative` package
==================

Building the documentation
==========================
```
l3build doc
```

Clean the top folder
--------------------
```
texlua util.lua clean
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
