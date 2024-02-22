import cppconst

proc f(p: ptr CConst[int8]): int8 =
  return p.derefAsNonConst() + 1

proc main =
  var x = int8(10)
  let p1 = addr(x)
  doAssert f(p1) == 11

main()
