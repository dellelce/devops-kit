
BEGIN { version = ""; state = 0; }

state == 0 && /latest/ && $0 ~ /[0-9]+\.[0-9]+\.[0-9]+/ \
 {
   gsub(/[()<>"]/, " ");

   split($0, ver_a, " ");

   for (i = 0; i <= length(ver_a); i+=1)
   {
     if (state == 0 && ver_a[i] ~ /update/) { state = 1; continue; }

     if (state == 1 && ver_a[i] ~ /[0-9]+\.[0-9]+\.[0-9]+/)
     {
       version=ver_a[i]
       state = 2
     }
   }

 }

END { if (state == 2) { sub(/^v/, "", version); print version; }; }
