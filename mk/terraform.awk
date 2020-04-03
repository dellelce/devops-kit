BEGIN { state = 0; }

state == 0 && tolower($0) ~ /latest version/ { state = 1; }

state == 1 && $0 ~ /[0-9]+\.[0-9]+\.[0-9]+/ \
 {
   gsub(/[()]/, " ");

   split($0, ver_a, " ");

   for (i in ver_a)
   {
     if (ver_a[i] ~ /[0-9]+\.[0-9]+\.[0-9]+/)
     {
       print ver_a[i]
     }
   }

   state = 2
 }

