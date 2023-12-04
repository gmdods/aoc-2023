#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <iterator>
#include <sstream>
#include <string>

#include "../day4/parse.cpp"

unsigned point_a(std::string line) {
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
	return (wins > 0) ? std::pow(2, wins - 1) : 0;
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day4/example_4a.txt"};
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
