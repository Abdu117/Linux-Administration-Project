# Makefile for XOR cipher module

# Directories
XOR_SRC_DIR = $(XOR_LIB_DIR)/src
XOR_INC_DIR = $(XOR_LIB_DIR)/inc

# Compiler flags for dynamic library
XOR_CFLAGS = $(CFLAGS) -fPIC

# Object files for XOR cipher
XOR_OBJ = $(GEN_DIR)/xor_encrypt.o $(GEN_DIR)/xor_decrypt.o

# Dynamic library
XOR_LIB = libxor.so

# Build the dynamic library
xor: $(XOR_OBJ)
	$(CC) $(XOR_OBJ) -o $(LIB_DIR)/$(XOR_LIB) -shared

# Compile XOR cipher source files
$(GEN_DIR)/xor_encrypt.o: $(XOR_SRC_DIR)/xor_encrypt.c
	$(CC) -c $(XOR_SRC_DIR)/xor_encrypt.c $(XOR_CFLAGS) -o $@

$(GEN_DIR)/xor_decrypt.o: $(XOR_SRC_DIR)/xor_decrypt.c
	$(CC) -c $(XOR_SRC_DIR)/xor_decrypt.c $(XOR_CFLAGS) -o $@

# Clean object files
clean:
	rm -f $(GEN_DIR)/xor_*.o $(LIB_DIR)/$(XOR_LIB)
