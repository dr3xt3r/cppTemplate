#include <cstdlib>
#include <iostream>

#include "calculator.h"

int main()
{
	Calculator calc;
	std::cout << "3 + 4 = " << calc.add(7, 8) << std::endl;
	std::cout << "10 - 2 = " << calc.subtract(10, 2) << std::endl;

    int* var = (int*)malloc(sizeof(int));

	return 0;
}