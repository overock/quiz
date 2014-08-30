TARGET = filter
CXXFLAGS = -std=c++11 -Wall -W
LIBS = -ltinyxml2
ALL_O = filter.o XMLTraverser.o Action.o ActionShape.o Shape.o

$(TARGET): $(ALL_O)
	g++ $(CXXFLAGS) $^ $(LIBS) -o$@

clean:
	rm -rf $(ALL_O) $(TARGET)

test: $(TARGET)
	test "$$(./$(TARGET) "" alice.xml)" = "Alice Adventures In Wonderland"
	test "$$(./$(TARGET) i alice.xml)" = "Alice"
	test "$$(./$(TARGET) s alice.xml)" = "Adventures In Wonderland"
	test "$$(./$(TARGET) bs alice.xml)" = "In Wonderland"
	test "$$(./$(TARGET) sbu alice.xml)" = "Wonderland"
	test -z "$$(./$(TARGET) isbu alice.xml)"

