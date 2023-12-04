#include <cstdlib>
#include <string>

auto read_table(std::string & line) {
	size_t id = line.find(' '), card = line.find(':'),
	       separate = line.find('|');
	return std::tuple{std::stoi(line.substr(id + 1, card - id - 1)),
			  line.substr(card + 1, separate - card - 1),
			  line.substr(separate + 1, line.size() - separate)};
}
