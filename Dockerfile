FROM alpine:3.7

RUN apk add --no-cache curl jq

ADD ./dump_pem.sh /dump_pem.sh

RUN chmod 755 /dump_pem.sh
RUN mkdir -p /opt/certs

WORKDIR "/opt/certs"

ENTRYPOINT ["/dump_pem.sh"]