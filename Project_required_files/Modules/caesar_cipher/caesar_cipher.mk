# Makefile for Caesar cipher module

# Directories
CAESAR_SRC_DIR = $(CAESAR_LIB_DIR)/src
CAESAR_INC_DIR = $(CAESAR_LIB_DIR)/inc

# Compiler flags
CAESAR_CFLAGS = $(CFLAGS)

# Object files for Caesar cipher
CAESAR_OBJ = $(GEN_DIR)/caesar_encrypt.o $(GEN_DIR)/caesar_decrypt.o

# Static library
CAESAR_LIB = libcaesar.a

# Build the static library
caesar: $(CAESAR_OBJ)
	ar rcs $(LIB_DIR)/$(CAESAR_LIB) $(CAESAR_OBJ)

# Compile Caesar cipher source files
$(GEN_DIR)/caesar_encrypt.o: $(CAESAR_SRC_DIR)/caesar_encrypt.c
	$(CC) -c $(CAESAR_SRC_DIR)/caesar_encrypt.c $(CAESAR_CFLAGS) -o $@

$(GEN_DIR)/caesar_decrypt.o: $(CAESAR_SRC_DIR)/caesar_decrypt.c
	$(CC) -c $(CAESAR_SRC_DIR)/caesar_decrypt.c $(CAESAR_CFLAGS) -o $@

# Clean object files
clean:
	rm -f $(GEN_DIR)/caesar_*.o $(LIB_DIR)/$(CAESAR_LIB)
