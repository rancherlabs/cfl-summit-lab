# Use the official Go image as a build stage
FROM golang:1.20 AS builder

# Set the working directory
WORKDIR /app

# Copy the Go application source code
COPY app.go .

# Build the Go application
RUN go build -o app app.go

# Use a minimal image for the final container
FROM golang:1.20 

WORKDIR /

# Copy the built application from the builder stage
COPY --from=builder /app/app .

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["/app"]