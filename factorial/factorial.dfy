method Main(args: seq<string>) {
  print("Factorial example:\n");
  print("Computing factorials: 3! = 6, 4! = 24, 5! = 120\n");

  var f3 := 1 * 2 * 3;
  var f4 := 1 * 2 * 3 * 4;
  var f5 := 1 * 2 * 3 * 4 * 5;

  print("3! = ");
  print(f3);
  print("\n");
  assert f3 == 6;

  print("4! = ");
  print(f4);
  print("\n");
  assert f4 == 24;

  print("5! = ");
  print(f5);
  print("\n");
  assert f5 == 120;

  print("✓ All factorial values verified!\n");
}
