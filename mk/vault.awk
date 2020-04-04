BEGIN { state = 0 }

/latest version/ && state == 0 {
   gsub(/[()]/, " ")
   line=$0

   split(line, line_a)

   for (i in line_a)
   {
      val=line_a[i]

      if (state == 0 && val == "latest") { state = 1; continue; }
      if (state == 1 && val == "version") { state = 2; continue; }


      if (state == 2 && val ~ /[0-9]+\.[0-9]/)
      { 
        print val
        state = 3
      }
   }
}
