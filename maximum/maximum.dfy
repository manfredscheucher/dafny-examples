function Max(a: int, b: int): int {
  if a > b then a else b
}

method Main(args: seq<string>) {
  var r1 := Max(10, 20);
  print("Max(10, 20) = ");
  print(r1);
  print("\n");
  assert r1 == 20;

  var r2 := Max(-5, -10);
  print("Max(-5, -10) = ");
  print(r2);
  print("\n");
  assert r2 == -5;

  var r3 := Max(42, 42);
  print("Max(42, 42) = ");
  print(r3);
  print("\n");
  assert r3 == 42;

  print("✓ All maximum tests passed!\n");
}
