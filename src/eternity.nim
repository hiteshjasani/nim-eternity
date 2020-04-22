from math as m import nil
from strutils as su import nil
from algorithm as algo import nil
import sugar

type Unit = tuple[suffix: string, modulo: float, scaleFactor: float]

const units: seq[Unit] = @[
  (suffix: "ms", modulo: 1.0, scaleFactor: 1000.0),
  (suffix: "s", modulo: 60.0, scaleFactor: 1.0),
  (suffix: "m", modulo: 3600.0, scaleFactor: (1.0/60.0)),
  (suffix: "h", modulo: (24*3600.0), scaleFactor: (1.0/3600.0))]

proc getTimeArray(elapsedTime: float): seq[string] =
  result = @[]
  var acc = elapsedTime
  for unit in units:
    let u = m.mod(acc, unit.modulo)
    let str = $int(m.round(u * unit.scaleFactor))
    result.add(str & unit.suffix)
    acc -= u
  algo.reverse(result)

proc humanize*(elapsedTime: float): string =
  ## Turn a delta time into a human readable string
  ##
  ## humanize(4.031) => 4s 31ms
  ## humanize(4.888) => 4s 888ms
  let timeArr: seq[string] = getTimeArray(elapsedTime)
  let nonZero = collect(newSeq):
    for time in timeArr:
      if not su.startsWith(time, "0"):
        time
  result = if len(nonZero) != 0: su.join(nonZero, " " ) else: "0ms"

proc humanize_trunc*(elapsedTime: float): string =
  ## Turn a delta time into a human readable string that is truncated to
  ## the highest (most significant) term
  ##
  ## humanize_trunc(4.031) => 4s
  ## humanize_trunc(4.888) => 4s
  result = su.split(humanize(elapsedTime), " " )[0]

proc robotize*(elapsedTime: float): string =
  ## Turn a delta time into a robot readable string
  ##
  ## robotize(4.031) => 0h 0m 4s 31ms
  ## robotize(4.888) => 0h 0m 4s 888ms
  result = su.join(getTimeArray(elapsedTime), " ")
