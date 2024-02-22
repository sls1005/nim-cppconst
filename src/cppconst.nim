when not defined(cpp):
  {.error: "This can only be used with the C++ backend.".}

type CConst*[T] {.importcpp: "std::add_const<'0>::type", header: "<type_traits>", cppNonPod.} = object
  ## This type can not be normally instantiated. It is NOT intended to be used directly as the type of a variable, but to be used to form a more complex type (usually a pointer).
  ## For example, `ptr CConst[cchar]` is corresponding to `const char*` (non-const pointer to a const char) in C++.
  ##
  ## A variable whose type is in the form `CConst[T]`, where `T` can be any type, will (probably) cause an error at the C++ compile-time, unless it's `{.importc.}`. (But it can be of the type `ptr CConst[T]`.)
  ##
  ## **Example:**
  ##
  ## .. code-block::
  ##   import cppconst
  ##   var p: ptr CConst[cint]
  ##
  ## **Note:** A `const char*` is a `ptr CConst[cchar]` (non-const pointer to const char), not `CConst[ptr cchar]` (const pointer to non-const char, represented as `char * const` in C++) nor `CConst[cstring]` (`char * const`).

{.push importcpp: "(const_cast<'0>(#))", noconv, nodecl, raises: [].}

proc toPtrToNonConst*[T](p: ptr CConst[T]): ptr T
  ## This is **unsafe** as it discards the const qualifier.
  ##
  ## The value pointed to by a pointer returned by this should not be assigned to, unless it is provably safe to do so, or a segmentation fault, or something worse, can happen at the runtime.

proc toCString*(p: ptr CConst[cchar]): cstring
  ## This is **unsafe** as it discards the const qualifier.
  ##
  ## Any character pointed to by a `cstring` returned by this should not be assigned to, unless it is provably safe to do so, or a segmentation fault, or something worse, can happen at the runtime.
   #
   # `const_cast` is used here as a fail-safe mechanism. If the input type weren't compatible with the (underlying) return type, the code wouldn't even pass the C++ compilation.

proc toPtrToCConstImpl[T](p: ptr T): ptr CConst[T]

proc toPtrToCConstCharImpl(s: cstring): ptr CConst[cchar]

{.pop.}

proc derefAsNonConst*[T](p: ptr CConst[T]): T  {.importcpp: "(('0)(*(#)))", noconv, nodecl, raises: [].}
  ## This is **unsafe** as it dereferences a pointer.
  ##
  ## `[]` should not be used instead of this. (Nor is it possible.)
  ##
  ## The argument must not be `nil`, or a segmentation fault can happen at the runtime.

converter toPtrToCConst*[T](p: ptr T): ptr CConst[T] {.inline, raises: [].} = toPtrToCConstImpl(p)

converter toPtrToCConstChar*(s: cstring): ptr CConst[cchar] {.inline, raises: [].} = toPtrToCConstCharImpl(s)
