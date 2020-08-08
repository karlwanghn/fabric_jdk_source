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
        ccp-template.json
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
        ccp-template.yaml | sed -e $'s/\\\\n/\\\n        /g'
}

ORG=3
P0PORT=37051
P1PORT=38051
P2PORT=39051
P3PORT=40051
P4PORT=41051
P5PORT=42051
CAPORT=11054
PEERPEM=../organizations/peerOrganizations/org3.example.com/tlsca/tlsca.org3.example.com-cert.pem
CAPEM=../organizations/peerOrganizations/org3.example.com/ca/ca.org3.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $P1PORT $P2PORT $P3PORT $P4PORT $P5PORT)" > ../organizations/peerOrganizations/org3.example.com/connection-org3.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $P1PORT $P2PORT $P3PORT $P4PORT $P5PORT)" > ../organizations/peerOrganizations/org3.example.com/connection-org3.yaml
