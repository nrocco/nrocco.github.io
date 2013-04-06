# Capture HTTP packets from/to a host with Opsview and save the output to a file:

    sudo tshark -d 'tcp.port==80,http' -f 'port 80 and host x.x.x.x' -V -P -w /tmp/opsview.status.output
