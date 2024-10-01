package main

import (
	"fmt"
	"net"
	"os"
)

func main() {
	port := "8080" // Change this to your desired port
	address := fmt.Sprintf(":%s", port)

	// Listen for incoming connections
	listener, err := net.Listen("tcp", address)
	if err != nil {
		fmt.Println("Error starting server:", err)
		os.Exit(1)
	}
	defer listener.Close()

	fmt.Printf("Listening on port %s\n", port)

	for {
		// Accept incoming connections
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println("Error accepting connection:", err)
			continue
		}

		// Log the connection and immediately close it
		fmt.Printf("Connection from %s\n", conn.RemoteAddr())
		// Closing the connection immediately sends a TCP RST
		conn.Close()
	}
}