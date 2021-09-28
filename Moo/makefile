echoTest: main.o copyfile.o modifyfile.o array.o reader.o
		gcc -o echoTest main.o copyfile.o modifyfile.o array.o reader.o


main.o: main.s
	gcc -c -g main.s

copyfile.o: copyfile.s
	gcc -c -g copyfile.s

modifyfile.o: modifyfile.s
	gcc -c -g modifyfile.s

array.o: array.s
	gcc -c -g array.s

reader.o: reader.s
	gcc -c -g reader.s

