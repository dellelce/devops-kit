BEGIN { state = 0; }

state == 0 && /Linux 64-bit/ { state = 1; }

state == 1 && /[0-9]+\.[0-9]+/ \
{
  l = $0
  gsub(/[<>-]/, " ", l);
  split(l, l_a)

  for (idx in l_a)
  {
    v = l_a[idx]

    if (v ~ /[0-9]+\.[0-9]+/)
    {
      print v
      state = 2
      next
    }
  }
}
