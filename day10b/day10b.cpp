#include <algorithm>
#include <array>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <numeric>
#include <string>
#include <utility>
#include <vector>

#include "../aoc.hpp"

using dir_t = std::array<int, 2>;

dir_t operator-(dir_t lhs, dir_t rhs) {
	return dir_t{lhs[0] - rhs[0], lhs[1] - rhs[1]};
}

dir_t operator+(dir_t lhs, dir_t rhs) {
	return dir_t{lhs[0] + rhs[0], lhs[1] + rhs[1]};
}

dir_t operator!(dir_t dir) { return dir_t{dir[1], dir[0]}; }

dir_t operator-(dir_t dir) { return dir_t{-dir[0], -dir[1]}; }

size_t distance_b(std::vector<char> & area, size_t ncols) {
	size_t nrows = area.size() / ncols;

	static std::string_view directions[4] = {"|LJ", "-J7", "|F7", "-LF"};

	auto row = std::find_if(area.cbegin(), area.cend(),
				[](auto c) { return c == 'S'; });
	if (row == area.cend()) return 0;
	lldiv_t pos = lldiv(row - area.cbegin(), ncols);
	auto s = dir_t{static_cast<int>(pos.quot), static_cast<int>(pos.rem)};

	auto follow = [&area, s, ncols, nrows]() {
		constexpr auto findchar = [](std::string_view str, char c) {
			return str.find(c) != std::string::npos;
		};

		if (s[0] + 1 < nrows) {
			auto r = s + dir_t{1, 0};
			auto c = area[r[0] * ncols + r[1]];
			if (findchar(directions[0], c)) return r;
		}
		if (s[1] + 1 < ncols) {
			auto r = s + dir_t{0, 1};
			auto c = area[r[0] * ncols + r[1]];
			if (findchar(directions[1], c)) return r;
		}
		if (s[0] > 0) {
			auto r = s + dir_t{-1, 0};
			auto c = area[r[0] * ncols + r[1]];
			if (findchar(directions[2], c)) return r;
		}
		if (s[1] > 0) {
			auto r = s + dir_t{0, -1};
			auto c = area[r[0] * ncols + r[1]];
			if (findchar(directions[3], c)) return r;
		}
		return s;
	}();

	std::vector<int> A(nrows * ncols, 0);
	std::vector<bool> B(nrows * ncols, false); // gasp!

	constexpr auto corner = [](auto c, auto d) {
		switch (c) {
		case '|':
		case '-': return 2 * d[1];
		case 'L': return 2 * d[0] - 1;
		case '7': return -2 * d[0] + 1;
		case 'J': return 2 * d[0] + 1;
		case 'F': return -2 * d[0] - 1;
		default: return 0;
		}
	};

	size_t step = 1;
	dir_t f = follow, d = f - s;
	for (; f != s; ++step) {
		auto c = area[f[0] * ncols + f[1]];

		A[f[0] * ncols + f[1]] = corner(c, d);
		B[f[0] * ncols + f[1]] = true;

		dir_t o = d;
		switch (c) {
		case '|':
		case '-': o = d; break;
		case 'L':
		case '7': o = !d; break;
		case 'J':
		case 'F': o = -!d;
		default: break;
		}
		f = f + o;
		d = o;
	}
	A[f[0] * ncols + f[1]] = (follow - s)[1] + d[1];
	B[f[0] * ncols + f[1]] = true;

	size_t sum = 0;

	for (size_t i = 0; i != ncols; ++i) {
		size_t partial = 0; // can't use partial sum
		for (size_t j = 0; j != ncols * nrows; j += ncols) {
			partial += A[i + j];
			A[i + j] = partial;
			sum += ((partial / 2) & 1) >
			       static_cast<unsigned>(B[i + j]);
		}
	}

	return sum;
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day10/example_b.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	std::vector<char> area{};

	size_t ncols = 0;
	for (std::string line{}; std::getline(file, line);) {
		ncols = line.size();
		for (auto c : line)
			area.push_back(c);
	}

	size_t sum = distance_b(area, ncols);
	std::cout << "Sum : " << sum << '\n';

	return 0;
}
