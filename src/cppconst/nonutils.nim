## The procedure defined in this module is not in any way useful in normal code. Thus the name (Non-utilities).
from ../cppconst import CConst

proc toNonConst*[T](c: CConst[T]): T {.importcpp: "(('0)(#))", noconv, nodecl, raises: [].}
  ## **Example:**
  ##
  ## .. code-block::
  ##   import cppconst
  ##   import cppconst/nonutils
  ##
  ##   {.emit: "const int x = 1;".}
  ##   let x {.importc.}: CConst[cint]
  ##   echo x.toNonConst()
