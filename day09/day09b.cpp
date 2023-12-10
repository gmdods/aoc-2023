#include <algorithm>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <numeric>
#include <string>
#include <utility>
#include <vector>

#include "../aoc.hpp"

ssize_t extrapolate_b(std::vector<int> & history) {
	constexpr auto iszero = [](auto elt) { return elt == 0; };
	size_t remaining = 0, offset = 0;
	for (; !std::all_of(history.cbegin() + offset, history.cend(), iszero);
	     ++offset) {
		remaining = history.front() - remaining;
		std::adjacent_difference(history.cbegin() + offset,
					 history.cend(),
					 history.begin() + offset);
	}
	return std::accumulate(std::reverse_iterator(history.cbegin() + offset),
			       history.crend(), 0,
			       [](auto lhs, auto rhs) { return rhs - lhs; });
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day9/example.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	std::vector<int> history{};

	ssize_t sum = 0;
	for (std::string line{}; std::getline(file, line);) {
		aoc::copy_line(line, history);
		sum += extrapolate_b(history);
	}

	std::cout << "Sum : " << sum << '\n';

	return 0;
}
