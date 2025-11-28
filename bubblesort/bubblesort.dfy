predicate IsSorted(arr: array<int>) {
  forall i, j :: 0 <= i <= j < arr.Length ==> arr[i] <= arr[j]
}

method BubbleSort(arr: array<int>)
  modifies arr
  ensures IsSorted(arr)
{
  var n := arr.Length;
  var pass := 0;
  while pass < n
    invariant 0 <= pass <= n
  {
    var j := 0;
    while j < n - 1 {
      if arr[j] > arr[j + 1] {
        var temp := arr[j];
        arr[j] := arr[j + 1];
        arr[j + 1] := temp;
      }
      j := j + 1;
    }
    pass := pass + 1;
  }
}

method Main(args: seq<string>) {
  print("Bubble sort example:\n");

  var arr := new int[5];
  arr[0] := 64;
  arr[1] := 34;
  arr[2] := 25;
  arr[3] := 12;
  arr[4] := 22;

  print("Original array: ");
  var i := 0;
  while i < arr.Length {
    print(arr[i]);
    print(" ");
    i := i + 1;
  }
  print("\n");

  BubbleSort(arr);

  print("Sorted array: ");
  i := 0;
  while i < arr.Length {
    print(arr[i]);
    print(" ");
    i := i + 1;
  }
  print("\n");

  assert IsSorted(arr);
  print("✓ Array is correctly sorted!\n");
}
