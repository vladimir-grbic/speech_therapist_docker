# Use the latest stable version of Debian.
FROM debian:stable

# Set bash as the default shell.
SHELL ["/bin/bash", "-c"]

# Update the package list.
RUN apt-get update

# Create a temporary directory for installation.
RUN mkdir /temp_setup_files

# Copy the setup files into the container.
COPY setup_files/* /temp_setup_files

# Make the script executable.
RUN chmod +x /temp_setup_files/install_debian_packages.sh

# Run the script to install system-wide packages.
RUN sh /temp_setup_files/install_debian_packages.sh /temp_setup_files/debian_packages.csv

# Remove the temporary installation files.
RUN rm -rf /temp_setup_files

# Clean up the package lists to keep the image size down.
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory.
WORKDIR /app

# Clone the application code.
RUN git clone https://github.com/vladimir-grbic/speech_therapist.git .

# Create a virtual environment and activate it
RUN python -m venv venv
ENV PATH="/app/venv/bin:$PATH"

# Install Python dependencies within the virtual environment.
RUN pip install -r requirements.txt

# By default, start a bash shell.
CMD ["/bin/bash"]
