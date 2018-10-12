import algorithm, math, strutils, sugar

type
  Unit = tuple[suffix: string, modulo: float, scaleFactor: float]

const
  units: seq[Unit] = @[
    (suffix: "ms", modulo: 1.0, scaleFactor: 1000.0),
    (suffix: "s", modulo: 60.0, scaleFactor: 1.0),
    (suffix: "m", modulo: 3600.0, scaleFactor: (1.0 / 60.0)),
    (suffix: "h", modulo: (24 * 3600.0), scaleFactor: (1.0 / 3600.0))
  ]

proc getTimeArray (elapsedTime: float): seq[string] =
  var acc = elapsedTime
  for unit in units:
    let u = acc mod unit.modulo
    let str = $int(round(u * unit.scaleFactor))
    result.add(str & unit.suffix)
    acc -= u
  reverse result

proc humanize* (elapsedTime: float): string =
  ## Turn a delta time into a human readable string.
  runnableExamples:
    doAssert humanize(4.031) == "4s 31ms"

  let timeArr = getTimeArray(elapsedTime)
  let nonZero = lc[
    time | (time <- timeArr, not time.startswith("0")),
    string
  ]
  result = if nonZero.len != 0: nonZero.join(" ") else: "0ms"

proc humanizeMax* (elapsedTime: float): string =
  ## Turn a delta time into a human readable string that is only the highest term
  runnableExamples:
    doAssert humanizeMax(4.031) == "4s"

  result = humanize(elapsedTime).split(" ")[0]

proc robotize* (elapsedTime: float): string =
  ## Turn a delta time into a robot readable string. In other words,
  ## units with zero values are still included in the result.
  ##
  runnableExamples:
    robotize(4.031) == "0h 0m 4s 31ms"

  result = getTimeArray(elapsedTime).join(" ")

when isMainModule:
  assert "25ms" == humanize(0.025)
  assert "0h 0m 0s 25ms" == robotize(0.025)
  assert "3s 19ms" == humanize(3.019)
  assert "0h 0m 3s 19ms" == robotize(3.019)
  assert "59s 999ms" == humanize(59.999)
  assert "0h 0m 59s 999ms" == robotize(59.999)
  assert "4s 9ms" == humanize(4.009)
  assert "0h 0m 4s 9ms" == robotize(4.009)
  assert "9s" == humanize(9.0)
  assert "0h 0m 9s 0ms" == robotize(9.0)
  assert "1m 4s 9ms" == humanize(64.009)
  assert "0h 1m 4s 9ms" == robotize(64.009)
  assert "2m 44s 23ms" == humanize(164.023)
  assert "0h 2m 44s 23ms" == robotize(164.023)
  assert "1h 6m 40s" == humanize(4000.0)
  assert "1h 6m 40s 0ms" == robotize(4000.0)
  assert "1h 6m 40s 243ms" == humanize(4000.243)
  assert "1h 6m 40s 243ms" == robotize(4000.243)
  assert "1h" == humanize(3600.0)
  assert "1h 0m 0s 0ms" == robotize(3600.0)
  assert "0ms" == humanize(0.0)
  assert "0h 0m 0s 0ms" == robotize(0.0)

  assert "0ms" == humanizeMax(0.0)
  assert "25ms" == humanizeMax(0.025)
  assert "3s" == humanizeMax(3.019)
  assert "9s" == humanizeMax(9.0)
  assert "2m" == humanizeMax(124.009)
  assert "1h" == humanizeMax(4000.243)

  echo "all tests passed."
