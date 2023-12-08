#include <algorithm>
#include <cassert>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <map>
#include <numeric>
#include <string>
#include <utility>
#include <vector>

#include "../aoc.hpp"

using code_t = std::array<char, 3>;
using both_t = std::array<code_t, 2>;

struct arithmetic_t {
	size_t init = 0, delta = 0; // init + n * delta

	void found(size_t step) & {
		if (init == 0)
			init = step;
		else if (delta == 0)
			delta = step - init;
	}

	bool proper() const { return delta != 0; }

	arithmetic_t operator+(arithmetic_t o) const { // remainder theorem
		assert((init == delta) && (o.init == o.delta)); // a miracle!
		auto anew = std::lcm(delta, o.delta);
		return {anew, anew};
	}
};

size_t steps_a(const std::vector<bool> & directions,
	       const std::map<code_t, both_t> & walk) {
	std::vector<code_t> iters{};
	for (auto [k, v] : walk) // need copy_transform_if
		if (k[2] == 'A') iters.push_back(k);

	std::vector<arithmetic_t> ariths(iters.size(), arithmetic_t{0});

	for (size_t step = 0;;) {
		for (auto dir : directions) {
			step += 1;
			auto all_of = true; // single pass
			for (size_t i = 0; i != iters.size(); ++i) {
				auto & iter = iters[i];
				iters[i] = walk.at(iters[i])[dir];
				if (iter[2] == 'Z') {
					ariths[i].found(step);
				} else
					all_of = false;
			}
			if (all_of) return step;
		}

		if (std::all_of(ariths.cbegin(), ariths.cend(),
				[](auto a) { return a.proper(); })) {
			auto sequence = std::accumulate(
			    ariths.cbegin(), ariths.cend(), arithmetic_t{1, 1});
			return sequence.init;
		}
	}
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day8/example_b.txt"};
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
