import math as m
import strutils as su
import algorithm as algo

type TUnit = tuple[suffix: string, modulo: float, scaleFactor: float]
const units: seq[TUnit] = @[
  (suffix: "ms", modulo: 1.0, scaleFactor: 1000.0),
  (suffix: "s", modulo: 60.0, scaleFactor: 1.0),
  (suffix: "m", modulo: 3600.0, scaleFactor: (1.0/60.0)),
  (suffix: "h", modulo: (24*3600.0), scaleFactor: (1.0/3600.0))]

proc humanize*(elapsedTime: float): string =
  ## Turn a delta time into a human readable string
  ##
  ## humanize(4.031) => 4s 31ms
  var
    timeArr: seq[string] = @[]
    acc = elapsedTime
  for unit in units:
    let
      u = m.fmod(acc, unit.modulo)
      str = $m.round(u * unit.scaleFactor)
    if str != "0":
      timeArr.add(str & unit.suffix)
    acc -= u
  algo.reverse(timeArr)
  result = su.join(timeArr, " ")

proc robotize*(elapsedTime: float): string =
  ## Turn a delta time into a robot readable string
  ##
  ## robotize(4.031) => 0h 0m 4s 31ms
  var
    timeArr: seq[string] = @[]
    acc = elapsedTime
  for unit in units:
    let
      u = m.fmod(acc, unit.modulo)
      str = $m.round(u * unit.scaleFactor)
    timeArr.add(str & unit.suffix)
    acc -= u
  algo.reverse(timeArr)
  result = su.join(timeArr, " ")

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
  echo "all tests passed."


