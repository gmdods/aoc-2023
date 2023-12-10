#include <algorithm>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <map>
#include <string>
#include <utility>
#include <vector>

#include "../aoc.hpp"

using code_t = std::array<char, 3>;
using both_t = std::array<code_t, 2>;

size_t steps_a(const std::vector<bool> & directions,
	       const std::map<code_t, both_t> & walk) {
	code_t iter{'A', 'A', 'A'};
	for (size_t step = 0;;) {
		for (auto dir : directions) {
			iter = walk.at(iter)[dir];
			step += 1;
			if (iter == code_t{'Z', 'Z', 'Z'}) return step;
		}
	}
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day8/example_a.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	std::vector<bool> directions{}; // gasp!
	std::map<code_t, both_t> walk{};

	constexpr auto encode = [](char c) -> bool {
		switch (c) {
		case 'L': return false;
		case 'R': return true;
		default: return false;
		}
	};

	std::string line{};

	if (!std::getline(file, line)) return 1;
	std::transform(line.cbegin(), line.cend(),
		       std::back_inserter(directions), encode);

	if (!std::getline(file, line) && !line.empty()) return 1;

	while (std::getline(file, line)) {
		code_t key{}, left{}, right{};

		key = {line[0], line[1], line[2]};
		left = {line[7], line[8], line[9]};
		right = {line[12], line[13], line[14]};
		walk[key] = {left, right};
	}

	size_t sum = steps_a(directions, walk);
	std::cout << "Sum : " << sum << '\n';

	return 0;
}
