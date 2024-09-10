# Top-level Makefile

# Directories
CAESAR_LIB_DIR = ../Modules/caesar_cipher
XOR_LIB_DIR = ../Modules/xor_cipher
GEN_DIR = ./out/gen
LIB_DIR = ./out/libs

# Compiler
CC = gcc
CFLAGS = -I$(CAESAR_LIB_DIR)/inc -I$(XOR_LIB_DIR)/inc

# Object file for main application
OBJ = $(GEN_DIR)/app.o

# Static and dynamic libraries
CAESAR_LIB = $(LIB_DIR)/libcaesar.a
XOR_LIB = $(LIB_DIR)/libxor.so

# Include module makefiles
include $(CAESAR_LIB_DIR)/caesar_cipher.mk
include $(XOR_LIB_DIR)/xor_cipher.mk

# Default target to build everything
all: $(OBJ) caesar xor
	$(CC) $(OBJ) -L$(LIB_DIR) -lcaesar -lxor $(CFLAGS) -o out/output -Wl,-rpath,$(LIB_DIR)

# Compile the main application
$(GEN_DIR)/app.o: app.c
	$(CC) -c app.c $(CFLAGS) -o $@

# Clean all generated files and directories
clean:
	rm -f $(GEN_DIR)/*.o $(LIB_DIR)/* out/output
	$(MAKE) -C $(CAESAR_LIB_DIR) clean
	$(MAKE) -C $(XOR_LIB_DIR) clean
