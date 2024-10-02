## Lab 1 webhook

- webhook is deployed with several issues
  1. livenes probe is failing
  2. wrong port defined in the service
  3. (bonus round) ca.cert is not trusted - ca is available in the webhook pod and can be added to the webhook configuration base64 under `caBundle`

## Lab 2 network issues

- lab-a -- connection refused

A wrong port is used by the service

- lab-b -- i/o timeout

A network policy denies traffic to the pod label

- lab-c -- connection reset by peer

A cusom app resets connections

- lab-d -- no route to host, dns failure

A firewall rule is rejecting traffic