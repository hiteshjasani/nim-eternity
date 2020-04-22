import unittest

import eternity

test "humanize":
  check:
    "25ms" == humanize(0.025)
    "3s 19ms" == humanize(3.019)
    "59s 999ms" == humanize(59.999)
    "4s 9ms" == humanize(4.009)
    "9s" == humanize(9.0)
    "1m 4s 9ms" == humanize(64.009)
    "2m 44s 23ms" == humanize(164.023)
    "1h 6m 40s" == humanize(4000.0)
    "1h 6m 40s 243ms" == humanize(4000.243)
    "1h" == humanize(3600.0)
    "0ms" == humanize(0.0)

test "humanize_trunc":
  check:
    "0ms" == humanize_trunc(0.0)
    "4s" == humanize_trunc(4.031)
    "4s" == humanize_trunc(4.888)
    "25ms" == humanize_trunc(0.025)
    "3s" == humanize_trunc(3.019)
    "9s" == humanize_trunc(9.0)
    "2m" == humanize_trunc(124.009)
    "1h" == humanize_trunc(4000.243)

test "robotize":
  check:
    "0h 0m 0s 25ms" == robotize(0.025)
    "0h 0m 3s 19ms" == robotize(3.019)
    "0h 0m 59s 999ms" == robotize(59.999)
    "0h 0m 4s 9ms" == robotize(4.009)
    "0h 0m 9s 0ms" == robotize(9.0)
    "0h 1m 4s 9ms" == robotize(64.009)
    "0h 2m 44s 23ms" == robotize(164.023)
    "1h 6m 40s 0ms" == robotize(4000.0)
    "1h 6m 40s 243ms" == robotize(4000.243)
    "1h 0m 0s 0ms" == robotize(3600.0)
    "0h 0m 0s 0ms" == robotize(0.0)
