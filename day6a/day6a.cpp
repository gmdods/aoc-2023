#include <algorithm>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <utility>
#include <vector>

#include "../aoc.hpp"

size_t possibilities_a(unsigned time, unsigned distance) {
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

	std::vector<unsigned> time{}, distance{};

	std::string line{};
	if (!std::getline(file, line)) return 1;
	aoc::copy_line(aoc::read_key_value(line).second, time);

	if (!std::getline(file, line)) return 1;
	aoc::copy_line(aoc::read_key_value(line).second, distance);

	size_t prod = 1;
	for (size_t i = 0; i != std::min(time.size(), distance.size()); ++i) {
		prod *= possibilities_a(time[i], distance[i]);
	}

	std::cout << "Prod : " << prod << '\n';

	return 0;
}
