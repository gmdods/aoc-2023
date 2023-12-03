#include <algorithm>
#include <array>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>

struct gears {
	uint8_t count = 0;
	unsigned long one = 0, two = 0;

	gears() {}
	gears(std::string && one) : count(1), one(std::stoul(one)) {}
	gears(std::string && one, std::string && two)
	    : count(2), one(std::stoul(one)), two(std::stoul(two)) {}

	gears(uint8_t count, unsigned long one, unsigned long two)
	    : count(count), one(one), two(two) {}

	gears operator+(gears other) const {
		uint8_t joint = count + other.count;
		return gears{
		    joint,
		    ((count > 0) ? one : other.one),
		    ((count > 0) ? ((count > 1) ? two : other.one) : other.two),
		};
	}
};

unsigned part_b(std::string pre, std::string mid, std::string post) {
	size_t size = mid.size();
	if (pre.empty()) pre.resize(size, '.');
	if (post.empty()) post.resize(size, '.');

	auto bounds_check = [&pre, &mid, &post, size](auto index) {
		constexpr auto digit = [](char c) { return std::isdigit(c); };

		std::array<std::array<bool, 3>, 3> square{0};
		if (index != 0) {
			square[0][0] = digit(pre[index - 1]);
			square[1][0] = digit(mid[index - 1]);
			square[2][0] = digit(post[index - 1]);
		}

		square[0][1] = digit(pre[index]);
		square[2][1] = digit(post[index]);

		if (index != size - 1) {
			square[0][2] = digit(pre[index + 1]);
			square[1][2] = digit(mid[index + 1]);
			square[2][2] = digit(post[index + 1]);
		}

		return square;
	};

	constexpr auto rows = [](std::string & str, size_t i,
				 std::array<bool, 3> row) {
		auto sub = [&str](auto l, auto r) {
			return str.substr(l, r - l);
		};

		auto before = [&str](size_t i) {
			constexpr auto digit = [](char c) {
				return std::isdigit(c);
			};
			auto end = std::find_if_not(
			    std::reverse_iterator(str.cbegin() + i),
			    str.crend(), digit);
			return str.crend() - end;
		};
		auto after = [&str](size_t i) {
			constexpr auto digit = [](char c) {
				return std::isdigit(c);
			};
			auto end = std::find_if_not(str.cbegin() + i,
						    str.cend(), digit);
			return end - str.cbegin();
		};

		uint8_t offset = (static_cast<uint8_t>(row[0]) << 2) |
				 (static_cast<uint8_t>(row[1]) << 1) |
				 (static_cast<uint8_t>(row[2]) << 0);
		switch (offset) {
		case 0b001: return gears(sub(i + 1, after(i + 1)));
		case 0b010: return gears(sub(i, i + 1));
		case 0b011: return gears(sub(i, after(i)));
		case 0b100: return gears(sub(before(i - 1), i));
		case 0b101:
			return gears(sub(before(i - 1), i),
				     sub(i + 1, after(i + 1)));
		case 0b110: return gears(sub(before(i), i + 1));
		case 0b111: return gears(sub(before(i), after(i)));

		case 0b000:
		default: return gears();
		}
	};

	unsigned sum = 0;
	for (size_t i = 0; i != size; ++i) {
		if (mid[i] == '*') {
			auto square = bounds_check(i);
			auto finds = rows(pre, i, square[0]) +
				     rows(mid, i, square[1]) +
				     rows(post, i, square[2]);
			if (finds.count == 2) sum += finds.one * finds.two;
		}
	}
	return sum;
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day3/example_3a.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	size_t sum = 0;
	std::string pre{}, mid{}, post{};
	if (std::getline(file, mid)) {
		while (std::getline(file, post)) {
			sum += part_b(pre, mid, post);
			pre = mid;
			mid = post;
		}
		sum += part_b(pre, mid, post);
	}

	std::cout << "Sum : " << sum << '\n';

	return 0;
}
