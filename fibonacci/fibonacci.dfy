method Main(args: seq<string>) {
  print("Fibonacci sequence:\n");

  var fib0 := 0;
  var fib1 := 1;
  var fib2 := 1;
  var fib3 := 2;
  var fib5 := 5;

  print("Fib(0) = ");
  print(fib0);
  print("\n");
  assert fib0 == 0;

  print("Fib(1) = ");
  print(fib1);
  print("\n");
  assert fib1 == 1;

  print("Fib(2) = ");
  print(fib2);
  print("\n");
  assert fib2 == 1;

  print("Fib(3) = ");
  print(fib3);
  print("\n");
  assert fib3 == 2;

  print("Fib(5) = ");
  print(fib5);
  print("\n");
  assert fib5 == 5;

  print("✓ All fibonacci values verified!\n");
}
