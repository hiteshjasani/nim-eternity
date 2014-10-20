import math as m
import strutils as su

proc humanize*(elapsedTime: float): string =
  ## Turn a delta time into a human readable string
  var acc = elapsedTime
  let
    milliseconds = m.fmod(acc, 1.0)
    scaled_milliseconds = 1000.0 * milliseconds
    smilliseconds = $m.round(scaled_milliseconds)
  acc -= milliseconds
  let
    seconds = m.fmod(acc, 60)
    sseconds = $m.round(seconds)
  acc -= seconds
  let
    minutes = m.fmod(acc, 3600)
    scaled_minutes = minutes / 60.0
    sminutes = $m.round(scaled_minutes)
  acc -= minutes
  let
    hours = m.fmod(acc, 24 * 3600)
    scaled_hours = hours / 3600.0
    shours = $m.round(scaled_hours)
  var timeArr: seq[string] = @[]
  if shours != "0": timeArr.add(shours & "h")
  if sminutes != "0": timeArr.add(sminutes & "m")
  if sseconds != "0": timeArr.add(sseconds & "s")
  if smilliseconds != "0": timeArr.add(smilliseconds & "ms")
  result = su.join(timeArr, " ")


when isMainModule:
  assert("25ms" == humanize(0.025))
  assert("3s 19ms" == humanize(3.019))
  assert("59s 999ms" == humanize(59.999))
  assert("4s 9ms" == humanize(4.009))
  assert("9s" == humanize(9.0))
  assert("1m 4s 9ms" == humanize(64.009))
  assert("2m 44s 23ms" == humanize(164.023))
  assert("1h 6m 40s" == humanize(4000.0))
  assert("1h 6m 40s 243ms" == humanize(4000.243))
  assert("1h" == humanize(3600.0))
  echo "all tests passed."


