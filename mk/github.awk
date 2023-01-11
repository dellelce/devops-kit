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

state == 2 && /Latest/ \
{
  state = 0
  next
}

opt_nonmatch != "" && $0 ~ opt_nonmatch { next; }

# "new" style
state == 0 && /Link--primary/ \
{
  line=$0
  gsub(/"/, " ", line);
  gsub(/[<>]/, " ", line);
  cnt = split(line, line_a, " ");

  for (idx in line_a)
  {
    item = line_a[idx]

    if (item  ~ /[0-9]\./ && item ~ /\/tag/)
    {
      item_cnt = split(item, item_a, "/")

      cand_vers = item_a[item_cnt]
      sub(/^v/, "", cand_vers)

      if (cand_vers ~ /-rc/ || cand_vers ~ /beta/ || cand_vers ~ /alpha/)
      {
         continue
      }

      if (cand_vers  ~ /[0-9]\./)
      {
         if (cand_vers ~ /-/)
         {
             split(cand_vers, cv_a, "-")
             cand_vers = cv_a[2]
         }

         # candidate version passed checks
         vers = cand_vers
         state = 1
      }
    }
 }
}

# "old" style
state == 0 && $0 ~ ext && $0 ~ /[0-9]\./ && /\/archive\// && $0 !~ /-windows/ && $0 !~ /-dev/ && vers == "" \
{
  line=$0
  gsub(/"/, " ", line);
  gsub(/[<>]/, " ", line);
  cnt = split(line, line_a, " ");

  for (idx in line_a)
  {
    item = line_a[idx]

    if (cnt == 8 && /systemd/)
    {
      next
    }

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
