This wraps C++'s `const`-qualified types for Nim. It actually wraps the type `std::add_const<T>::type` from `<type_traits>`.

### Example

```nim
from cppconst import CConst, derefAsNonConst

{.emit: """
const int x = 1;
const int* foo() {
    return &x;
}
""".}

proc foo(): ptr CConst[cint] {.importcpp: "$1(@)".}

var p = foo()
doAssert not p.isNil()
doAssert p.derefAsNonConst() == 1
```

### Note

+ Although `const`-qualified types are also used in C (which is why the type in this package is named so), the actual type this package wraps and some of the pragmas it uses to wrap can only be used on the C++ backend, so this can only be used with the C++ backend. Normally, it's C++ that requires to view a `const`-qualified type as a separate type. If your C compiler is as strict, consider switching to the C++ backend or make your own wrapper.

+ Normally, this is not required when wrapping a C/C++ function with a parameter that uses const qualifiers, nor is it required when wrapping a constant or a function that returns a constant. The only situation where this is possibly required is when wrapping a C/C++ pointer-to-const or a function that returns a pointer-to-const.
