FROM kalilinux/kali-rolling as build

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update                     \
&&  apt full-upgrade -y            \
    --no-install-recommends        \
&&  apt install      -y            \
    --no-install-recommends        \
    git                            \
    nmap                           \
    python3-pip                    \
    python-is-python3              \
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

RUN pip install teamhack_nmap

#RUN adduser --system msf-user

RUN test -x /usr/bin/env
ENTRYPOINT [         \
  "/usr/bin/env",    \
  "python",          \
  "-m",              \
  "teamhack_nmap"    \
]

EXPOSE 55432/tcp

#HEALTHCHECK --interval=5m          \
#            --timeout=3s           \
#CMD         curl -f                \
#            http://0.0.0.0:3633/   \
#||          exit 1

