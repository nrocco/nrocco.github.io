---
layout: post
title: Self Signed SSL Certificate Chains
comments: true
---

In a previous [post][ssl_dev_env] I talked about using SSL in a development
environment and how to generate self signed root certificates that you can
install on clients and servers to allow for trusted communication between
systems.

Instead of using a root certificate for you application; this post explains
why it is better to create a certificate chain containing.


<!-- more -->

## Generate a self signed root ssl certificate

First generate a root certificate. This certificate will be used to sign other
certificates. 

    # When asked for Common Name fill in something 
    # like 'My Dev Certificate Authority'
    $ openssl req -new -x509 -extensions v3_ca -keyout ca.key \
        -out ca.crt -days 3650


You will have to answer some questions and hit enter a few times. If
succesfull you will now have two files; a `ca.key` containing the private key
that is encrypted using the passphrase you entered and `ca.crt` containing the
public key of this root certificate.

Keep the private key in a very safe place. You will not install this file
anywhere. You will only need it to sign subsequent certificates. 

Because we are creating self signed certificates every client needs to
manually trust the root certificate. You do this by installing/importing the
.crt version of this certificate. How to import a certificate depends where
you want to import it. On Windows based systems you use the [MMC tool][mmc].
On Mac OSX you can double click on the .crt file to import it into your
keychain. For unix based systems see my previous posts on ssl certificates
[here][ssl_dev_env].

Once a client trusts this root certificate, it will automatically trust every
other certificate that was signed using this root certificate.


## Generate a ssl certificate for your application

Let's assume you are working on an application `myapp.example.com` and you
need to have it available over SSL. We will create a certificate for the
common name `myapp.example.com` and we will sign it using the previously
created root ssl certificate. 
Since you already installed this root certificate on your clients (e.g. your
iphone mac, windows pc at work) you can immediatly start browsing your
application without getting those nasty red warning messages in your browser.

First create a private key for this certificate (you will need this later when
you setup apache/nginx or whatever you use)

    $ openssl genrsa -out certificate.key 1024


Now create a certificate signing request using the generated private key

    $ openssl req -new -key certificate.key -out certificate.csr


The last step is important; now you will need to create the public certificate
using the root certificate from step (1). 
The certificate for `myapp.example.com` is created using the signing request
file `certificate.scr`, the certificate of the root Certificate Authority
`ca.crt` and the private key of the root Certificate Authority `ca.key`.

    $ openssl x509 -req -days 365 -in certificate.csr -CA ca.crt \
        -CAkey ca.key -set_serial 01 -out certificate.crt
    $ rm certificate.csr


When you are done with this step you can remove the signing request file.
That's it. Now you have a `certificate.key` and a `certificate.crt` file, and
together with the certificate of the Central Authority `ca.crt` you are able
to setup SSL in e.g. apache or nginx.
    

## See Certificate chain of a website

Use the following command to see all the Certificates:

    $ openssl s_client -showcerts \
        -connect example.org:443 < /dev/null 2> /dev/null | \
        sed -n '/BEGIN/,/END/p'


[mmc]: http://en.wikipedia.org/wiki/Microsoft_Management_Console
[ssl_dev_env]: http://casadirocco.nl/2012/08/19/ssl-in-a-development-environment.html
