#include <algorithm>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "../aoc.hpp"

struct unitrange {
	unsigned index = 0, length = 0;

	unsigned endof() const { return index + length; }

	friend bool operator<(unitrange lhs, unitrange rhs) {
		return (lhs.index < rhs.index) |
		       ((lhs.index == rhs.index) & (lhs.length < rhs.length));
	}
};

void location_b(std::vector<std::string> lines,
		std::vector<unitrange> & seeds) {

	std::vector<std::array<unsigned, 3>> maps{};
	std::vector<unsigned> triples{0, 0, 0};
	for (auto line : lines) {
		aoc::copy_line(line, triples);
		maps.push_back(std::array{triples[0], triples[1], triples[2]});
	}

	size_t nseed = seeds.size();
	// 4 is sufficent, but not provable
	for (size_t i = 0; i != std::min(seeds.size(), 4 * nseed); ++i) {
		auto seed = seeds[i];
		auto within = [seed](auto map) {
			return (seed.index < map[1] + map[2]) &
			       (seed.endof() >= map[1]);
		};

		auto it = std::find_if(maps.cbegin(), maps.cend(), within);
		if (it == maps.cend()) continue;

		auto translate = *it;
		unitrange offset{translate[1], translate[2]};

		auto mid{seed};
		if (seed.index < offset.index) {
			auto rng =
			    unitrange{seed.index, offset.index - seed.index};
			mid.index = offset.index;
			seeds.push_back(rng);
		}
		if (seed.endof() > offset.endof()) {
			auto rng = unitrange{offset.endof(),
					     seed.endof() - offset.endof()};
			mid.length = offset.endof() - mid.index;
			seeds.push_back(rng);
		}
		seeds[i].index = (mid.index - offset.index) + translate[0];
		seeds[i].length = mid.length;
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

	std::vector<unsigned> seedling{};
	aoc::copy_line(aoc::read_key_value(line).second, seedling);

	std::vector<unitrange> seeds{};
	size_t nseed = seedling.size();
	seeds.reserve(nseed / 2);
	for (size_t i = 0; i < nseed - 1; i += 2) {
		seeds.push_back({seedling[i], seedling[i + 1]});
	}

	if (!std::getline(file, line) || !line.empty()) return 1;

	for (std::vector<std::string> lines{}; std::getline(file, line);) {
		while (std::getline(file, line) && !line.empty()) {
			lines.push_back(line);
		}

		location_b(lines, seeds);
		lines.clear();
	}

	unsigned minimum =
	    std::min_element(seeds.cbegin(), seeds.cend())->index;
	std::cout << "Min : " << minimum << '\n';

	return 0;
}
