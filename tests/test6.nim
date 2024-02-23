# This can fail.
# This usage is not supported.
# It is not guaranteed to work.
import cppconst/nonutils
from cppconst import CConst

{.emit: "const int x = 1;".}

let x {.importc.}: CConst[cint]

proc main =
  let
    a = x
    b = a
  doAssert b.toNonConst() + 1 == 2

main()
