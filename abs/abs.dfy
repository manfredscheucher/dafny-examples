function Abs(x: int): int {
  if x < 0 then -x else x
}

method Main(args: seq<string>) {
  print("Abs(5) = ");
  print(Abs(5));
  print("\n");
  print("Abs(-10) = ");
  print(Abs(-10));
  print("\n");
  print("Abs(0) = ");
  print(Abs(0));
  print("\n");
}
