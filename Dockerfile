FROM kalilinux/kali-rolling as build

ARG DEBIAN_FRONTEND=noninteractive

#RUN apt update                     \
#&&  apt full-upgrade -y            \
#    --no-install-recommends        \
#&&  apt install      -y            \
#    --no-install-recommends        \
#    git                            \
#    nmap                           \
#&&  apt autoremove   -y            \
#    --purge                        \
#&&  apt clean        -y            \
#&&  rm -rf /var/lib/apt/lists/*
#
#RUN test -d /usr/share/nmap/scripts                \
#&&  git clone                                      \
#    --depth=0                                      \
#    --recursive                                    \
#    https://github.com/vulnersCom/nmap-vulners.git \
#    /usr/share/nmap/scripts/vulners                \
#
#FROM kalilinux/kali-rolling as final
#
#RUN apt update                     \
#&&  apt full-upgrade -y            \
#    --no-install-recommends        \
#&&  apt install      -y            \
#    --no-install-recommends        \
#    metasploit-framework           \
#    xinetd                         \
#&&  apt autoremove   -y            \
#    --purge                        \
#&&  apt clean        -y            \
#&&  rm -rf /var/lib/apt/lists/*
#
#COPY --from=build                  \
#   /usr/share/nmap/scripts/vulners \
#   /usr/share/nmap/scripts/vulners
#RUN nmap --script-updatedb
#
#RUN adduser --system msf-user
#
## /etc/xinetd.d/xinetd
#VOLUME ["/etc/xinetd.d"]
#
#EXPOSE 3632/tcp \
#       3633/tcp
#
#HEALTHCHECK --interval=5m          \
#            --timeout=3s           \
#CMD         curl -f                \
#            http://0.0.0.0:3633/   \
#||          exit 1

RUN apt update                     \
&&  apt full-upgrade -y            \
    --no-install-recommends        \
&&  apt install      -y            \
    --no-install-recommends        \
    git                            \
    metasploit-framework           \
    xinetd                         \
&&  apt autoremove   -y            \
    --purge                        \
&&  apt clean        -y            \
&&  rm -rf /var/lib/apt/lists/*

RUN test -d /usr/share/nmap/scripts                \
&&  git clone                                      \
    --depth=1                                      \
    --recursive                                    \
    https://github.com/vulnersCom/nmap-vulners.git \
    /usr/share/nmap/scripts/vulners                \
&&  nmap --script-updatedb                         \
&&  git clone                                      \
    --depth=1                                      \
    --recursive                                    \
    https://github.com/danielmiessler/SecLists.git \
    /usr/share/seclists

RUN adduser --system msf-user

# /etc/xinetd.d/xinetd
VOLUME ["/etc/xinetd.d"]

EXPOSE 6616/tcp

#HEALTHCHECK --interval=5m          \
#            --timeout=3s           \
#CMD         curl -f                \
#            http://0.0.0.0:3633/   \
#||          exit 1

