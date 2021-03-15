COMPILER  = g++
CFLAGS    = -g -std=c++17 -O3 -MMD -MP -Wall -Wextra -Winit-self -Wno-missing-field-initializers
LDFLAGS   = -L./lib

LIBS      = 
INCLUDE   = -I./include
TARGET    = ./$(shell basename `readlink -f .`)
SRCDIR    = ./src

SOURCES   = $(wildcard $(SRCDIR)/*.cpp)
OBJDIR    = ./obj
OBJECTS   = $(addprefix $(OBJDIR)/, $(notdir $(SOURCES:.cpp=.o)))
DEPENDS   = $(OBJECTS:.o=.d)

$(TARGET): $(OBJECTS) $(LIBS)
	$(COMPILER) -o $@ $^ $(LDFLAGS)

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	-mkdir -p $(OBJDIR)
	$(COMPILER) $(CFLAGS) $(INCLUDE) -o $@ -c $<

all: clean $(TARGET)

clean:
	-rm -f $(OBJECTS) $(DEPENDS) $(TARGET)

-include $(DEPENDS)
