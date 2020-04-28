#
# github.latest.awk
#
# 280718 Created: meant to be a generic filter for github
#
# this awk filter comes from my srcget project:
#          https://github.com/dellelce/srcget 
#

### MAIN RULE ###

BEGIN \
{
  state = 0
  vers = ""
  opt_nonmatch=ENVIRON["opt_nonmatch"]
  if (ext=="") ext="tar.gz"
}

# custom rules

state == 1 { next } # found our "release" skip everything else

# try to filter out "Pre-release"s; this needs to introduce "multi-page" github traversal
/Pre-release/ \
{
  state = 2
  next
}

state == 2 && /Latest release/ \
{
  state = 0
  next
}

opt_nonmatch != "" && $0 ~ opt_nonmatch { next; }

state == 0 && $0 ~ ext && $0 ~ /[0-9]\./ && /\/archive\// && $0 !~ /-windows/ && $0 !~ /-dev/ && vers == "" \
{
  line=$0
  gsub(/"/, " ", line);
  cnt = split(line, line_a, " ");

  for (idx in line_a)
  {
    item = line_a[idx]

    if (item ~ ext)
    {
      vers = item

      if (vers ~ /-alpha/)
      {
        vers = ""
        next
      }

      if (vers ~ /-rc/ || vers ~ /RC/)
      {
        vers = ""
        next
      }

      if (vers ~ /beta/)
      {
        vers = ""
        next
      }

      cnt = split (vers, vers_a, "/");

      vers = vers_a[cnt]
      state = 1; next
    }
  }
}

### END RULE ###

END \
{
  sub(/^v/, "", vers)
  sub("."ext, "", vers)
  print vers
}

### EOF ###
