import cppconst/nonutils
from cppconst import CConst

{.emit: "const int x = 1;".}

let x {.importc.}: CConst[cint]
# `CConst` isn't needed in such a case.
# One can simply use `cint` here.
# For example:
#[
  let x {.importc, nodecl.}: cint
  echo x
]#

doAssert x.toNonConst() + 1 == 2
