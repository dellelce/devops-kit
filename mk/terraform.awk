
BEGIN { version = ""; }

version == "" && $0 ~ /[0-9]+\.[0-9]+\.[0-9]+/ \
 {
   gsub(/[()<>"]/, " ");

   cnt = split($0, ver_a, " ");

   for (i = 0; i <= cnt; i+=1)
   {
     if (ver_a[i] ~ /[0-9]+\.[0-9]+\.[0-9]+/ && version=="")
     {
       proposed_version=ver_a[i]
     }

     if (ver_a[i] == "latest" && proposed_version != "")
     {
       version = proposed_version
     }
   }
 }

END { if (version != "") { sub(/^v/,"",version); print version; }; }
