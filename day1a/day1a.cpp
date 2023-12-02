#include <algorithm>
#include <cctype>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>

std::pair<unsigned, unsigned> find_digits(std::string line) {
	auto digit = [](char c) { return std::isdigit(c); };
	auto fd = std::find_if(line.cbegin(), line.cend(), digit);
	auto ld = std::find_if(line.crbegin(), line.crend(), digit);

	auto offset = [](auto it, auto end) {
		return (it == end) ? 0 : (*it - '0');
	};
	return {offset(fd, line.cend()), offset(ld, line.crend())};
}

unsigned calibrate_a(std::string line) {
	auto [f, l] = find_digits(line);
	return 10U * f + l;
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day1/example_1a.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	size_t sum = 0;
	for (std::string line; std::getline(file, line);) {
		sum += calibrate_a(line);
	}

	std::cout << "Sum : " << sum << '\n';

	return 0;
}
