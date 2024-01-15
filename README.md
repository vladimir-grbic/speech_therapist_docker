## Building the Docker Image

From this repository, execute either of the following commands.

- **Using Docker Buildx (Recommended)**

  Docker `buildx` provides enhanced build performance with additional features.
  To build with `buildx`, run:

  ```bash
  docker buildx build -t speech_therapist_image .
  ```
- **Using Legacy Docker Build**

  If you prefer using the standard build process, execute:

  ```bash
  docker build -t speech_therapist_image .
  ```

Note: `-t` tags your image, and `.` indicates Docker should use the Dockerfile
in the current directory.

## Running the Container with Persistent Storage

You can run your container with a Docker volume for persistent file storage.
This can be either a named volume (managed by Docker) or a bind mount (a
specific directory on your host).

- **Using a Named Volume**

  Run:

  ```bash
  docker run -it -v speech_therapist_volume:/app speech_therapist_image
  ```

  This command creates a volume named `speech_therapist_volume` and mounts it
  to `/app` inside the container.

- **Using a Bind Mount**

  Run:

  ```bash
  docker run -it -v /path/on/your/host:/app speech_therapist_image
  ```

  Replace `/path/on/your/host` with the path on your host machine. This mounts
  the host directory to `/app` in the container.

## Interacting with the Container

Once the container starts, you can interact with it based on the specifications
of your Dockerfile. Files created or modified in `/app` will persist.

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
