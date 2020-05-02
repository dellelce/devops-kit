BEGIN { state = 0 }

/latest version/ && state == 0 {
   state = 1
}

state == 1 \
{
   gsub(/[()]/, " ")
   line=$0

   split(line, line_a)

   for (i in line_a)
   {
      val=line_a[i]

      if (val ~ /[0-9]+\.[0-9]/)
      { 
        print val
        state = 3
      }
   }
}
