# Copyright 2016 Riccardo Melioli. All Rights Reserved.

# executable name
TARGET   = Richkware

ifeq ($(OS),Windows_NT)
    CXX=g++
    RM=cmd /C rmdir /Q /S
    MKDIR=mkdir
else
    CXX=x86_64-w64-mingw32-g++
    RM=rm -rf
    MKDIR=mkdir -p
endif

# flags
CXXFLAGS= -c -O3 -Wall
LDFLAGS= -static-libgcc -static-libstdc++ -static -Wall
EFLAG= -lws2_32

# directories
SRCDIR   = src
OBJDIR   = obj
BINDIR   = bin

# files
SOURCES  := $(wildcard $(SRCDIR)/*.cpp)
INCLUDES := $(wildcard $(SRCDIR)/*.h)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)
EXECUTABLE= $(BINDIR)/$(TARGET).exe

.PHONY : all
all: make_directories $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS) main.o
	$(CXX) $(LDFLAGS) $(OBJECTS) $(OBJDIR)/main.o $(EFLAG) -o $@

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

main.o: 
	$(CXX) $(CXXFLAGS) main.cpp -o $(OBJDIR)/main.o

.PHONY : make_directories
make_directories: 
	$(MKDIR) $(OBJDIR) $(BINDIR)

.PHONY : clean
clean:
	$(RM) $(OBJDIR) $(BINDIR)