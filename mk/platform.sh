#!/bin/sh

[ $(uname -s) == "Linux" ] &&
{
  echo "linux-amd64"
  exit 0
}

[ $(uname -s) == "Darwin" ] &&
{
  echo "darwin-amd64"
  exit 0
}


echo "unsupported"
