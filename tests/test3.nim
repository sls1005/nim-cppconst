import cppconst

proc f(p: ptr CConst[int]): int =
  return p.derefAsNonConst() + 1

proc main =
  let
    x = int(10)
    p1 = addr(x)

  doAssert f(p1) == 11

main()
