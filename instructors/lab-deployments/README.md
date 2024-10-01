## Lab 1 webhook

- webhook is deployed with several issues
  1. wrong port in service
  2. ca.cert is not trusted - ca is available in the webhook pod and can be added to the webhook configuration base64 under `caBundle`

## Lab 2 network issues

- lab-a -- connection refused
- lab-b -- i/o timeout
- lab-c -- connection reset by peer
- lab-c -- no route to host
- lab-d -- dns failure