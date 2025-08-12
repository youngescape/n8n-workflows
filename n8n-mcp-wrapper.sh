#!/bin/bash
# MCP wrapper script for n8n Docker container

docker run -i --rm \
  -e MCP_MODE=stdio \
  -e LOG_LEVEL=error \
  -e DISABLE_CONSOLE_OUTPUT=true \
  -e N8N_API_URL=https://agent.blurtai.xyz \
  -e N8N_API_KEY=YOUR_N8N_API_KEY_HERE \
  ghcr.io/czlonkowski/n8n-mcp:latest