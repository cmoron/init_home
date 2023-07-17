FROM ubuntu:latest

# Install git
RUN apt-get update && apt-get install -y git

# Create an unprivileged user and switch to it
RUN useradd -m tester
USER tester
WORKDIR /home/tester

# Copy the script
COPY init_home.sh ./

# Run the script
CMD ["bash", "./init_home.sh"]
