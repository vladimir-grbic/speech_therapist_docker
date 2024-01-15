# Use the latest stable version of Debian.
FROM debian:stable

# Set bash as the default shell.
SHELL ["/bin/bash", "-c"]

# Update the package list.
RUN apt-get update

# Set the initial working directory.
WORKDIR /workspace/docker_setup_files

# Copy the setup files into the container.
COPY docker_setup_files/* .

# Make the script executable.
RUN chmod +x install_debian_packages.sh

# Run the script to install system-wide packages.
RUN install_debian_packages.sh debian_packages.csv

# Install Python packages.
RUN pip install -r requirements.txt

# Clean up the package lists to keep the image size down.
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory.
WORKDIR /workspace

# Clone the application code.
RUN git clone https://github.com/vladimir-grbic/speech_therapist.git

# By default, start a bash shell.
CMD ["/bin/bash"]
