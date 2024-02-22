import cppconst

{.emit: """
const char* s1 = "abc";
""".}
var s1 {.importc.}: ptr CConst[cchar]
var s2 = s1
var s3: string = "def"
doAssert s2.toCString() == "abc"
s1 = s3.cstring
doAssert s1.toCString == "def"
