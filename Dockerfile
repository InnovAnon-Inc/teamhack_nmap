FROM kalilinux/kali-rolling as build

ARG DEBIAN_FRONTEND=noninteractive

    #xinetd                                         \
#    git                                            \
#    python3-pip                                    \
#    python-is-python3                              \
#&&  git clone                                      \
#    --depth=1                                      \
#    --recursive                                    \
#    https://github.com/vulnersCom/nmap-vulners.git \
#    /usr/share/nmap/scripts/vulners                \
#&&  nmap --script-updatedb                         \
#&&  git clone                                      \
#    --depth=1                                      \
#    --recursive                                    \
#    https://github.com/danielmiessler/SecLists.git \
#    /usr/share/seclists                            \
RUN apt update                                     \
&&  apt full-upgrade -y                            \
    --no-install-recommends                        \
&&  apt install      -y                            \
    --no-install-recommends                        \
    nmap                                           \
&&  apt autoremove   -y                            \
    --purge                                        \
&&  apt clean        -y                            \
&&  rm -rf /var/lib/apt/lists/*

FROM python:latest
COPY --from=build                                  \
  /lib/x86_64-linux-gnu/libpcre.so.3               \
  /lib/x86_64-linux-gnu/libpcap.so.0.8             \
  /lib/x86_64-linux-gnu/libssh2.so.1               \
  /lib/x86_64-linux-gnu/libssl.so.3                \
  /lib/x86_64-linux-gnu/libcrypto.so.3             \
  /lib/x86_64-linux-gnu/libz.so.1                  \
  /lib/x86_64-linux-gnu/liblinear.so.4             \
  /lib/x86_64-linux-gnu/liblua5.4-lpeg.so.2        \
  /lib/x86_64-linux-gnu/liblua5.4.so.0             \
  /lib/x86_64-linux-gnu/libstdc++.so.6             \
  /lib/x86_64-linux-gnu/libm.so.6                  \
  /lib/x86_64-linux-gnu/libgcc_s.so.1              \
  /lib/x86_64-linux-gnu/libc.so.6                  \
  /lib/x86_64-linux-gnu/libdbus-1.so.3             \
  /lib/x86_64-linux-gnu/libblas.so.3               \
  /lib/x86_64-linux-gnu/libdl.so.2                 \
  /lib/x86_64-linux-gnu/libsystemd.so.0            \
  /lib/x86_64-linux-gnu/libopenblas.so.0           \
  /lib/x86_64-linux-gnu/libcap.so.2                \
  /lib/x86_64-linux-gnu/libgcrypt.so.20            \
  /lib/x86_64-linux-gnu/liblz4.so.1                \
  /lib/x86_64-linux-gnu/liblzma.so.5               \
  /lib/x86_64-linux-gnu/libzstd.so.1               \
  /lib/x86_64-linux-gnu/libgfortran.so.5           \
  /lib/x86_64-linux-gnu/libgpg-error.so.0          \
  /lib/x86_64-linux-gnu/
COPY --from=build                                  \
  /lib64/ld-linux-x86-64.so.2                      \
  /lib64/
COPY --from=build                                  \
  /usr/bin/nmap                                    \
  /usr/bin/

RUN pip install teamhack_nmap                      \
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

