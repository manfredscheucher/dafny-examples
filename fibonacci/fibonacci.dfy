function Fib(n: int): int
  requires n >= 0
  decreases n
{
  if n <= 1 then n else Fib(n-1) + Fib(n-2)
}

method Main(args: seq<string>) {
  print("Fibonacci sequence:\n");
  print("Fib(0) = ");
  print(Fib(0));
  print("\n");
  assert Fib(0) == 0;

  print("Fib(1) = ");
  print(Fib(1));
  print("\n");
  assert Fib(1) == 1;

  print("Fib(2) = ");
  print(Fib(2));
  print("\n");
  assert Fib(2) == 1;

  print("Fib(3) = ");
  print(Fib(3));
  print("\n");
  assert Fib(3) == 2;

  print("Fib(4) = ");
  print(Fib(4));
  print("\n");
  assert Fib(4) == 3;

  print("Fib(5) = ");
  print(Fib(5));
  print("\n");
  assert Fib(5) == 5;

  print("✓ All fibonacci values verified!\n");
}
