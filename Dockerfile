FROM python:latest

#COPY ./dist/         \
#  /tmp/dist/
#
#RUN pip install      \
#  /tmp/dist/*.whl    \
#&& rm -frv           \
#  /tmp/dist/
RUN pip install import_db

WORKDIR  /var/teamhack
VOLUME ["/var/teamhack"]

ENTRYPOINT [         \
  "/usr/bin/env",    \
  "python",          \
  "-m",              \
  "import_db",       \
]
  #"-f"               \

EXPOSE 65432/tcp

