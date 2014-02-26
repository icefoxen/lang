type
  TCallback = proc (x: int)

proc echoItem(x: Int) = echo(x)

proc forEach(callback: TCallback) =
  const
    data = [2, 3, 5, 7, 11]
  for d in items(data):
    callback(d)

forEach(echoItem)

