#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>

#define MAX 100

/****************** Client Code ******************/
int main(int argc, char *argv[]) {
    if (argc != 3) {
        perror("Please pass the remote IP/Port as arguments");
        exit(EXIT_FAILURE);
    }

    // Create an IPv4 and TCP socket
    int socket_descriptor = socket(AF_INET, SOCK_STREAM, 0);
    if (socket_descriptor < 0) {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    // Initialize address structure for connecting
    char *ip_address = argv[1];
    int port_number = atoi(argv[2]);
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(port_number);
    server_address.sin_addr.s_addr = inet_addr(ip_address);

    // Connect to the server
    int status = connect(socket_descriptor, (struct sockaddr*)&server_address, sizeof(server_address));
    if (status < 0) {
        perror("Couldn't connect with the server");
        exit(EXIT_FAILURE);
    }

    while (1) {
        // Get the command from the CLI
        printf("Please enter the command (or type 'stop' to quit): ");
        char command[MAX];
        fgets(command, sizeof(command), stdin);

        // Send command to the server
        send(socket_descriptor, command, strlen(command), 0);

        // Check for "stop" command
        if (strncmp(command, "stop", 4) == 0) {
            break;
        }

        // Receive a message from the server
        int command_return;
        recv(socket_descriptor, &command_return, sizeof(command_return), 0);
        printf("Command exit status: %d\n", ntohl(command_return));
    }

    // Close the socket connection
    close(socket_descriptor);
    return 0;
}

