#ifndef AOC_HPP
#define AOC_HPP

#include <algorithm>
#include <cstdlib>
#include <iterator>
#include <sstream>
#include <string>
#include <string_view>
#include <vector>

namespace aoc {

struct string_copy {
	std::istringstream stream{};
	string_copy(std::string & line) : stream(line) {}
	string_copy(std::string_view line) : stream(std::string(line)) {}

	auto begin() { return std::istream_iterator<unsigned>(stream); }
	auto end() { return std::istream_iterator<unsigned>(); }

};

void copy_line(std::string_view line, std::vector<unsigned> & out) {
	aoc::string_copy stream{line};
	out.clear();
	std::copy(stream.begin(), stream.end(), std::back_inserter(out));
}

auto read_separator(std::string_view line, char sep) {
	size_t separator = line.find(sep);
	return std::pair{line.substr(0, separator),
			 line.substr(separator + 1, line.size() - separator)};
}

auto read_key_value(std::string_view line) { return read_separator(line, ':'); }

auto read_key_id(std::string_view line) {
	size_t space = line.find(' ');
	size_t separator = line.find(':');
	return std::pair{std::stoi(std::string{
			     line.substr(space + 1, separator - space - 1)}),
			 line.substr(separator + 1, line.size() - separator)};
}

} // namespace aoc

#endif // !AOC_HPP
