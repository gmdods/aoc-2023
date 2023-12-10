#include <algorithm>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>

unsigned part_a(std::string pre, std::string mid, std::string post) {
	size_t size = mid.size();
	if (pre.empty()) pre.resize(size, '.');
	if (post.empty()) post.resize(size, '.');

	constexpr auto digit = [](char c) { return std::isdigit(c); };
	auto bounds_check = [&pre, &mid, &post, size](auto left, auto right) {
		constexpr auto symbol = [](char c) {
			return !std::isdigit(c) & (c != '.');
		};
		if (left >= right) return false;
		bool check = false;
		check |= std::any_of(post.cbegin() + left,
				     post.cbegin() + right, symbol) ||
			 std::any_of(pre.cbegin() + left, pre.cbegin() + right,
				     symbol);
		if (left != 0)
			check |= symbol(pre[left - 1]) | symbol(mid[left - 1]) |
				 symbol(post[left - 1]);
		if (right != size)
			check |= symbol(pre[right]) | symbol(mid[right]) |
				 symbol(post[right]);
		return check;
	};
	unsigned sum = 0;
	for (auto begin = mid.cbegin();
	     (begin = std::find_if(begin, mid.cend(), digit)) != mid.cend();) {
		auto end = std::find_if_not(begin, mid.cend(), digit);
		auto left = begin - mid.cbegin(), right = end - mid.cbegin();
		if (bounds_check(left, right))
			sum += std::stoi(mid.substr(left, right - left));
		begin = end;
	}
	return sum;
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day3/example.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	size_t sum = 0;
	std::string pre{}, mid{}, post{};
	if (std::getline(file, mid)) {
		while (std::getline(file, post)) {
			sum += part_a(pre, mid, post);
			pre = mid;
			mid = post;
		}
		sum += part_a(pre, mid, post);
	}

	std::cout << "Sum : " << sum << '\n';

	return 0;
}
