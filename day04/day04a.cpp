#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <iterator>
#include <sstream>
#include <string>
#include <string_view>

#include "../aoc.hpp"

unsigned point_a(std::string_view line) {
	auto [id, sequence] = aoc::read_key_id(line);
	auto [left, right] = aoc::read_separator(sequence, '|');

	std::vector<unsigned> winning{};
	aoc::copy_line(left, winning);
	aoc::string_copy mine{right};

	auto wins =
	    std::count_if(mine.begin(), mine.end(), [&winning](auto elt) {
		    return std::find(winning.cbegin(), winning.cend(), elt) !=
			   winning.cend();
	    });
	return (wins > 0) ? std::pow(2, wins - 1) : 0;
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day4/example.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	size_t sum = 0;
	for (std::string line; std::getline(file, line);) {
		sum += point_a(line);
	}

	std::cout << "Sum : " << sum << '\n';

	return 0;
}
