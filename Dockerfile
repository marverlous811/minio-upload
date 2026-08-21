FROM alpine/curl:8.2.1
LABEL authors="Vladimir <opa_oz> Levin"

RUN curl -fSL --retry 3 https://dl.min.io/client/mc/release/linux-amd64/mc \
  --create-dirs \
  -o /minio-binaries/mc \
  && chmod +x /minio-binaries/mc \
  && [ "$(od -An -tx1 -N4 /minio-binaries/mc | tr -d ' ')" = "7f454c46" ]

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]