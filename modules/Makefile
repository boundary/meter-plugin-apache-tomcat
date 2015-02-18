CFLAGS=$(shell luvit --cflags)
LIBS=$(shell luvit --libs)

all: mime.luvit

%.o: %.c %.h
	$(CC) -c $< -o $@ ${CFLAGS}

mime.luvit: mime.o
	$(CC) -o mime.luvit mime.o ${LIBS}

clean:
	rm -f mime.o mime.luvit
