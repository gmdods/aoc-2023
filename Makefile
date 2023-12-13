.PHONY: all
all: day01 day02 day03 day04 day05 day06 day07 day08 day09 day10 day11 clean

clean:
	rm *.out

.PHONY: day01a
day01a: day01a.cpp day01a.jl day01a.d day01a.ml
.PHONY: day01b
day01b: day01b.cpp day01b.jl day01b.d day01b.ml
.PHONY: day01
day01: day01a day01b

day01a.cpp:
	g++ day01/day01a.cpp -o day01a.out && ./day01a.out day01/input.txt
day01b.cpp:
	g++ day01/day01b.cpp -o day01b.out && ./day01b.out day01/input.txt

day01a.jl:
	julia day01/day01a.jl day01/input.txt
day01b.jl:
	julia day01/day01b.jl day01/input.txt

day01a.d:
	rdmd day01/day01a.d day01/input.txt
day01b.d:
	rdmd day01/day01b.d day01/input.txt

day01a.ml:
	ocaml day01/day01a.ml day01/input.txt
day01b.ml:
	ocaml day01/day01b.ml day01/input.txt


.PHONY: day02a
day02a: day02a.cpp day02a.jl day02a.ml
.PHONY: day02b
day02b: day02b.cpp day02b.jl day02b.ml
.PHONY: day02
day02: day02a day02b

day02a.cpp:
	g++ day02/day02a.cpp -o day02a.out && ./day02a.out day02/input.txt
day02b.cpp:
	g++ day02/day02b.cpp -o day02b.out && ./day02b.out day02/input.txt

day02a.jl:
	julia day02/day02a.jl day02/input.txt
day02b.jl:
	julia day02/day02b.jl day02/input.txt

day02a.ml:
	ocaml day02/day02a.ml day02/input.txt
day02b.ml:
	ocaml day02/day02b.ml day02/input.txt


.PHONY: day03a
day03a: day03a.cpp day03a.jl day03a.ml
.PHONY: day03b
day03b: day03b.cpp day03b.jl day03b.ml
.PHONY: day03
day03: day03a day03b

day03a.cpp:
	g++ day03/day03a.cpp -o day03a.out && ./day03a.out day03/input.txt
day03b.cpp:
	g++ day03/day03b.cpp -o day03b.out && ./day03b.out day03/input.txt

day03a.jl:
	julia day03/day03a.jl day03/input.txt
day03b.jl:
	julia day03/day03b.jl day03/input.txt

day03a.ml:
	ocaml day03/day03a.ml day03/input.txt
day03b.ml:
	ocaml day03/day03b.ml day03/input.txt


.PHONY: day04a
day04a: day04a.cpp day04a.jl
.PHONY: day04b
day04b: day04b.cpp day04b.jl
.PHONY: day04
day04: day04a day04b

day04a.cpp:
	g++ day04/day04a.cpp -o day04a.out && ./day04a.out day04/input.txt
day04b.cpp:
	g++ day04/day04b.cpp -o day04b.out && ./day04b.out day04/input.txt

day04a.jl:
	julia day04/day04a.jl day04/input.txt
day04b.jl:
	julia day04/day04b.jl day04/input.txt


.PHONY: day05a
day05a: day05a.cpp day05a.jl
.PHONY: day05b
day05b: day05b.cpp day05b.jl
.PHONY: day05
day05: day05a day05b

day05a.cpp:
	g++ day05/day05a.cpp -o day05a.out && ./day05a.out day05/input.txt
day05b.cpp:
	g++ day05/day05b.cpp -o day05b.out && ./day05b.out day05/input.txt

day05a.jl:
	julia day05/day05a.jl day05/input.txt
day05b.jl:
	julia day05/day05b.jl day05/input.txt


.PHONY: day06a
day06a: day06a.cpp day06a.jl
.PHONY: day06b
day06b: day06b.cpp day06b.jl
.PHONY: day06
day06: day06a day06b

day06a.cpp:
	g++ day06/day06a.cpp -o day06a.out && ./day06a.out day06/input.txt
day06b.cpp:
	g++ day06/day06b.cpp -o day06b.out && ./day06b.out day06/input.txt

day06a.jl:
	julia day06/day06a.jl day06/input.txt
day06b.jl:
	julia day06/day06b.jl day06/input.txt


.PHONY: day07a
day07a: day07a.cpp day07a.jl
.PHONY: day07b
day07b: day07b.cpp day07b.jl
.PHONY: day07
day07: day07a day07b

day07a.cpp:
	g++ day07/day07a.cpp -o day07a.out && ./day07a.out day07/input.txt
day07b.cpp:
	g++ day07/day07b.cpp -o day07b.out && ./day07b.out day07/input.txt

day07a.jl:
	julia day07/day07a.jl day07/input.txt
day07b.jl:
	julia day07/day07b.jl day07/input.txt


.PHONY: day08a
day08a: day08a.cpp day08a.jl
.PHONY: day08b
day08b: day08b.cpp day08b.jl
.PHONY: day08
day08: day08a day08b

day08a.cpp:
	g++ day08/day08a.cpp -o day08a.out && ./day08a.out day08/input.txt
day08b.cpp:
	g++ day08/day08b.cpp -o day08b.out && ./day08b.out day08/input.txt

day08a.jl:
	julia day08/day08a.jl day08/input.txt
day08b.jl:
	julia day08/day08b.jl day08/input.txt


.PHONY: day09a
day09a: day09a.cpp day09a.jl
.PHONY: day09b
day09b: day09b.cpp day09b.jl
.PHONY: day09
day09: day09a day09b

day09a.cpp:
	g++ day09/day09a.cpp -o day09a.out && ./day09a.out day09/input.txt
day09b.cpp:
	g++ day09/day09b.cpp -o day09b.out && ./day09b.out day09/input.txt

day09a.jl:
	julia day09/day09a.jl day09/input.txt
day09b.jl:
	julia day09/day09b.jl day09/input.txt


.PHONY: day10a
day10a: day10a.cpp day10a.jl
.PHONY: day10b
day10b: day10b.cpp day10b.jl
.PHONY: day10
day10: day10a day10b

day10a.cpp:
	g++ day10/day10a.cpp -o day10a.out && ./day10a.out day10/input.txt
day10b.cpp:
	g++ day10/day10b.cpp -o day10b.out && ./day10b.out day10/input.txt

day10a.jl:
	julia day10/day10a.jl day10/input.txt
day10b.jl:
	julia day10/day10b.jl day10/input.txt


.PHONY: day11a
day11a: day11a.jl
.PHONY: day11b
day11b: day11b.jl
.PHONY: day11
day11: day11a day11b

day11a.jl:
	julia day11/day11a.jl day11/input.txt
day11b.jl:
	julia day11/day11b.jl day11/input.txt


.PHONY: day12a
day12a: day12a.jl
.PHONY: day12b
day12b: day12b.jl
.PHONY: day12
day12: day12a day12b

day12a.jl:
	julia day12/day12a.jl day12/input.txt
day12b.jl:
	julia day12/day12b.jl day12/input.txt


.PHONY: day13a
day13a: day13a.jl
.PHONY: day13b
day13b: day13b.jl
.PHONY: day13
day13: day13a day13b

day13a.jl:
	julia day13/day13a.jl day13/input.txt
day13b.jl:
	julia day13/day13b.jl day13/input.txt


