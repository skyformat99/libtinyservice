CC=gcc
CXX=g++
MAKE=make

CFLAGS=-rdynamic -std=c++11 -g -Wall -I.
CXXFLAGS=-rdynamic -std=c++11 -g -Wall -I.

LDFLAGS=-rdynamic -lrt -lstdc++

RM=-rm -rf

SRCS+=$(wildcard src/*.cpp)
OBJS=$(SRCS:%.cpp=%.o)
DEPENDS=$(SRCS:%.cpp=%.d)
TARGET:=libtinyservice.so
HEADER_DIR:=/usr/local/include/tinyservice


all:$(TARGET)

$(TARGET):$(OBJS)
	$(CXX) -shared -fPIC -o $@ $^ $(LDFLAGS)

$(OBJS):%.o:%.cpp
	$(CXX) -fPIC -c $< -o $@ $(CXXFLAGS)

-include $(DEPENDS)

$(DEPENDS):%.d:%.cpp
	set -e; rm -f $@; \
	echo -n $(dir $<) > $@.$$$$; \
	$(CXX) -MM $(CXXFLAGS) $< >> $@.$$$$; \
	sed 's,\($*\)\.o[:]*,\1.o $@:,g' < $@.$$$$ > $@; \
	rm $@.$$$$


clean:
	$(RM) $(OBJS) $(DEPENDS) libtinyservice.so

install:
	-mkdir $(HEADER_DIR)
	cp src/service.h src/json_service.h $(HEADER_DIR)
	cp $(TARGET) /usr/local/lib/

remove:
	-rm -rf $(HEADER_DIR)
	-rm /usr/local/lib/$(TARGET)

fake:
	echo $(OBJS)
