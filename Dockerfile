FROM kalilinux/kali-rolling as build

ARG DEBIAN_FRONTEND=noninteractive

    #xinetd                                         \
RUN apt update                                     \
&&  apt full-upgrade -y                            \
    --no-install-recommends                        \
&&  apt install      -y                            \
    --no-install-recommends                        \
    git                                            \
    nmap                                           \
    python3-pip                                    \
    python-is-python3                              \
&&  apt autoremove   -y                            \
    --purge                                        \
&&  apt clean        -y                            \
&&  rm -rf /var/lib/apt/lists/*                    \
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
    /usr/share/seclists                            \
&&  pip install teamhack_nmap                      \
&&  test -x /usr/bin/env                           \
&&  command -v python

#RUN adduser --system msf-user

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

