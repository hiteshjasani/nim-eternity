version = "0.2"
author = "Hitesh Jasani"
description = "Library to humanize elapsed times"
license = "MIT"

requires "nim >= 0.19.0"

task test, "Run the test suite":
  exec "nim c --hints:off --verbosity:0 -r eternity.nim"
