auto find_digits(char[] line)
{
	import std.ascii : isDigit;
	import std.typecons : tuple;
	import std.algorithm, std.range;

	alias offset = it => (it.empty()) ? 0 : (it.front() - '0');

	auto fd = offset(line.find!isDigit());
	auto ld = offset(line.reverse.find!isDigit());

	return tuple!("f", "l")(fd, ld);
}

uint calibrate_a(char[] line)
{
	auto r = find_digits(line);
	return 10U * r.f + r.l;
}

int main(string[] args)
{
	import std.stdio;
	import std.algorithm;

	auto path = (args.length > 1) ? args[1] : "day1/example_1a.txt";
	auto file = File(path, "r");
	auto sum = file.byLine().map!calibrate_a().sum();

	writeln("Sum : ", sum);

	return 0;
}
