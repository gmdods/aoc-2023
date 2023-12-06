#include <algorithm>
#include <cstdlib>
#include <iterator>
#include <sstream>
#include <string>
#include <vector>

void copy_line(std::string & line, std::vector<unsigned> & out) {
	std::stringstream stream{line};
	out.clear();
	std::copy(std::istream_iterator<unsigned>(stream),
		  std::istream_iterator<unsigned>(), std::back_inserter(out));
}
