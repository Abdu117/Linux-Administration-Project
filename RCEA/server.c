#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <signal.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>

#define MAX 100
#define PORT 3500

// Function to handle SIGINT
void handle_sigint(int sig) {
    printf("\nReceived SIGINT signal. Terminating server gracefully.\n");
    exit(0);
}

/****************** Server Code ******************/
int main() {
    // Handle SIGINT
    signal(SIGINT, handle_sigint);

    // Create the socket with IPv4 domain and TCP protocol
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);

    // Set options for the socket
    int option_value = 1;
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &option_value, sizeof(option_value));

    // Initializing structure elements for address
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(PORT);
    server_address.sin_addr.s_addr = INADDR_ANY;

    // Bind the socket with address/port from the sockaddr_in struct
    bind(sockfd, (struct sockaddr*)&server_address, sizeof(server_address));

    // Listen for incoming connections
    listen(sockfd, 5);
    printf("Server is listening on port %d...\n", PORT);

    while (1) {
        // Accept connection signals from the client
        struct sockaddr_in client_address;
        socklen_t client_length = sizeof(client_address);
        int client_sockfd = accept(sockfd, (struct sockaddr*)&client_address, &client_length);

        // Check if the server is accepting the signals from the client
        if (client_sockfd < 0) {
            perror("Couldn't establish connection with client");
            continue;
        }

        // Create a child process to handle the client
        if (fork() == 0) {
            close(sockfd); // Close the listening socket in the child process
            while (1) {
                // Receive data sent by the client
                char received_command[MAX];
                memset(received_command, 0, sizeof(received_command));
                int bytes_read = read(client_sockfd, received_command, sizeof(received_command));

                // Check for "stop" command
                if (strncmp(received_command, "stop", 4) == 0) {
                    printf("Stopping communication with client\n");
                    break;
                }

                // Execute the received command
                int command_return = system(received_command);
                printf("Command executed: %s\n", received_command);

                // Send command_return back to the client
                int x = htonl(command_return);
                send(client_sockfd, &x, sizeof(x), 0);
            }

            // Close the client socket
            close(client_sockfd);
            exit(0); // Exit child process
        }
        close(client_sockfd); // Close the client socket in the parent process
    }

    // Close all sockets created (not reached)
    close(sockfd);
    return 0;
}

