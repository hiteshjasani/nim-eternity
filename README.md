nim-eternity
============

Library to convert delta times into a human readable format.

## Usage

```nimrod
import eternity as e

echo e.humanize(3600.0)		# 1h

echo e.humanize(36.125)		# 36s 125ms

echo e.humanize(60.002)		# 1m 2ms
```


