#include <algorithm>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <utility>
#include <vector>

#include "../aoc.hpp"

void location_a(std::vector<std::string> lines, std::vector<unsigned> & seeds) {

	std::vector<std::array<unsigned, 3>> maps{};
	std::vector<unsigned> triples{0, 0, 0};
	for (auto line : lines) {
		aoc::copy_line(line, triples);
		maps.push_back(std::array{triples[0], triples[1], triples[2]});
	}

	for (auto & seed : seeds) {
		auto it =
		    std::find_if(maps.cbegin(), maps.cend(), [seed](auto map) {
			    unsigned offset = seed - map[1];
			    return offset < map[2];
		    });
		if (it == maps.cend()) continue;

		auto translate = *it;
		seed = (seed - translate[1]) + translate[0];
	}
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day5/example_5a.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	std::string line{};
	if (!std::getline(file, line)) return 1;
	std::vector<unsigned> seeds{};
	aoc::copy_line(aoc::read_key_value(line).second, seeds);

	if (!std::getline(file, line) || !line.empty()) return 1;

	for (std::vector<std::string> lines{}; std::getline(file, line);) {
		while (std::getline(file, line) && !line.empty()) {
			lines.push_back(line);
		}

		location_a(lines, seeds);
		lines.clear();
	}

	unsigned minimum = *std::min_element(seeds.cbegin(), seeds.cend());
	std::cout << "Min : " << minimum << '\n';

	return 0;
}
