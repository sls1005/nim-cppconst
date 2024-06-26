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

+ Although `const`-qualified types are also used in C (which is why the type in this package is named so), the actual type this package wraps and some of the pragmas it uses to wrap can only be used on the C++ backend, so this can only be used with the C++ backend. Typically, it's C++ that requires to view a `const`-qualified type as a separate type. If your C compiler is as strict, consider switching to the C++ backend or making your own wrapper.

+ Normally, this is not required when wrapping a C/C++ function with a parameter that uses const qualifiers, nor is it required when wrapping a constant or a function that returns a constant. The only situation where this is possibly required is when wrapping a C/C++ pointer-to-const or a function that returns a pointer-to-const.

+ The type `CConst` cannot be normally instantiated or used as a parameter type or return type. Only the pointers can. Such as `ptr CConst[T]` (corresponding to C++ `const T*`), `ptr ptr CConst[T]` (`const T**`), `ptr CConst[ptr T]` (`T * const*`) and `ptr CConst[ptr CConst[T]]` (`const T * const*`); the outmost level must not be `CConst` (or `CConst[ptr]`).

+ This distinguishes between levels of constness (very strictly); between that of a pointer and of a pointee (for ensuring the most compatibility with C++). Basically, what wouldn't be allowed in C++ is not allowed. 

+ The recommend (though not required) version of the compiler to be used with this is 1.2.0 or later. The backend C++ compiler has to at least support C++11 or later.