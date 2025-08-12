#!/bin/bash
# MCP wrapper script for n8n Docker container

# Load environment variables from .env file if it exists
if [ -f "$(dirname "$0")/.env" ]; then
  export $(cat "$(dirname "$0")/.env" | grep -v '^#' | xargs)
fi

# Check if API key is set
if [ -z "$N8N_API_KEY" ]; then
  echo "Error: N8N_API_KEY not set. Please set it in .env file or as environment variable." >&2
  exit 1
fi

docker run -i --rm \
  -e MCP_MODE=stdio \
  -e LOG_LEVEL=error \
  -e DISABLE_CONSOLE_OUTPUT=true \
  -e N8N_API_URL="${N8N_API_URL:-https://agent.blurtai.xyz}" \
  -e N8N_API_KEY="$N8N_API_KEY" \
  ghcr.io/czlonkowski/n8n-mcp:latest