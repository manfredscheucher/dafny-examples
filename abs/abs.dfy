function Abs(x: int): int {
  if x < 0 then -x else x
}

method Main(args: seq<string>) {
  var r1 := Abs(5);
  print("Abs(5) = ");
  print(r1);
  print("\n");
  assert r1 == 5;

  var r2 := Abs(-10);
  print("Abs(-10) = ");
  print(r2);
  print("\n");
  assert r2 == 10;

  var r3 := Abs(0);
  print("Abs(0) = ");
  print(r3);
  print("\n");
  assert r3 == 0;

  print("✓ All absolute value tests passed!\n");
}
