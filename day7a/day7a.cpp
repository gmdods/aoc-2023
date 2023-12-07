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

unsigned point_a(std::array<uint8_t, 5> card) {
	std::map<uint8_t, int> count{};
	for (auto c : card)
		++count[c];

	unsigned max = 0, sum = 0;
	for (auto [k, v] : count) {
		if (v <= 1) continue;
		if (v > max) max = v;
		sum += v - 1;
	}
	return max + sum;
}

struct card_t {
	std::array<uint8_t, 5> card;
	unsigned bid;
};

size_t winnings(std::vector<card_t> & cards) {
	constexpr auto compare = [](card_t lhs, card_t rhs) {
		auto x = lhs.card, y = rhs.card;
		auto px = point_a(x), py = point_a(y);
		if (px == py)
			return std::lexicographical_compare(
			    x.cbegin(), x.cend(), y.cbegin(), y.cend());
		return px < py;
	};
	std::sort(cards.begin(), cards.end(), compare);
	size_t sum = 0;
	for (size_t i = 0; i != cards.size(); ++i)
		sum += (i + 1) * cards[i].bid;
	return sum;
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day7/example.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	std::vector<card_t> cards{};

	constexpr auto encode = [](std::string & card) {
		constexpr auto encode_char = [](char c) -> uint8_t {
			switch (c) {
			case 'A': return 14;
			case 'K': return 13;
			case 'Q': return 12;
			case 'J': return 11;
			case 'T': return 10;
			case '9': return 9;
			case '8': return 8;
			case '7': return 7;
			case '6': return 6;
			case '5': return 5;
			case '4': return 4;
			case '3': return 3;
			case '2': return 2;
			default: return 0;
			}
		};

		return std::array<uint8_t, 5>{
		    encode_char(card[0]), encode_char(card[1]),
		    encode_char(card[2]), encode_char(card[3]),
		    encode_char(card[4])};
	};

	for (std::string line{}; std::getline(file, line);) {
		std::istringstream stream{line};
		std::string card{};
		unsigned bid{};
		stream >> card >> bid;
		cards.push_back(card_t{encode(card), bid});
	}

	unsigned sum = winnings(cards);
	std::cout << "Sum : " << sum << '\n';

	return 0;
}
