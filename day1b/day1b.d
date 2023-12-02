import std.traits, std.range;

auto size(R)(R r) if (isArray!(R))
{
	return r.length;
}

auto size(R)(R r) if (!isArray!(R) && isForwardRange!(R))
{
	return r.walkLength;
}

auto suffix(R1, R2)(R1 start, R2 r)
{
	return start.size - r.size;
}

auto find_digits(char[] line)
{
	import std.ascii : isDigit;
	import std.typecons : tuple;
	import std.algorithm, std.range;

	alias offset = it => (it.empty()) ? 0 : (it.front() - '0');

	auto fr = line.find!isDigit();
	auto fd = suffix(line, fr);
	auto f = offset(fr);
	auto lr = line.retro.find!isDigit();
	auto ld = suffix(line, lr);
	auto l = offset(lr);

	return tuple!("fd", "ld", "f", "l")(fd, ld, f, l);
}

uint calibrate_b(char[] line)
{
	static immutable string[9] numbers = [
		"one", "two", "three", "four", "five", "six", "seven", "eight",
		"nine"
	];
	import std.algorithm, std.range;

	auto r = find_digits(line);
	auto sz = line.length;

	alias findfirst = num => suffix(line, line.find(num));
	alias findlast = num => suffix(line, line.retro.find(num.retro));
	auto first = numbers.array.map!findfirst().minPos;
	auto last = numbers.array.map!findlast().minPos;

	uint fs = 1U + cast(uint) suffix(numbers, first);
	uint ls = 1U + cast(uint) suffix(numbers, last);

	auto f = ((r.fd != sz) && (r.fd < first.front())) ? r.f : fs;
	auto l = ((r.ld != sz) && (r.ld < last.front())) ? r.l : ls;

	return 10U * f + l;
}

int main(string[] args)
{
	import std.stdio;
	import std.algorithm;

	auto path = (args.length > 1) ? args[1] : "day1/example_1b.txt";
	auto file = File(path, "r");
	auto sum = file.byLine().map!calibrate_b().sum();

	writeln("Sum : ", sum);

	return 0;
}
