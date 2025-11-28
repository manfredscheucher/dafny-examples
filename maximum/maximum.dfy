function Max(a: int, b: int): int {
  if a > b then a else b
}

method Main(args: seq<string>) {
  print("Max(10, 20) = ");
  print(Max(10, 20));
  print("\n");
  print("Max(-5, -10) = ");
  print(Max(-5, -10));
  print("\n");
  print("Max(42, 42) = ");
  print(Max(42, 42));
  print("\n");
}
