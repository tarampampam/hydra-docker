# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][keepachangelog] and this project adheres to [Semantic Versioning][semver].

## v1.0.0

### Changed

- Docker build on **github** side (not `hub.docker.com`)
- One dockerfile for different `hydra` versions

### Added

- GitHub actions for tests and releasing
- Image for version `9.1`
- "Light" version on images (with postfix `-light`) without username/password lists

### Removed

- `latest` tag

[keepachangelog]:https://keepachangelog.com/en/1.0.0/
[semver]:https://semver.org/spec/v2.0.0.html
