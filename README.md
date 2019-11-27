<p align="center">
  <img alt="logo" src="https://hsto.org/webt/9d/em/q3/9demq3clqvs6k2rkivlrxqxl75o.png" width="120" height="120" />
</p>

# Docker image with [hydra][hydra]

[![Build][badge_build]][link_build]
[![Stars][badge_pulls]][link_pulls]
[![License][badge_license]][link_license]
[![Issues][badge_issues]][link_issues]

#### :fire: THIS IMAGE WITH INCLUDED TOOLS IS FOR LEGAL PURPOSES ONLY!

### How can I use this?

Hydra documentation can be found [here][hydra]. Quick usage help:

```
Hydra v9.0 (c) 2019 by van Hauser/THC - Please do not use in military or secret service organizations, 
or for illegal purposes.

Syntax: hydra [[[-l LOGIN|-L FILE] [-p PASS|-P FILE]] | [-C FILE]] [-e nsr] [-o FILE] [-t TASKS] 
  [-M FILE [-T TASKS]] [-w TIME] [-W TIME] [-f] [-s PORT] [-x MIN:MAX:CHARSET] [-c TIME] [-ISOuvVd46] 
  [service://server[:PORT][/OPT]]

Options:
  -l LOGIN or -L FILE  login with LOGIN name, or load several logins from FILE
  -p PASS  or -P FILE  try password PASS, or load several passwords from FILE
  -C FILE   colon separated "login:pass" format, instead of -L/-P options
  -M FILE   list of servers to attack, one entry per line, ':' to specify port
  -t TASKS  run TASKS number of connects in parallel per target (default: 16)
  -U        service module usage details
  -h        more command line options (COMPLETE HELP)
  server    the target: DNS, IP or 192.168.0.0/24 (this OR the -M option)
  service   the service to crack (see below for supported protocols)
  OPT       some service modules support additional input (-U for module help)

Supported services: adam6500 asterisk cisco cisco-enable cvs ftp[s] http[s]-{head|get|post} 
  http[s]-{get|post}-form http-proxy http-proxy-urlenum icq imap[s] irc ldap2[s] 
  ldap3[-{cram|digest}md5][s] mssql mysql nntp oracle-listener oracle-sid pcanywhere 
  pcnfs pop3[s] radmin2 redis rexec rlogin rpcap rsh rtsp s7-300 sip smb smtp[s] 
  smtp-enum snmp socks5 ssh sshkey teamspeak telnet[s] vmauthd vnc xmpp

Hydra is a tool to guess/crack valid login/password pairs. Licensed under AGPL
v3.0. The newest version is always available at https://github.com/vanhauser-thc/thc-hydra
Don't use in military or secret service organizations, or for illegal purposes.

Example:  hydra -l user -P passlist.txt ftp://192.168.0.1
```

Also this image includes collection of most popular passwords and user-names which can be found in directories:

- `/opt/password` - content from [github.com/danielmiessler/SecLists/tree/master/Passwords](https://github.com/danielmiessler/SecLists/tree/master/Passwords)
- `/opt/usernames` - content from [github.com/danielmiessler/SecLists/tree/master/Usernames](https://github.com/danielmiessler/SecLists/tree/master/Usernames)

### Usage example

```bash
$ docker run --rm tarampampam/hydra \
    -L /opt/usernames/top-usernames-shortlist.txt \
    -P /opt/password/darkweb2017-top100.txt \
    -f -V -s \
    8080 192.168.1.1 http-get
```

#### License

MIT. Use anywhere for your pleasure.

[badge_build]:https://img.shields.io/docker/build/tarampampam/hydra.svg?style=flat&maxAge=30
[badge_pulls]:https://img.shields.io/docker/pulls/tarampampam/hydra.svg?style=flat&maxAge=30
[badge_license]:https://img.shields.io/github/license/tarampampam/hydra-docker.svg?style=flat&maxAge=30
[badge_issues]:https://img.shields.io/github/issues/tarampampam/hydra-docker.svg?style=flat&maxAge=30
[link_build]:https://hub.docker.com/r/tarampampam/hydra/builds/
[link_pulls]:https://hub.docker.com/r/tarampampam/hydra/
[link_license]:https://github.com/tarampampam/hydra-docker/blob/master/LICENSE
[link_issues]:https://github.com/tarampampam/hydra-docker/issues
[docker_hub]:https://hub.docker.com/r/tarampampam/hydra-docker/
[hydra]:https://github.com/vanhauser-thc/thc-hydra
[livereload]:https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei
