#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s/\${P1PORT}/$6/" \
        -e "s/\${P2PORT}/$7/" \
        -e "s/\${P3PORT}/$8/" \
        -e "s/\${P4PORT}/$9/" \
        -e "s/\${P5PORT}/${10}/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s/\${P1PORT}/$6/" \
        -e "s/\${P2PORT}/$7/" \
        -e "s/\${P3PORT}/$8/" \
        -e "s/\${P4PORT}/$9/" \
        -e "s/\${P5PORT}/${10}/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=1
P0PORT=17051
P1PORT=18051
P2PORT=19051
P3PORT=20051
P4PORT=21051
P5PORT=22051
CAPORT=7054
PEERPEM=organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org1.example.com/ca/ca.org1.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $P1PORT $P2PORT $P3PORT $P4PORT $P5PORT)">organizations/peerOrganizations/org1.example.com/connection-org1.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $P1PORT $P2PORT $P3PORT $P4PORT $P5PORT)">organizations/peerOrganizations/org1.example.com/connection-org1.yaml

ORG=2
P0PORT=27051
P1PORT=28051
P2PORT=29051
P3PORT=30051
P4PORT=31051
P5PORT=32051
CAPORT=8054
PEERPEM=organizations/peerOrganizations/org2.example.com/tlsca/tlsca.org2.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org2.example.com/ca/ca.org2.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $P1PORT $P2PORT $P3PORT $P4PORT $P5PORT)" > organizations/peerOrganizations/org2.example.com/connection-org2.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $P1PORT $P2PORT $P3PORT $P4PORT $P5PORT)" > organizations/peerOrganizations/org2.example.com/connection-org2.yaml