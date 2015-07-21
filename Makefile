default: python

c:
	gcc example.c date.c -o example

python:
	./main.py

clean:
	rm -f *.o example
