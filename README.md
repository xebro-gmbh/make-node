# Node Bundle

The Node bundle provides a Dockerised frontend runtime that executes whatever toolchain your project defines in its `package.json`. It is part of the public `docker/` distribution and **depends on** `docker/core` to expose its Make targets.

## Core Principles

- **Development only** – The image trades security and size for convenience (sudo access, editors, caches kept on disk). Do not deploy it to production.
- **Attach to the core** – Targets such as `node.install` and `node.bash` are exposed through the root `Makefile` once `docker/core` is in place.
- **Work inside the container** – Daily commands (`npm install`, `npm run dev`, etc.) are executed via `make` so that your CI/CD pipelines can reuse the same workflow.

## Installation & Usage

1. Install the core bundle (see `docker/core/README.md`) and ensure your root `Makefile` points to it.
2. From the project root run:
   ```bash
   make node.install   # ensure env vars and gitignore snippets
   make node.init      # run npm install inside the container
   make start          # starts the shared Compose stack (Node exposes port 3000)
   ```
3. Open `http://localhost:3000` to access whatever dev server your project exposes via `npm run dev`.

You can inspect the service with `make node.logs` or drop into the container via `make node.bash`.

## Key Targets

- `node.install` – Add bundle-specific environment variables and `.gitignore` entries through the core helpers.
- `node.init` – Run `npm install` inside the container to populate `node_modules`.
- `node.run TARGET=<script>` – Execute an arbitrary npm script (`make node.run TARGET=test`).
- `node.build` – Run `npm run build` in the container.
- `node.clean` – Remove caches (`.npm`, `.cache`, `node_modules`) from the mounted working tree.
- `node.logs`, `node.restart`, `node.docker.build` – Operational helpers for the Compose service.

The Docker service simply runs `npm run dev --host 0.0.0.0`, so whatever dev server script you define in your root `package.json` is what will execute inside the container. Because every command flows through `docker/core`, you can always list the available ones with `make help`.

## License

This make bundle is provided under the MIT License. See the [LICENSE](./LICENSE) file for details.

Part of the [make-core](https://github.com/xebro-gmbh/make-core) system.

Copyright (c) 2025 xebro GmbH
