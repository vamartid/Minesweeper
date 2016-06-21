CC = g++
CFLAGS = -Wall -g

# BUILD COMMANDS
# vvvvvvvvvvvvvv

build: Minesweeper.cpp Minesweeper.h
	$(CC) $(CFLAGS) main.cpp Minesweeper.cpp Minesweeper.h


# RUN COMMANDS
# vvvvvvvvvvvv

run:
	./a.out


# CLEAN COMMANDS
# vvvvvvvvvvvvvv

clean:
	rm -rf a.out
