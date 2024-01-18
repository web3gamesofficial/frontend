#!/bin/bash

# download assets for the running instance
dotenv \
  -e .env.development.local \
  -e .env.local \
  -e .env.development \
  -e .env \
  -- bash -c './deploy/scripts/download_assets.sh ./public/assets'

yarn svg:build-sprite
echo ""

# -v NEXT_PUBLIC_GIT_COMMIT_SHA=$(git rev-parse --short HEAD) \
# -v NEXT_PUBLIC_GIT_TAG=$(git describe --tags --abbrev=0) \

# generate envs.js file and run the app
dotenv \
  -v NEXT_PUBLIC_GIT_COMMIT_SHA=f00ec38f \
  -v NEXT_PUBLIC_GIT_TAG=v1.21.2 \
  -e .env.secrets \
  -e .env.development.local \
  -e .env.local \
  -e .env.development \
  -e .env \
  -- bash -c './deploy/scripts/make_envs_script.sh && next dev -- -p $NEXT_PUBLIC_APP_PORT' |
pino-pretty