import cppconst/nonutils
from cppconst import CConst

{.emit: "const int x = 1;".}
let x {.importc.}: CConst[cint]
doAssert x.toNonConst() + 1 == 2
