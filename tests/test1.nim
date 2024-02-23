import cppconst

{.emit: """
const int x = 1;
const int * p = &x;
const int * const * foo() {
    return &p;
}
""".}

proc foo(): ptr CConst[ptr CConst[cint]] {.importcpp: "$1(@)".}

proc main =
  var p1 = foo()
  doAssert not p1.isNil()
  var p2 = p1.derefAsNonConst()
  doAssert not p2.isNil()
  doAssert p2.derefAsNonConst() == 1

main()