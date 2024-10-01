import socket
import struct

HOST = '0.0.0.0'  # Listen on all interfaces
PORT = 8080  # Change this to the desired port

def main():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
        server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_LINGER, struct.pack('ii', 1, 0))
        server_socket.set_inheritable(True)
        server_socket.bind((HOST, PORT))
        server_socket.listen()
        print("Server listening on ", HOST, " ", PORT)

        while True:
            conn, addr = server_socket.accept()
            print("Connection from ", addr, " established")
            # Immediately close the connection to simulate RST
            conn.close()

if __name__ == '__main__':
    main()