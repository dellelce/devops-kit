
BEGIN { version = ""; state = 0; }

state == 0 && $0 ~ /[0-9]+\.[0-9]+\.[0-9]+/ \
 {
   gsub(/[()<>"]/, " ");

   split($0, ver_a, " ");

   for (i = 0; i <= length(ver_a); i+=1)
   {
     if (state == 0 && ver_a[i] ~ /download/) { state = 1; continue; }
     if (state == 1 && ver_a[i] ~ /terraform/) { state = 2; continue; }

     if (state == 2 && ver_a[i] ~ /[0-9]+\.[0-9]+\.[0-9]+/)
     {
       version=ver_a[i]
       state = 3 # state = 3: completed version search
     }
   }

 }

END { if (state == 3) { sub(/^v/,"",version); print version; }; }
