
BEGIN { version = ""; state = 0; }

state == 0 && $0 ~ /[0-9]+\.[0-9]+\.[0-9]+/ \
 {
   gsub(/[()<>]/, " ");

   split($0, ver_a, " ");

   for (i in ver_a)
   {
     if (state == 0 && ver_a[i] ~ /style_version/) { state = 1; continue; }

     if (state == 1 && ver_a[i] ~ /[0-9]+\.[0-9]+\.[0-9]+/)
     {
       version=ver_a[i]
       state = 2 # state = 2: completed version search
     }
   }

 }

END { if (state == 2) { print version; }; }
