EXE=calculator
LIB_NAME=libcalculator.so

all: executable lib

executable: main.cpp calculator.cpp
	@echo "Compilation..."
	gcc -lstdc++ main.cpp calculator.cpp -o $(EXE)
	@echo 'Done: $(EXE)'

lib: calculator.cpp
	@echo 'Creating library...'
	gcc -fpic -c calculator.cpp
	gcc -shared -o $(LIB_NAME) calculator.o
	rm calculator.o
	@echo 'Done: $(LIB_NAME)'

clean:
	rm $(EXE) $(LIB_NAME)
