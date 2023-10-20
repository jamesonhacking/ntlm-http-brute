# ntlm-http-brute
NTLM over HTTP password spraying tool

This is a crude tool for password spraying NTLM over HTTP. Currently it doesn't know how to handle dropped connections so be aware of that.

Syntax: ntlm-http-brute.sh \<URL> \<threads> \<username-input-file> \<toggle prepend username off or on with 0 or 1 respectively> \<password>  

Example: ntlm-http-brute.sh https://example.com/page-that-prompts-for-ntlm-auth 8 list-of-usernames.txt 0 Password123

Tested on Kali Linux 2023.3

This tool requires parallel: apt install parallel

If you want the first letter or letters of each username in your username file capitalized for use with the prepend option, try this:

cat usernames-test.txt | tr [:upper:] [:lower:] | sed -e 's/^./\U&/' > usernames-new.txt # John 

cat usernames-test.txt | tr [:upper:] [:lower:] | sed -e 's/^../\U&/' > usernames-new.txt # JDoe  

cat usernames-test.txt | tr [:upper:] [:lower:] | sed -e 's/^.../\U&/' > usernames-new.txt # JMDoe
