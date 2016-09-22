import math as m
import strutils as su
import algorithm as algo
import future

type TUnit = tuple[suffix: string, modulo: float, scaleFactor: float]
const units: seq[TUnit] = @[
  (suffix: "ms", modulo: 1.0, scaleFactor: 1000.0),
  (suffix: "s", modulo: 60.0, scaleFactor: 1.0),
  (suffix: "m", modulo: 3600.0, scaleFactor: (1.0/60.0)),
  (suffix: "h", modulo: (24*3600.0), scaleFactor: (1.0/3600.0))]

proc getTimeArray( elapsedTime: float ): seq[string] =
  result = @[]
  var acc = elapsedTime
  for unit in units:
    let u = m.fmod(acc, unit.modulo)
    let str = $int(m.round(u * unit.scaleFactor))
    result.add(str & unit.suffix)
    acc -= u
  algo.reverse(result)

proc humanize*(elapsedTime: float): string =
  ## Turn a delta time into a human readable string
  ##
  ## humanize(4.031) => 4s 31ms
  let timeArr: seq[string] = getTimeArray( elapsedTime )
  let nonZero = lc[ time | ( time <- timeArr, not time.startswith("0") ), string ]
  result = if len( nonZero ) != 0: su.join( nonZero, " " ) else: "0ms"

proc humanize_max*(elapsedTime: float): string =
  ## Turn a delta time into a human readable string that is only the highest term
  ##
  ## humanize_max(4.031) => 4s
  result = humanize( elapsedTime ).split( " " )[0]

proc robotize*(elapsedTime: float): string =
  ## Turn a delta time into a robot readable string
  ##
  ## robotize(4.031) => 0h 0m 4s 31ms
  result = su.join( getTimeArray( elapsedTime ), " ")

when isMainModule:
  assert("25ms" == humanize(0.025))
  assert("0h 0m 0s 25ms" == robotize(0.025))
  assert("3s 19ms" == humanize(3.019))
  assert("0h 0m 3s 19ms" == robotize(3.019))
  assert("59s 999ms" == humanize(59.999))
  assert("0h 0m 59s 999ms" == robotize(59.999))
  assert("4s 9ms" == humanize(4.009))
  assert("0h 0m 4s 9ms" == robotize(4.009))
  assert("9s" == humanize(9.0))
  assert("0h 0m 9s 0ms" == robotize(9.0))
  assert("1m 4s 9ms" == humanize(64.009))
  assert("0h 1m 4s 9ms" == robotize(64.009))
  assert("2m 44s 23ms" == humanize(164.023))
  assert("0h 2m 44s 23ms" == robotize(164.023))
  assert("1h 6m 40s" == humanize(4000.0))
  assert("1h 6m 40s 0ms" == robotize(4000.0))
  assert("1h 6m 40s 243ms" == humanize(4000.243))
  assert("1h 6m 40s 243ms" == robotize(4000.243))
  assert("1h" == humanize(3600.0))
  assert("1h 0m 0s 0ms" == robotize(3600.0))
  assert("0ms" == humanize(0.0))
  assert("0h 0m 0s 0ms" == robotize(0.0))
  assert("0ms" == humanize_max(0.0))
  assert("25ms" == humanize_max(0.025))
  assert("3s" == humanize_max(3.019))
  assert("9s" == humanize_max(9.0))
  assert("2m" == humanize_max(124.009))
  assert("1h" == humanize_max(4000.243))

  echo "all tests passed."
