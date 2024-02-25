import cppconst

type Foo = object
  i: int16

proc test(p: ptr CConst[Foo]): int16 =
  if not p.isNil():
    p.derefAsNonConst().i
  else:
    0

proc main =
  var f: Foo
  f.i = 2
  let p1 = addr(f)
  doAssert test(p1) == 2

main()
