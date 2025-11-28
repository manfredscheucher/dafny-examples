function Factorial(n: int): int
  requires n >= 0
  decreases n
{
  if n <= 1 then 1 else n * Factorial(n - 1)
}

method Main(args: seq<string>) {
  print("Factorial values:\n");
  var i := 0;
  while i <= 10
    invariant 0 <= i <= 11
  {
    print("Factorial(");
    print(i);
    print(") = ");
    print(Factorial(i));
    print("\n");
    i := i + 1;
  }
}
