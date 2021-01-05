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
texlua util.lua clean
texlua util.lua clean source
texlua util.lua clean test
```

Save the .tlg
-------------
```
texlua util.lua test save
```

Test the .tlg for the test failures
-----------------------------------
```
texlua util.lua test tlg
```

Check
-----
```
l3build check
```




-----

Copyright (C) 2020 jerome.laurens(AT)u-bourgogne.fr <br />
All rights reserved.
