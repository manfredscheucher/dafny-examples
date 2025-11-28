function Fib(n: int): int
  requires n >= 0
  decreases n
{
  if n <= 1 then n else Fib(n-1) + Fib(n-2)
}

method Main(args: seq<string>) {
  print("Fibonacci sequence:\n");
  var i := 0;
  while i <= 10
    invariant 0 <= i <= 11
  {
    print("Fib(");
    print(i);
    print(") = ");
    print(Fib(i));
    print("\n");
    i := i + 1;
  }
}
