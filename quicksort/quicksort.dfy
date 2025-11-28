predicate IsSorted(a: seq<int>) {
  forall i, j :: 0 <= i <= j < |a| ==> a[i] <= a[j]
}

method Partition(arr: array<int>, low: int, high: int) returns (pi: int)
  requires 0 <= low <= high < arr.Length
  requires arr.Length > 0
  modifies arr
  ensures low <= pi <= high
{
  var pivot := arr[high];
  var i := low - 1;
  var j := low;

  while j < high
    invariant low - 1 <= i < j <= high
  {
    if arr[j] < pivot {
      i := i + 1;
      var temp := arr[i];
      arr[i] := arr[j];
      arr[j] := temp;
    }
    j := j + 1;
  }

  var temp := arr[i + 1];
  arr[i + 1] := arr[high];
  arr[high] := temp;
  pi := i + 1;
}

method QuickSort(arr: array<int>, low: int, high: int)
  requires 0 <= low <= high + 1 <= arr.Length
  modifies arr
{
  if low < high {
    var pi := Partition(arr, low, high);
    QuickSort(arr, low, pi - 1);
    QuickSort(arr, pi + 1, high);
  }
}

method Main(args: seq<string>) {
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

  QuickSort(arr, 0, arr.Length - 1);

  print("Sorted array: ");
  i := 0;
  while i < arr.Length {
    print(arr[i]);
    print(" ");
    i := i + 1;
  }
  print("\n");
}
