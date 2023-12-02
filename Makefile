.PHONY: all
all: day1 day2

clean:
	rm *.out

.PHONY: day1a
day1a: day1a.cpp day1a.jl
.PHONY: day1b
day1b: day1b.cpp day1b.jl
.PHONY: day1
day1: day1a day1b

day1a.cpp:
	g++ day1a/day1a.cpp -o day1a.out && ./day1a.out day1/input.txt
day1b.cpp:
	g++ day1b/day1b.cpp -o day1b.out && ./day1b.out day1/input.txt

day1a.jl:
	julia day1a/day1a.jl day1/input.txt
day1b.jl:
	julia day1b/day1b.jl day1/input.txt

.PHONY: day2a
day2a: day2a.cpp day2a.jl
.PHONY: day2b
day2b: day2b.cpp day2b.jl
.PHONY: day2
day2: day2a day2b

day2a.cpp:
	g++ day2a/day2a.cpp -o day2a.out && ./day2a.out day2/input.txt
day2b.cpp:
	g++ day2b/day2b.cpp -o day2b.out && ./day2b.out day2/input.txt

day2a.jl:
	julia day2a/day2a.jl day2/input.txt
day2b.jl:
	julia day2b/day2b.jl day2/input.txt

