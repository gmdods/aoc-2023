.PHONY: all
all: day1 day2 day3 day4 day5 day6

clean:
	rm *.out

.PHONY: day1a
day1a: day1a.cpp day1a.jl day1a.d day1a.ml
.PHONY: day1b
day1b: day1b.cpp day1b.jl day1b.d day1b.ml
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

day1a.d:
	rdmd day1a/day1a.d day1/input.txt
day1b.d:
	rdmd day1b/day1b.d day1/input.txt

day1a.ml:
	ocaml day1a/day1a.ml day1/input.txt
day1b.ml:
	ocaml day1b/day1b.ml day1/input.txt


.PHONY: day2a
day2a: day2a.cpp day2a.jl day2a.ml
.PHONY: day2b
day2b: day2b.cpp day2b.jl day2b.ml
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

day2a.ml:
	ocaml day2a/day2a.ml day2/input.txt
day2b.ml:
	ocaml day2b/day2b.ml day2/input.txt


.PHONY: day3a
day3a: day3a.cpp day3a.jl day3a.ml
.PHONY: day3b
day3b: day3b.cpp day3b.jl day3b.ml
.PHONY: day3
day3: day3a day3b

day3a.cpp:
	g++ day3a/day3a.cpp -o day3a.out && ./day3a.out day3/input.txt
day3b.cpp:
	g++ day3b/day3b.cpp -o day3b.out && ./day3b.out day3/input.txt

day3a.jl:
	julia day3a/day3a.jl day3/input.txt
day3b.jl:
	julia day3b/day3b.jl day3/input.txt

day3a.ml:
	ocaml day3a/day3a.ml day3/input.txt
day3b.ml:
	ocaml day3b/day3b.ml day3/input.txt


.PHONY: day4a
day4a: day4a.cpp day4a.jl
.PHONY: day4b
day4b: day4b.cpp day4b.jl
.PHONY: day4
day4: day4a day4b

day4a.cpp:
	g++ day4a/day4a.cpp -o day4a.out && ./day4a.out day4/input.txt
day4b.cpp:
	g++ day4b/day4b.cpp -o day4b.out && ./day4b.out day4/input.txt

day4a.jl:
	julia day4a/day4a.jl day4/input.txt
day4b.jl:
	julia day4b/day4b.jl day4/input.txt


.PHONY: day5a
day5a: day5a.cpp day5a.jl
.PHONY: day5b
day5b: day5b.cpp day5b.jl
.PHONY: day5
day5: day5a day5b

day5a.cpp:
	g++ day5a/day5a.cpp -o day5a.out && ./day5a.out day5/input.txt
day5b.cpp:
	g++ day5b/day5b.cpp -o day5b.out && ./day5b.out day5/input.txt

day5a.jl:
	julia day5a/day5a.jl day5/input.txt
day5b.jl:
	julia day5b/day5b.jl day5/input.txt


.PHONY: day6a
day6a: day6a.cpp day6a.jl
.PHONY: day6b
day6b: day6b.cpp day6b.jl
.PHONY: day6
day6: day6a day6b

day6a.cpp:
	g++ day6a/day6a.cpp -o day6a.out && ./day6a.out day6/input.txt
day6b.cpp:
	g++ day6b/day6b.cpp -o day6b.out && ./day6b.out day6/input.txt

day6a.jl:
	julia day6a/day6a.jl day6/input.txt
day6b.jl:
	julia day6b/day6b.jl day6/input.txt


.PHONY: day7a
day7a: day7a.cpp day7a.jl
.PHONY: day7b
day7b: day7b.cpp day7b.jl
.PHONY: day7
day7: day7a day7b

day7a.cpp:
	g++ day7a/day7a.cpp -o day7a.out && ./day7a.out day7/input.txt
day7b.cpp:
	g++ day7b/day7b.cpp -o day7b.out && ./day7b.out day7/input.txt

day7a.jl:
	julia day7a/day7a.jl day7/input.txt
day7b.jl:
	julia day7b/day7b.jl day7/input.txt


.PHONY: day8a
day8a: day8a.cpp day8a.jl
.PHONY: day8b
day8b: day8b.cpp day8b.jl
.PHONY: day8
day8: day8a day8b

day8a.cpp:
	g++ day8a/day8a.cpp -o day8a.out && ./day8a.out day8/input.txt
day8b.cpp:
	g++ day8b/day8b.cpp -o day8b.out && ./day8b.out day8/input.txt

day8a.jl:
	julia day8a/day8a.jl day8/input.txt
day8b.jl:
	julia day8b/day8b.jl day8/input.txt


.PHONY: day9a
day9a: day9a.cpp day9a.jl
.PHONY: day9b
day9b: day9b.cpp day9b.jl
.PHONY: day9
day9: day9a day9b

day9a.cpp:
	g++ day9a/day9a.cpp -o day9a.out && ./day9a.out day9/input.txt
day9b.cpp:
	g++ day9b/day9b.cpp -o day9b.out && ./day9b.out day9/input.txt

day9a.jl:
	julia day9a/day9a.jl day9/input.txt
day9b.jl:
	julia day9b/day9b.jl day9/input.txt


.PHONY: day10a
day10a: day10a.cpp day10a.jl
.PHONY: day10b
day10b: day10b.cpp day10b.jl
.PHONY: day10
day10: day10a day10b

day10a.cpp:
	g++ day10a/day10a.cpp -o day10a.out && ./day10a.out day10/input.txt
day10b.cpp:
	g++ day10b/day10b.cpp -o day10b.out && ./day10b.out day10/input.txt

day10a.jl:
	julia day10a/day10a.jl day10/input.txt
day10b.jl:
	julia day10b/day10b.jl day10/input.txt


