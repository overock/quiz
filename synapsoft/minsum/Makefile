CXXFLAGS = -std=c++11
ALL_O = minsum.o solution.o
TARGET = solution

$(TARGET): $(ALL_O)
	g++ $^ -Wall -W -o$@

clean:
	rm -rf $(ALL_O) $(TARGET)

test: $(TARGET)
	test $$(./solution 1 1) -eq 2
	test $$(./solution 1 2 4 7 9) -eq 176
	test $$(./solution 1 2 3 1 2 3) -eq 246
	test $$(./solution 1 2 3 4 5 6 7) -eq 1603
	test $$(./solution 0 1 2 3 0 1 2 3 4) -eq 11257
	test $$(./solution 0 0 1) -eq -1

.PHONY: test
