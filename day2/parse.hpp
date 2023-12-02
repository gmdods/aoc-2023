#include <algorithm>
#include <array>
#include <cctype>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>

struct rgb_t {
	uint8_t red, green, blue;

	friend std::istream & operator>>(std::istream & is, rgb_t & rgb) {
		static std::array<std::string, 3> names = {"red", "green",
							   "blue"};
		constexpr auto alpha = [](char c) { return std::isalpha(c); };
		std::string name;
		std::array<uint8_t, 4> colours = {0};
		for (size_t i = 0; i != 3; ++i) {
			unsigned colour = 0;
			is >> colour >> name;

			auto sentinel =
			    std::find_if_not(name.begin(), name.end(), alpha);
			bool is_last =
			    (sentinel == name.end()) || (*sentinel != ',');
			name.erase(sentinel, name.end());

			size_t c =
			    std::find(names.cbegin(), names.cend(), name) -
			    names.cbegin();
			colours[c] = colour;
			if (is_last) break;
		}

		rgb = rgb_t{
		    .red = colours[0], .green = colours[1], .blue = colours[2]};
		return is;
	}
};
