import cppconst

{.emit: """
const int x = 1;
extern "C" const int* foo() {
    return &x;
}
""".}

proc foo(): ptr CConst[cint] {.importc, noconv.}

proc main =
  var p = foo()
  doAssert not p.isNil()
  doAssert p.derefAsNonConst() == 1

main()