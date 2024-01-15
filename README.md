# README

## Building the Docker Image

From this repository, run the following command:

```bash
docker build -t speech_therapist_image .
```

Note: `-t` tags your image, and `.` indicates Docker should use the Dockerfile
in the current directory.

## Running the Container with Persistent Storage

You can run your container with a Docker volume for persistent file storage.
This can be either a named volume (managed by Docker) or a bind mount (a
specific directory on your host).

1. **Using a Named Volume**:

   ```bash
   docker run -it -v speech_therapist_volume:/data speech_therapist_image
   ```

   This command creates a volume named `speech_therapist_volume` and mounts it
   to `/data` inside the container.

2. **Using a Bind Mount**:

   ```bash
   docker run -it -v /path/on/your/host:/data speech_therapist_image
   ```

   Replace `/path/on/your/host` with the path on your host machine. This mounts
   the host directory to `/data` in the container.

## Interacting with the Container

Once the container starts, you can interact with it based on the specifications
of your Dockerfile. Files created or modified in `/workspace` will persist.

## Stopping and Restarting the Container

- To exit the container, type `exit` if in interactive mode.

- To stop the container:

  ```bash
  docker stop [container-name or container-id]
  ```

- To restart and access persistent data:

  ```bash
  docker start -ai [container-name or container-id]
  ```
