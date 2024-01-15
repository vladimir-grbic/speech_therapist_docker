#!/bin/bash

########################
# Function Definitions #
########################

install_packages () {
	# Expects one argument, a CSV file that contains list of packages to be
	# installed.

	packages=$1

	if [ -z "${packages}" ]; then
		echo "No packages provided."
		echo "Exiting..."
		exit 1
	fi

	# Loop through the package list, installing each with an appropriate method.
	# NOTE: The IFS (Internal Field Separator) is an environment variable.
	while IFS="," read -r package_name description
	do
		# Check if the mandatory fields are set.
		if [ -z "${package_name}" ]; then
			echo "The package name field in '"${file}"' was found empty."
			echo "Please, use the proper format! Operation failed."
			exit 1
		fi

		echo "Now installing:"${package_name}""

		install_command="apt-get install -y"

		# Install the package.
		${install_command} ${package_name} | sed "s/^/\t/g"
	done < "${packages}"
}

###################
# Main procedures #
###################

# Record the CSV file containing packages to be installed.
file=$1

# Exit if the input file is not fount.
if [ ! -f "${file}" ]; then
	echo "File not found: "${file}""
	exit 1
fi

echo "Installing Debian packages."

# Install the packages.
install_packages "${temp_file}"
