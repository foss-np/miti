default: python

c:
	gcc example.c date.c -o example

clean:
	rm -f *.o example

python:
	./main.py

bash:
	./nepdate.sh
