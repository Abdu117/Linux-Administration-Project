# Linux Administration Project

## Overview
This project demonstrates Linux administration skills through three key parts:
1. **Bash Scripting**: Automating user and group management, and file operations.
2. **Makefiles**: Building and linking cryptographic algorithm modules (Caesar cipher and XOR cipher).
3. **Process Management**: Developing an Enhanced Remote Command Execution Application (ERCEA) using a client-server architecture.

---

## Part 1: Bash Scripting

### Script 1: `userdef`
This script automates the creation of a new user, a new group, and assigns the user to that group. The script takes three arguments: `username`, `userpass`, and `groupname`. 

### Features:
- Validates input arguments and checks for `sudo` permissions.
- Creates a user and group with specific requirements:
  - Custom user ID (UID 1600).
  - Primary group as the newly created group with ID 200.
- Assigns a password without prompting the user.
- Displays user and group information before and after modifications.
- Global reachability of the script with two methods for implementation.

### Script 2: File & Directory Operations
This script creates a directory, generates files, archives them, and transfers them to the home directory of the newly created user. After extraction, various file operations are performed.

### Features:
- Removes an existing directory if it exists, and creates a new one.
- Generates `.c` and `.h` files, writes content into them, and archives the directory.
- Copies the archive to the new user’s home directory and extracts it there.
- Provides additional commands to switch to the new user, change ownership of files, and perform search and deletion operations within the extracted files.

---

## Part 2: Makefiles 

This part involves creating two cryptographic modules (Caesar cipher and XOR cipher), each producing its own library. The Makefiles files are used to manage the build process.

### Features:
- **Makefiles**:
  - `caeser_cipher.mk`: Generates a static library.
  - `xor_cipher.mk`: Generates a dynamic library.
  - Main `Makefile`: Manages the final executable `output`.
  - Clean target to delete generated files and directories.
    ```
    Expected output:
    ```bash
    text encrypted with caesar: ddd
    text decrypted with caesar: aaa
    text encrypted with xor: ***
    text decrypted with xor: aaa
    ```

---

## Part 3: Process Management (ERCEA)

The Enhanced Remote Command Execution Application (ERCEA) implements a client-server architecture where the server executes commands received from multiple clients simultaneously.

### Features:
- **Client**:
  - Connects to the server via TCP.
  - Sends user-inputted commands to the server for execution.
  - Prints the exit status of each command received from the server.
  - Sends "stop" to terminate the connection.
- **Server**:
  - Handles multiple client connections using child processes.
  - Executes commands received from clients and sends back the exit status.
  - Gracefully handles SIGINT signal for termination.

### Scenario:
- Two clients connect to the server, send commands such as `mkdir`, `touch`, and custom commands, and receive the exit status for each. The server handles the SIGINT signal when terminated using `Ctrl+C`.

---


## How to Run

1. **Part 1**:
   - Run the `userdef` script using:
     ```bash
     sudo ./userdef <username> <userpass> <groupname>
     ```
   - Execute the file operation script similarly.
   
2. **Part 2**:
   - For Makefiles:
     ```bash
     make all
     ./output 3 K "aaa"
     ```
     
3. **Part 3**:
   - Compile `client.c` and `server.c` using a C compiler.
   - Run the server:
     ```bash
     ./server <port>
     ```
   - Run the client in another terminal:
     ```bash
     ./client <server_ip> <port>
     ```

---

## Notes
This project emphasizes practical Linux system administration skills using Bash scripting, C/C++ development with Makefiles and CMake, and process management using TCP communication.
