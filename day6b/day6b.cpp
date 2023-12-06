#include <algorithm>
#include <cctype>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <utility>
#include <vector>

#include "../aoc.hpp"

size_t possibilities_b(unsigned long time, unsigned long distance) {
	size_t count = 0;
	for (unsigned init = 0; init != time; ++init) {
		count += ((time - init) * init > distance);
	}
	return count;
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day6/example_6a.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	constexpr auto space = [](char c) { return std::isspace(c); };

	std::string line{};
	if (!std::getline(file, line)) return 1;
	line = aoc::read_key_value(line).second;
	line.erase(std::remove_if(line.begin(), line.end(), space), line.end());
	unsigned long time = std::stoul(line);

	if (!std::getline(file, line)) return 1;
	line = aoc::read_key_value(line).second;
	line.erase(std::remove_if(line.begin(), line.end(), space), line.end());
	unsigned long distance = std::stoul(line);

	size_t prod = possibilities_b(time, distance);

	std::cout << "Prod : " << prod << '\n';

	return 0;
}
