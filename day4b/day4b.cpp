#include <algorithm>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <iterator>
#include <sstream>
#include <string>

#include "../day4/parse.cpp"

unsigned point_b(std::string & line, std::vector<unsigned> & cards) {
	auto [id, left, right] = read_table(line);

	std::stringstream prefix{left};
	std::stringstream suffix{right};

	std::vector<int> winning{};
	std::copy(std::istream_iterator<unsigned>(prefix),
		  std::istream_iterator<unsigned>(),
		  std::back_inserter(winning));

	auto wins = std::count_if(
	    std::istream_iterator<unsigned>(suffix),
	    std::istream_iterator<unsigned>(), [&winning](auto elt) {
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
