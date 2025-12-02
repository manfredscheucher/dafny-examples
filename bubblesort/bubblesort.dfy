predicate Sorted(s: seq<int>)
{
  forall i, j :: 0 <= i < j < |s| ==> s[i] <= s[j]
}

predicate Partitioned(s: seq<int>, k: int)
{
  0 <= k <= |s| &&
  (forall p, q :: 0 <= p < k && k <= q < |s| ==> s[p] <= s[q])
}

method BubbleSort(a: array<int>)
  modifies a
  ensures Sorted(a[..])
{
  var n := a.Length;
  if n <= 1 { return; }

  var i := 0;
  while i < n
    invariant 0 <= i <= n
    invariant Sorted(a[n - i .. n]) // a[n-i]...a[n-1] are sorted
    invariant Partitioned(a[..], n - i) // each element in a[0]...a[n-i-1] is smaller than each element in a[n-i]...a[n-1]
  {
    var j := 1;
    while j < n - i
      invariant 1 <= j <= n - i
      invariant Sorted(a[n - i .. n]) // keep invariant
      invariant Partitioned(a[..], n - i) // keep invariant
      invariant forall k :: 0 <= k < j ==> a[k] <= a[j - 1] // a[j-1] is maximal among a[0]...a[j-1]
    {
      if a[j - 1] > a[j] {
        var t := a[j - 1];
        a[j - 1] := a[j];
        a[j] := t;
      }
      j := j + 1;
    }
    i := i + 1;
  }
}

method Main()
{
  var s := [5, 1, 4, 2, 8, 0, 1 ,1, 7];
  
  // array initialization surely not optimal 
  var a := new int[|s|] (i => 0); 
  for i := 0 to |s| { a[i] := s[i]; }

  print a[..], "\n"; 
  BubbleSort(a);
  print a[..], "\n"; 
}
