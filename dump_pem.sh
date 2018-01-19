#!/bin/sh

echo "Creating ${CERT_NAME}.pem\n"
RES=`curl -s -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" -X Get -H 'Accept: application/json' -H 'Content-Type: application/json' "${CATTLE_URL}/../v2-beta/certificates?name=${CERT_NAME}"`
echo ${RES} | jq -r .data[0].key > ${CERT_NAME}.pem && echo ${RES} | jq -r .data[0].cert >> ${CERT_NAME}.pem
echo "Created ${CERT_NAME}.pem\n"

sleep 3600
