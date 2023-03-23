# Generate CA key:
openssl genrsa -des3 -out ca.key 4096

# Generate CA certificate:
openssl req -new -x509 -days 1024 -key ca.key -subj "/C=US/ST=CA/O=MyOrg/CN=myOrgCA" -nodes -out ca.crt

# Generate server key:
openssl genrsa -des3 -out server.key 2048

# Generate server signing request:
openssl req -new -key server.key -subj "/C=US/ST=CA/O=MyOrg/CN=myOrgCA" -addext "subjectAltName=DNS:example.com,DNS:example.net,DNS:otel_collector,DNS:localhost" -nodes -out server.csr

# Self-sign server certificate:
openssl x509 -req -days 365 -in server.csr -extfile extfile.cnf -CA ca.crt -CAkey ca.key -out server.crt

# Remove passphrase from the server key:
openssl rsa -in server.key -out server.key

# Generate client key:
openssl genrsa -des3 -out client.key 2048

# Generate client signing request:
openssl req -new -key client.key -subj "/C=US/ST=CA/O=MyOrg/CN=myOrgCA" -addext "subjectAltName=DNS:example.com,DNS:example.net,DNS:otel_collector,DNS:localhost" -nodes -out client.csr

# Self-sign client certificate:
openssl x509 -req -days 365 -in client.csr -extfile extfile.cnf -CA ca.crt -CAkey ca.key -out client.crt

# Remove passphrase from the client key:
openssl rsa -in client.key -out client.key


chmod 666 client.crt client.key server.crt server.key ca.crt
rm -rf *.csr
rm -rf *.srl