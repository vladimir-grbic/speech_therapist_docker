## Setup

This process requires you to generate an SSH key to be used with your Docker
instance. To accomplish that, please do the following.

- Ensure that the `.ssh` directory exists before generating SSH keys.

  ```bash
  mkdir -p ~/.ssh
  ```

- Generate the key. Please replace the example email address with your actual
  address. Do **not** change the key name (and path) as Dockerfile expects it to
  be named as is in the command below.

  ```bash
  ssh-keygen -t ed25519 -f ~/.ssh/speech_therapist_ed25519_key -C "your.email@example.com"
  ```

- Display the contents of your public key, copy it and [add it to
GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

  ```
  cat ~/.ssh/speech_therapist_ed25519_key.pub
  ```

## Building the Docker Image

From this repository, execute either of the following commands.

- First, copy the newly generated SSH key to the current directory.

  ```bash
  cp ~/.ssh/speech_therapist_ed25519_key .
  ```

- Build the image.

  ```bash
  docker buildx build -t speech_therapist_image .
  ```

  Note: `-t` tags your image, and `.` indicates Docker should use the Dockerfile
  in the current directory.

- Remove the key from this repository.

  ```bash
  rm speech_therapist_ed25519_key
  ```

## Running the Container with Persistent Storage

You can run your container with a Docker volume for persistent file storage.
This can be either a named volume (managed by Docker) or a bind mount (a
specific directory on your host).

- **Using a Named Volume**

  Run:

  ```bash
  docker run -it -v speech_therapist_volume:/root speech_therapist_image
  ```

  This command creates a volume named `speech_therapist_volume` and mounts it
  to `/root` inside the container.

- **Using a Bind Mount**

  Run:

  ```bash
  docker run -it -v /path/on/your/host:/root speech_therapist_image
  ```

  Replace `/path/on/your/host` with the path on your host machine. This mounts
  the host directory to `/root` in the container.

## Stopping and Restarting the Container

- To exit the container, type `exit` if in interactive mode.

- To stop the container, run:

  ```bash
  docker stop [container-name or container-id]
  ```

- To restart and access persistent data, run:

  ```bash
  docker start -ai [container-name or container-id]
  ```
## Interacting with the Container

Once the container starts, you can interact with it based on the specifications
of your Dockerfile. Files created or modified in `/root` will persist.

Docker [CLI Cheat Sheet](https://docs.docker.com/get-started/docker_cheatsheet.pdf)
demonstrates a lot of useful commands to get you going.
