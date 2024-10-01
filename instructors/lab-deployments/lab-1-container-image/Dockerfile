# Use a minimal image for the final container
FROM k8s.gcr.io/e2e-test-images/agnhost:2.43

WORKDIR /

RUN rm /localhost.*

COPY ca.crt tls.crt tls.key .

# Run the application
ENTRYPOINT ["/agnhost"]
CMD ["webhook", "--tls-cert-file", "tls.crt", "--tls-private-key-file", "tls.key"]