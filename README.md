<p align="center">
  <img alt="logo" src="https://hsto.org/webt/9d/em/q3/9demq3clqvs6k2rkivlrxqxl75o.png" width="120" height="120" />
</p>

# Docker image with [hydra][hydra]

[![Build Status][badge_build]][link_build]
[![Release Status][badge_release]][link_build]
[![Stars][badge_pulls]][link_pulls]
[![License][badge_license]][link_license]
[![Issues][badge_issues]][link_issues]

### :fire: THIS IMAGE WITH ALL INCLUDED TOOLS IS FOR LEGAL PURPOSES ONLY! :fire:

## What includes this image?

Hydra documentation can be found [here][hydra]. Quick usage help:

```
Hydra v9.1 (c) 2020 by van Hauser/THC & David Maciejak - Please do not use in military or secret service
organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Syntax: hydra [[[-l LOGIN|-L FILE] [-p PASS|-P FILE]] | [-C FILE]] [-e nsr] [-o FILE] [-t TASKS]
              [-M FILE [-T TASKS]] [-w TIME] [-W TIME] [-f] [-s PORT] [-x MIN:MAX:CHARSET] [-c TIME]
              [-ISOuvVd46] [-m MODULE_OPT] [service://server[:PORT][/OPT]]

Options:
  -R        restore a previous aborted/crashed session
  -I        ignore an existing restore file (don't wait 10 seconds)
  -S        perform an SSL connect
  -s PORT   if the service is on a different default port, define it here
  -l LOGIN or -L FILE  login with LOGIN name, or load several logins from FILE
  -p PASS  or -P FILE  try password PASS, or load several passwords from FILE
  -x MIN:MAX:CHARSET  password bruteforce generation, type "-x -h" to get help
  -y        disable use of symbols in bruteforce, see above
  -r             rainy mode for password generation (-x)
  -e nsr    try "n" null password, "s" login as pass and/or "r" reversed login
  -u        loop around users, not passwords (effective! implied with -x)
  -C FILE   colon separated "login:pass" format, instead of -L/-P options
  -M FILE   list of servers to attack, one entry per line, ':' to specify port
  -o FILE   write found login/password pairs to FILE instead of stdout
  -b FORMAT specify the format for the -o FILE: text(default), json, jsonv1
  -f / -F   exit when a login/pass pair is found (-M: -f per host, -F global)
  -t TASKS  run TASKS number of connects in parallel per target (default: 16)
  -T TASKS  run TASKS connects in parallel overall (for -M, default: 64)
  -w / -W TIME  wait time for a response (32) / between connects per thread (0)
  -c TIME   wait time per login attempt over all threads (enforces -t 1)
  -4 / -6   use IPv4 (default) / IPv6 addresses (put always in [] also in -M)
  -v / -V / -d  verbose mode / show login+pass for each attempt / debug mode
  -O        use old SSL v2 and v3
  -K        do not redo failed attempts (good for -M mass scanning)
  -q        do not print messages about connection errors
  -U        service module usage details
  -m OPT    options specific for a module, see -U output for information
  -h        more command line options (COMPLETE HELP)
  server    the target: DNS, IP or 192.168.0.0/24 (this OR the -M option)
  service   the service to crack (see below for supported protocols)
  OPT       some service modules support additional input (-U for module help)

Supported services: adam6500 asterisk cisco cisco-enable cvs ftp[s] http[s]-{head|get|post}
                    http[s]-{get|post}-form http-proxy http-proxy-urlenum icq imap[s] irc ldap2[s]
                    ldap3[-{cram|digest}md5][s] mssql mysql nntp oracle-listener oracle-sid pcanywhere
                    pcnfs pop3[s] radmin2 redis rexec rlogin rpcap rsh rtsp s7-300 sip smb smtp[s]
                    smtp-enum snmp socks5 ssh sshkey teamspeak telnet[s] vmauthd vnc xmpp

Hydra is a tool to guess/crack valid login/password pairs.
Licensed under AGPL v3.0. The newest version is always available at;
https://github.com/vanhauser-thc/thc-hydra
Please don't use in military or secret service organizations, or for illegal
purposes. (This is a wish and non-binding - most such people do not care about
laws and ethics anyway - and tell themselves they are one of the good ones.)
These services were not compiled in: afp firebird memcached mongodb ncp oracle postgres sapr3 svn smb2.

Use HYDRA_PROXY_HTTP or HYDRA_PROXY environment variables for a proxy setup.
E.g. % export HYDRA_PROXY=socks5://l:p@127.0.0.1:9150 (or: socks4:// connect://)
     % export HYDRA_PROXY=connect_and_socks_proxylist.txt  (up to 64 entries)
     % export HYDRA_PROXY_HTTP=http://login:pass@proxy:8080
     % export HYDRA_PROXY_HTTP=proxylist.txt  (up to 64 entries)

Examples:
  hydra -l user -P passlist.txt ftp://192.168.0.1
  hydra -L userlist.txt -p defaultpw imap://192.168.0.1/PLAIN
  hydra -C defaults.txt -6 pop3s://[2001:db8::1]:143/TLS:DIGEST-MD5
  hydra -l admin -p password ftp://[192.168.0.0/24]/
  hydra -L logins.txt -P pws.txt -M targets.txt ssh
```

Also this image includes collection of most popular passwords and user-names which can be found in directories:

- `/opt/passwords` - content from [github.com/danielmiessler/SecLists/tree/master/Passwords](https://github.com/danielmiessler/SecLists/tree/master/Passwords)
- `/opt/usernames` - content from [github.com/danielmiessler/SecLists/tree/master/Usernames](https://github.com/danielmiessler/SecLists/tree/master/Usernames)

### Usage example

```bash
$ docker run --rm tarampampam/hydra:9.1 \
    -L /opt/usernames/top-usernames-shortlist.txt \
    -P /opt/passwords/darkweb2017-top100.txt \
    -f -V -s \
    8080 192.168.1.1 http-get
```

> **Important notice**: by default processes in docker image will be run using **unprivileged** user. If you will have any problems with this (for example - writing something in mounted volumes will fails) you may use `docker run ... --user 0:0 ...` argument.

## Supported tags

[![image stats](https://dockeri.co/image/tarampampam/hydra)][link_docker_tags]

All supported image tags [can be found here][link_docker_tags] (images without username/password lists contains postfix `-light`).

## Releasing

New versions publishing is very simple - just "publish" new release using repo releases page. Release version can be arbitrary.

All "supported" image versions defined in [releasing scenario](./.github/workflows/release.yml).

## License

WTFPL. Use anywhere for your pleasure.

[badge_build]:https://img.shields.io/github/workflow/status/tarampampam/hydra/tests?maxAge=30&logo=github
[badge_release]:https://img.shields.io/github/workflow/status/tarampampam/hydra/release?maxAge=30&label=release&logo=github
[badge_pulls]:https://img.shields.io/docker/pulls/tarampampam/hydra.svg?style=flat&maxAge=30
[badge_license]:https://img.shields.io/github/license/tarampampam/hydra-docker.svg?style=flat&maxAge=30
[badge_issues]:https://img.shields.io/github/issues/tarampampam/hydra-docker.svg?style=flat&maxAge=30

[link_build]:https://github.com/tarampampam/hydra/actions
[link_pulls]:https://hub.docker.com/r/tarampampam/hydra/
[link_license]:https://github.com/tarampampam/hydra-docker/blob/master/LICENSE
[link_issues]:https://github.com/tarampampam/hydra-docker/issues
[link_docker_tags]:https://hub.docker.com/r/tarampampam/hydra/tags
[hydra]:https://github.com/vanhauser-thc/thc-hydra
