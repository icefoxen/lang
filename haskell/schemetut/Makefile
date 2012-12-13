HC=ghc
FLAGS=

SRC=scheme.hs
OUTPUT=hscm

all: $(OUTPUT) 

clean:
	rm -f $(OBJECTS)
	rm -f *~

$(OUTPUT): $(SRC)
	$(HC) --make -o $(OUTPUT) $(SRC)
