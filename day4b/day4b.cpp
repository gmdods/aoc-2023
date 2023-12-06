#include <algorithm>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <iterator>
#include <sstream>
#include <string>
#include <string_view>

#include "../aoc.hpp"

unsigned point_b(std::string & line, std::vector<unsigned> & cards) {
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
	cards.resize(std::max(size_t(id + wins), cards.size()), 0);
	auto count = (cards[id - 1] += 1);
	std::for_each_n(cards.begin() + id, wins,
			[count](auto & elt) { elt += count; });
	return count;
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day4/example_4b.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	std::vector<unsigned> cards{};
	size_t sum = 0;
	for (std::string line; std::getline(file, line);) {
		sum += point_b(line, cards);
	}

	std::cout << "Sum : " << sum << '\n';

	return 0;
}
