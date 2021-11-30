# Storage

Small benchmark test app for educational purpose.
Might not be entirely accurate.

The goal was to check how fast could mnesia be, compared to Redis.

Some results :

```
iex(4)> Storage.Test.test(1)
[
  %{errors: 0, name: :mnesia, ok: 2, time_sec: 0.001134},
  %{errors: 0, name: :redis, ok: 2, time_sec: 0.014126}
]
iex(5)> Storage.Test.test(10)
[
  %{errors: 0, name: :mnesia, ok: 11, time_sec: 0.002338},
  %{errors: 0, name: :redis, ok: 11, time_sec: 0.043837}
]
iex(6)> Storage.Test.test(100)
[
  %{errors: 0, name: :mnesia, ok: 101, time_sec: 0.01739},
  %{errors: 0, name: :redis, ok: 101, time_sec: 0.25939}
]
iex(7)> Storage.Test.test(1000)
[
  %{errors: 0, name: :mnesia, ok: 1001, time_sec: 0.088342},
  %{errors: 0, name: :redis, ok: 1001, time_sec: 2.550352}
]
iex(8)> Storage.Test.test(5000)
[
  %{errors: 0, name: :mnesia, ok: 5001, time_sec: 0.423006},
  %{errors: 0, name: :redis, ok: 5001, time_sec: 12.707245}
]
```
