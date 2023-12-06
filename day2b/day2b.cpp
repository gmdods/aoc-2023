#include <cstdlib>
#include <fstream>
#include <istream>
#include <iterator>
#include <numeric>
#include <sstream>
#include <string>

#include "../day2/parse.hpp"

unsigned result_b(std::string line) {
	unsigned id = 0;
	std::string syntax;
	std::stringstream iss{line};
	iss >> syntax >> id >> syntax; // Game %d:

	constexpr auto majorize = [](rgb_t lhs, rgb_t rhs) {
		return rgb_t{std::max(lhs.red, rhs.red),
			     std::max(lhs.green, rhs.green),
			     std::max(lhs.blue, rhs.blue)};
	};

	rgb_t minimal =
	    std::reduce(std::istream_iterator<rgb_t>(iss),
			std::istream_iterator<rgb_t>(), rgb_t{0}, majorize);
	return static_cast<unsigned>(minimal.red) *
	       static_cast<unsigned>(minimal.green) *
	       static_cast<unsigned>(minimal.blue);
}

int main(int argc, const char * argv[]) {
	std::ifstream file{(argc >= 2) ? argv[1] : "day2/example.txt"};
	if (!file) {
		std::cerr << "No file\n";
		return 1;
	}

	size_t sum = 0;
	for (std::string line; std::getline(file, line);) {
		sum += result_b(line);
	}

	std::cout << "Sum : " << sum << '\n';

	return 0;
}
