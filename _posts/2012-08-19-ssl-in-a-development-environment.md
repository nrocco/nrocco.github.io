---
layout: post
title: SSL in a development environment
---

Using ssl certificates can be a tedious task. Especially in a development or
testing environment where you (or your company) does not want to pay for
expensive certificates.  More importantly, you do not have to pay for
certificates in a dev/test environment assuming that everyone accessing that
environment is within your control. In these cases self signed certificates
allow you to achieve the same effect as if you were using a signed
certificate. 

### Generate a self signed (root) certificate

You can use the following script to generate a ssl certificate (I took most of
the information from [here][ssl_howto]).  I saved the following code to a file
called `sslcertgen` and saved it in `/usr/local/bin` or anywhere else on my
system's `$PATH`.

    #!/bin/bash
    # Create a self signed (wildcard) certificate

    RSA_ENC=2048
    DAYS=3650

    if [[ "" == "$1" || "help" == "$1" ]]; then
      echo "Usage: $(basename $0) certificate_name"
      exit 3
    fi

    HOST="$1"
    KEY="$HOST.key"
    PEM="$HOST.pem"
    CRT="$HOST.crt"
    PFX="$HOST.pfx"

    openssl genrsa $RSA_ENC > "${KEY}"
    openssl req -new -x509 -nodes -sha1 -days ${DAYS} -extensions v3_ca -key "${KEY}" > "${CRT}"
    openssl pkcs12 -export -out ${PFX} -inkey ${KEY} -in ${CRT} -certfile ${CRT}

    cat "${CRT}" "${KEY}" > "${PEM}"

    chmod 400 "${KEY}" "${PEM}" "${PFX}"
    chmod 644 "${CRT}"


Now I can use this script to create a wildcard certificate for e.g.
`www.mywebsite.com` like this:

    # Generate a certificate named mywebsite
    $ sslcertgen mywebsite
    # ...[enter www.mywebsite.com as the Common Name]...

> If you use `*.mywebsite.com` as the common name you will create a self
> signed wild card certificate.

This will producte the files: 

- `mywebsite.crt` contains the public version of this ssl key. This is what
  you install on clients;
- `mywebsite.key` contains the private version of this ssl certificate. You
  keep this private and use this on the server;
- `mywebsite.pem` contains the private and public key concatenaded together.
  This is often used by apache.
- `mywebsite.pfx` contains the private and public key in a format compatible
  for IIS based servers.

From the above files the most important (and the only two essentials ones) are
the .crt and the .key file.  If you need to convert the sertificate to other
formats, read [this article][ssl_convert]


### Server: Install the SSL certificate on the server

Place the .crt and the .key files somewhere where your nginx application can
access them. *For enhanced security make sure that the .key file has only read
permissions for the user that nginx is running as*.  Now that we have
generated an ssl certificate we can 'install' it on the server. There are many
different ways to do this and it really depends on the application you are
using. In the below example I will show you how to configure nginx:

    server {
      listen       443;
      server_name  www.mywebsite.com

      ssl                  on;
      ssl_certificate      /etc/server_certs/mywebsite.crt;
      ssl_certificate_key  /etc/server_certs/mywebsite.key;

      location / {
          ...
      }
    }

Restart nginx using `sudo service nginx restart` on Debian based
distributions.  Now when you visit `www.mywebsite.com` you will get a
certificate warning. The reason for this is simple. We created a self signed
certificate. It was not signed by a central authority. Because of this clients
are not able to tell if they can trust this certificate or not.  To make sure
that clients trust the connection we have to explicitly tell them that it is
trustable by adding the .crt version of the certificate to the local
certificate store.

I will explain how to do this on Debian based systems in the next part.


### Client: Install a self signed SSL (root) certificate on a Unix client

So the server is set up and accessible using an ssl connection. To tell the
client that the self signed certificate from the server is trustable we will
download the public version and 'install' it locally.

First download the certificate from the server:

    # Download a SSL certificate from a remote host
    $ openssl s_client -connect www.mywebsite.com:443 -showcerts < /dev/null 2> /dev/null | sed -n '/BEGIN CERTIFICATE/,/END CERTIFICATE/p' > mywebsite.crt

Or copy the .crt file we generated earlier with ssh to the client.
Now that we have the public version available we can 'install' it.

    # Copy the certificate to the ca-certifactes directory
    cp mywebsite.crt /usr/share/ca-certificates
    chmod 644 /usr/share/ca-certificates/certificate.crt

Edit this file and add mywebsite.crt on a blank line to the end

    # Note that the path is relative to the directory /usr/share/ca-certificates
    $ vim /etc/ca-certificates.conf

Now update the certificate database

    # Update the local CA certificate database
    update-ca-certificates

That's it. now we told the client to trust this self signed certificate by
installing it locally.

    # Test if it works now
    wget -O- "https://www.mywebsite.com/"

    # Testing if SSL works
    openssl s_client -connect www.mywebsite.com:443 -state -debug < /dev/null


### Server: Install .pfx certificate in IIS 6.0 on Windows Server 2003

The following walkthrough describes how to add a .pfx formatted self signed
certificate to an IIS application on Windows 2003.  Look for more information
about viewing certificates with the Snap-In tool [here][msdn_snapin].

    # Go to 'Start' -> 'Run' and type: mmc <enter>
    # Go to 'File' -> 'Add/Remove Snap-in'
    # Click 'Add'
    # Select 'Certificates'
    # Click 'Add', Click 'Close', Click 'Ok'
    # Right click 'Trusted Root Certification Authorities' -> 'All Tasks' -> 'Import'
    # Import the created .pfx certificate
    # Next -> Next -> Next -> Ok
    # Copy the certificate from 'Trusted Root...' to 'Personal' folder.
    # Close mmc
    # Configure IIS 6.0 to use server ssl certificate
    # Restart IIS


[ssl_howto]: http://www.justinsamuel.com/2006/03/11/howto-create-a-self-signed-wildcard-ssl-certificate/
[ssl_convert]: https://www.sslshopper.com/ssl-converter.html
[msdn_snapin]: http://msdn.microsoft.com/en-us/library/ms788967.aspx
