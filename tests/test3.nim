import cppconst

proc f(p: ptr CConst[int]) =
  echo p.derefAsNonConst() + 1

var
  x = int(10)
  p1 = addr(x)

f(p1)
