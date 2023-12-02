#include <algorithm>
#include <array>
#include <cctype>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <iterator>
#include <numeric>
#include <sstream>
#include <string>

template <typename T>
using pair_t = std::pair<T, T>;

std::pair<pair_t<size_t>, pair_t<unsigned>> find_digits(std::string line) {
	auto digit = [](char c) { return std::isdigit(c); };
	auto fd = std::find_if(line.cbegin(), line.cend(), digit);
	auto ld = std::find_if(line.crbegin(), line.crend(), digit);

	auto offset = [](auto it, auto end) {
		return (it == end) ? 0 : (*it - '0');
	};
	return {{fd - line.cbegin(), ld - line.crbegin()},
		{offset(fd, line.cend()), offset(ld, line.crend())}};
}

static const std::array<std::string, 9> numbers = {
    "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};

unsigned calibrate_b(std::string line) {
	auto [index, digits] = find_digits(line);
	auto [fd, ld] = index;

	auto sz = line.size();

	std::array<size_t, 9> first_names{0};
	std::array<size_t, 9> last_names{0};

	unsigned i = 0;
	for (auto & num : numbers) {
		first_names[i] = std::search(line.cbegin(), line.cend(),
					     num.cbegin(), num.cend()) -
				 line.cbegin();

		last_names[i] = std::search(line.crbegin(), line.crend(),
					    num.crbegin(), num.crend()) -
				line.crbegin();
		++i;
	} // std::transform;

	auto first = std::min_element(first_names.cbegin(), first_names.cend());
	auto last = std::min_element(last_names.cbegin(), last_names.cend());

	unsigned fs = 1 + (first - first_names.cbegin());
	unsigned ls = 1 + (last - last_names.cbegin());

	auto f = ((fd != sz) && (fd < *first)) ? digits.first : fs;
	auto l = ((ld != sz) && (ld < *last)) ? digits.second : ls;
	return 10U * f + l;
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day1/example_1b.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	size_t sum = 0;
	for (std::string line; std::getline(file, line);) {
		sum += calibrate_b(line);
	}

	std::cout << "Sum : " << sum << '\n';

	return 0;
}
