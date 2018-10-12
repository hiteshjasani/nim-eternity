# eternity &middot; [![nimble](https://flat.badgen.net/badge/available%20on/nimble/yellow)](https://nimble.directory/pkg/eternity) ![license](https://flat.badgen.net/github/license/hiteshjasani/nim-eternity) [![Travis branch](https://flat.badgen.net/travis/hiteshjasani/nim-eternity/master)](https://travis-ci.com/hiteshjasani/nim-eternity)

[Nim][nim] library for converting delta (elapsed) times into human or bot
readable formats.

## installation & usage

Install using [Nimble][nimble]:

```shell
nimble install eternity
```

Then `import` and use:

```nim
import eternity

echo humanize(3600.0)		# 1h
echo robotize(3600.0)		# 1h 0m 0s 0ms

echo humanize(36.125)		# 36s 125ms
echo robotize(36.125)		# 0h 0m 36s 125ms

echo humanize(60.002)		# 1m 2ms
echo robotize(60.002)		# 0h 1m 0s 2ms
```

## license

MIT © [Hitesh Jasani](https://github.com/hiteshjasani)

[nim]: https://github.com/nim-lang/nim
[nimble]: https://github.com/nim-lang/nimble
