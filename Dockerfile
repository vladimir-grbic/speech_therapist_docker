# Use the latest stable version of Debian.
FROM debian:bullseye

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

# Create an .ssh directory with appropriate permissions.
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh

# Copy the SSH key to the container.
COPY speech_therapist_ed25519_key /root/.ssh/speech_therapist_ed25519_key

# Set appropriate permissions on the SSH key.
RUN chmod 600 /root/.ssh/speech_therapist_ed25519_key

# Add GitHub to the list of known hosts.
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Set the working directory.
WORKDIR /root/app

# Start ssh-agent, add the SSH key and clone the repository.
RUN eval $(ssh-agent -s) && \
    ssh-add /root/.ssh/speech_therapist_ed25519_key && \
    git clone git@github.com:voidlabsai/speech_therapist.git .

# Create a virtual environment and activate it.
RUN python3 -m venv venv
ENV PATH="/root/app/venv/bin:$PATH"

# Install Python dependencies within the virtual environment.
RUN pip install -r requirements.txt

# By default, start a bash shell.
CMD ["/bin/bash"]
