#include <algorithm>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <iterator>
#include <sstream>
#include <string>

#include "../day02/parse.hpp"

unsigned result_a(rgb_t limit, std::string line) {
	unsigned id = 0;
	std::string syntax;
	std::stringstream iss{line};
	iss >> syntax >> id >> syntax; // Game %d:

	auto bounded = [rhs = limit](rgb_t lhs) {
		return (lhs.red <= rhs.red) & (lhs.green <= rhs.green) &
		       (lhs.blue <= rhs.blue);
	};

	bool possible = std::all_of(std::istream_iterator<rgb_t>(iss),
				    std::istream_iterator<rgb_t>(), bounded);

	return possible ? id : 0;
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day2/example.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	const rgb_t limit = {.red = 12, .green = 13, .blue = 14};
	size_t sum = 0;
	for (std::string line; std::getline(file, line);) {
		sum += result_a(limit, line);
	}

	std::cout << "Sum : " << sum << '\n';

	return 0;
}
