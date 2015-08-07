CC=g++ -O3
OBJ_LINK= -fPIC -Wall -c
SHR_LINK = -shared
LIB=simplesocket++
LIBNAME=lib$(LIB)
SRC_DIR=src
LIB_DIR=lib
BIN_DIR=bin
INC_DIR=include
RM=rm -f
CP=cp -rf
LINK=ln -s
CLIENT=ClientSocket
SERVER=ServerSocket
SOCKET=Socket
CLIENTAPP=simple_client_main
SERVERAPP=simple_server_main
TARGET=/usr

default: lib bin

all: lib bin install

install:
	$(CP) $(LIB_DIR)/$(LIBNAME).so.0.0 $(TARGET)/lib/
	$(CP) $(LIB_DIR)/$(LIBNAME).so.0 $(TARGET)/lib/
	$(CP) $(LIB_DIR)/$(LIBNAME).so $(TARGET)/lib/
	$(CP) $(INC_DIR)/$(CLIENT).h $(TARGET)/include/
	$(CP) $(INC_DIR)/$(SERVER).h $(TARGET)/include/
	$(CP) $(INC_DIR)/$(SOCKET).h $(TARGET)/include/
#	$(CP) $(BIN_DIR)/$(CLIENTAPP) $(TARGET)/bin/
#	$(CP) $(BIN_DIR)/$(SERVERAPP) $(TARGET)/bin/

uninstall:
	$(RM) $(TARGET)/lib/$(LIBNAME).so.0.0
	$(RM) $(TARGET)/lib/$(LIBNAME).so.0
	$(RM) $(TARGET)/lib/$(LIBNAME).so
	$(RM) $(TARGET)/include/$(CLIENT)
	$(RM) $(TARGET)/include/$(SERVER)
	$(RM) $(TARGET)/include/$(SOCKET)
#	$(RM) $(TARGET)/bin/$(CLIENTAPP)
#	$(RM) $(TARGET)/bin/$(SERVERAPP)

lib_dir:
	mkdir -p $(LIB_DIR)

bin_dir:
	mkdir -p $(BIN_DIR)

lib: $(LIB_DIR)/$(LIBNAME).so

bin: $(BIN_DIR)/$(CLIENTAPP) $(BIN_DIR)/$(SERVERAPP)

$(LIB_DIR)/$(LIBNAME).so: $(SRC_DIR)/$(CLIENT).o $(SRC_DIR)/$(SERVER).o $(SRC_DIR)/$(SOCKET).o lib_dir
	$(CC) -fPIC -shared -I$(INC_DIR) -o $(LIB_DIR)/$(LIBNAME).so.0.0 $(SRC_DIR)/$(CLIENT).o $(SRC_DIR)/$(SERVER).o $(SRC_DIR)/$(SOCKET).o
	$(RM) $(LIB_DIR)/$(LIBNAME).so.0
	$(RM) $(LIB_DIR)/$(LIBNAME).so
	$(LINK) $(LIBNAME).so.0.0 $(LIB_DIR)/$(LIBNAME).so.0
	$(LINK) $(LIBNAME).so.0 $(LIB_DIR)/$(LIBNAME).so

$(SRC_DIR)/$(CLIENT).o: $(INC_DIR)/$(CLIENT).h $(SRC_DIR)/$(CLIENT).cpp
	$(CC) $(OBJ_LINK) -I$(INC_DIR) $(SRC_DIR)/$(CLIENT).cpp -o $(SRC_DIR)/$(CLIENT).o

$(SRC_DIR)/$(SERVER).o: $(INC_DIR)/$(SERVER).h $(SRC_DIR)/$(SERVER).cpp
	$(CC) $(OBJ_LINK) -I$(INC_DIR) $(SRC_DIR)/$(SERVER).cpp -o $(SRC_DIR)/$(SERVER).o

$(SRC_DIR)/$(SOCKET).o: $(INC_DIR)/$(SOCKET).h $(SRC_DIR)/$(SOCKET).cpp
	$(CC) $(OBJ_LINK) -I$(INC_DIR) $(SRC_DIR)/$(SOCKET).cpp -o $(SRC_DIR)/$(SOCKET).o

$(BIN_DIR)/$(CLIENTAPP): $(SRC_DIR)/$(CLIENTAPP).cpp bin_dir
	$(CC) -I$(INC_DIR) -L$(LIB_DIR) $(SRC_DIR)/$(CLIENTAPP).cpp -o $(BIN_DIR)/$(CLIENTAPP) -l$(LIB)

$(BIN_DIR)/$(SERVERAPP): $(SRC_DIR)/$(SERVERAPP).cpp bin_dir
	$(CC) -I$(INC_DIR) -L$(LIB_DIR) $(SRC_DIR)/$(SERVERAPP).cpp -o $(BIN_DIR)/$(SERVERAPP) -l$(LIB)

clean:
	$(RM) $(LIB_DIR)/$(LIBNAME).so.0.0
	$(RM) $(LIB_DIR)/$(LIBNAME).so.0
	$(RM) $(LIB_DIR)/$(LIBNAME).so
	$(RM) $(SRC_DIR)/$(CLIENT).o
	$(RM) $(SRC_DIR)/$(SERVER).o
	$(RM) $(SRC_DIR)/$(SOCKET).o
	$(RM) $(BIN_DIR)/$(CLIENTAPP)
	$(RM) $(BIN_DIR)/$(SERVERAPP)
