# ntlm-http-brute
NTLM over HTTP password spraying tool

Syntax:
ntlm-http-brute.sh \<URL> \<threads> \<username-input-file> \<password>

Example:
ntlm-http-brute.sh https://example.com/page-that-prompts-for-ntlm-auth 12 list-of-usernames.txt Password123

This tool requires parallel be installed

Tested on Kali Linux 2023.3
