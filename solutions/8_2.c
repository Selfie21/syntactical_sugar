//Output is m6

#include <stdio.h>

int global[] = {1, 2, 3, 4, 5};

int *magic(int x[], int y) {
	printf("m");
	
	global[1] = *(global + y) + 3;
	// global[1] = global[2] + 3
	// global[1] = 6
	return &x[y-2];
	// &x[2-2]
	// &global[1] (wegen x[] = global[1] in Aufruf in main()
}

int main() {
	printf("%i", *magic(&global[1], *(global + 1)));
	// printf("%i", *magic(&global[1], 2));
	// printf("6", *global[1])

	return 0;
}