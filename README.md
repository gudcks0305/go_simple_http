# Streaming Service Prototype

This repository provides a starting point for a small streaming platform. It is split into two main components:

* `server/` – Go based backend with SQLite for persistence
* `client/` – (future) Flutter application for cross‑platform access

## Current Features

* REST API built with Gin
* SQLite database using GORM

```
GET  /streams    # list all streams
POST /streams    # create a new stream
```

## Planned Tasks

1. **User management** – allow authentication and ownership of streams.
2. **Streaming endpoints** – integrate actual video streaming (RTMP/HLS) with Dockerised media servers.
3. **Flutter client** – build a UI similar to Twitch/Chzzk.
4. **Deployment** – containerize with Docker and provide CI workflow.

This code is only a foundation. Extend it as needed for a full streaming experience.
