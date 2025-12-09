#!/bin/bash

# Handle -re flag
if [ "$1" = "-re" ]
then
	# Delete known files
	rm -f Makefile main.cpp

	# Skip first argument (-re)
	shift

	for i in $@
	do
		CLASS_NAME=${i^}
		rm -f ${CLASS_NAME}.cpp ${CLASS_NAME}.hpp
	done
fi

# Validates if the user input any class name
if [[ "$#" -eq "0" ]] # Argument count equals 0
then
	echo "Usage: ./cppgen <ClassName> [ClassName2, ...]"
	echo "No arguments were specified. Exiting..."
	exit 1
fi

# Asks for a program name
while [ -z "$PROGRAM_NAME" ] # -z: empty string
do
	echo "Type the program name (type exit to quit)"
	read PROGRAM_NAME
	if [ -z "$PROGRAM_NAME" ]
	then
		echo "Please insert a valid program name"
	elif [ "$PROGRAM_NAME" = "exit" ]
	then
		exit 0
	fi
done

# Create the Makefile if it not exists
if [ ! -f "./Makefile" ]
then
cat > Makefile << EOF
CC			:= c++
CFLAGS		:= -Wall -Wextra -Werror -std=c++98

BUILD_DIR	:= build

SRCS :=	\$(wildcard *.cpp)
OBJS := \$(patsubst %.cpp, \$(BUILD_DIR)/%.o, \$(SRCS))

NAME := $PROGRAM_NAME

all: \$(NAME)

\$(NAME): \$(OBJS)
	\$(CC) \$(CFLAGS) \$^ -o \$@

\$(BUILD_DIR)/%.o: %.cpp
	@mkdir -p \$(BUILD_DIR)
	\$(CC) \$(CFLAGS) -c \$< -o \$@

clean:
	rm -rf \$(BUILD_DIR)

fclean: clean
	rm -f \$(NAME)

re: fclean all

.PHONY: all clean fclean re
EOF
	echo "Makefile created!"
else
	echo "Makefile already exists."
fi


# Create main.cpp file
if [ ! -f "main.cpp" ]
then
cat > main.cpp << EOF

#include <iostream>

int	main(void)
{
	return (0);
}
EOF
	echo "main.cpp created!"
else
	echo "main.cpp already exists."
fi


# loop through the filenames creating a .cpp and a .hpp file for each
for i in $@
do
	CLASS_NAME=${i^}

	# .cpp file
	if [ ! -f "./${CLASS_NAME}.cpp" ]
	then
cat > ${CLASS_NAME}.cpp << EOF

#include "${CLASS_NAME}.hpp"
#include <iostream>

${CLASS_NAME}::${CLASS_NAME}(void)
{
	std::cout << "${CLASS_NAME} default constructor called." << std::endl;
}

${CLASS_NAME}::${CLASS_NAME}(${CLASS_NAME} const &other)
{
	(void) other;
	std::cout << "${CLASS_NAME} copy constructor called." << std::endl;
}

${CLASS_NAME}::~${CLASS_NAME}(void)
{
	std::cout << "${CLASS_NAME} destructor called." << std::endl;
}

${CLASS_NAME}	&${CLASS_NAME}::operator=(${CLASS_NAME} const &other)
{
	if (this != &other)
	{
		// ...
	}

	std::cout << "${CLASS_NAME} copy assignment operator called." << std::endl;
	return (*this);
}
EOF
		echo "${CLASS_NAME}.cpp file created!"
	else
		echo "${CLASS_NAME}.cpp already exists."
	fi

	# .hpp file
	if [ ! -f "./${CLASS_NAME}.hpp" ]
	then
cat > ${CLASS_NAME}.hpp << EOF

#ifndef ${CLASS_NAME^^}_HPP
# define ${CLASS_NAME^^}_HPP

class ${CLASS_NAME}
{
private:
	// ...
public:
	${CLASS_NAME}(void);
	// Insert parametized constructor here
	${CLASS_NAME}(${CLASS_NAME} const &other);
	~${CLASS_NAME}(void);
	${CLASS_NAME}	&operator=(${CLASS_NAME} const &other);
};

#endif
EOF
		echo "${CLASS_NAME}.hpp file created!"
	else
		echo "${CLASS_NAME}.hpp already exists."
	fi

done
