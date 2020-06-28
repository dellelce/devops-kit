BEGIN { state = 0 }

/latest version of Consul/ && state == 0 {
   state = 1
}

state == 1 \
{
   gsub(/[<>()]/, " ")
   line=$0

   pos = 0
   cnt = split(line, line_a)

   while (pos <= cnt)
   {
      val=line_a[pos]

      if (state == 1 && val == "latest") state = 2

      if (state == 2 && val ~ /[0-9]+\.[0-9]/)
      { 
        print val
        state = 3
      }

      pos += 1
   }
}
