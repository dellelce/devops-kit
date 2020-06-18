BEGIN \
{
 state = 0;
 matchstr="available downloads for the latest version of"
}

$0 ~ matchstr && state == 0 {
   state = 1
}

state == 1 \
{
   gsub(/[()]/, " ")
   gsub(/>/, "<")
   line=$0

   split(line, line_a, "<")

   for (i in line_a)
   {
      val=line_a[i]

      if (val ~ matchstr)
      {
         split(val, vers_a, " ")

         for (i_vers in vers_a)
         {
            val_vers = vers_a[i_vers]

            if (val_vers ~ /[0-9]+\.[0-9]/)
            {
               print val_vers
               state = 3
            }
         }
      }
   }
}
