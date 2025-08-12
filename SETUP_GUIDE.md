# n8n Workflows Development Setup Guide

This guide explains how to set up and use this repository for developing n8n workflows with Claude Code and the n8n MCP integration.

## 📋 Table of Contents
- [Overview](#overview)
- [Initial Setup on Mac](#initial-setup-on-mac)
- [Repository Management](#repository-management)
- [Using with Claude Code](#using-with-claude-code)
- [n8n MCP Integration](#n8n-mcp-integration)
- [Workflow Development](#workflow-development)
- [Common Tasks](#common-tasks)

## Overview

This repository contains:
- **2,055+ n8n workflow examples** organized by service/integration
- **n8n MCP integration** for direct workflow management
- **Fast documentation system** for searching and browsing workflows
- **Development tools** for creating and testing n8n workflows

## Initial Setup on Mac

### Prerequisites
1. **Install Claude Code Desktop**
   - Download from: https://claude.ai/download
   - Sign in with your Anthropic account

2. **Install Required Tools**
   ```bash
   # Install Homebrew if not already installed
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   
   # Install Git
   brew install git
   
   # Install GitHub CLI
   brew install gh
   
   # Install Python 3
   brew install python3
   
   # Install Docker Desktop
   brew install --cask docker
   ```

3. **Configure GitHub CLI**
   ```bash
   gh auth login
   # Follow prompts to authenticate with GitHub
   ```

### Clone and Setup Repository

1. **Clone the repository**
   ```bash
   cd ~/
   git clone https://github.com/youngescape/n8n-workflows.git
   cd n8n-workflows
   ```

2. **Set up Git remotes**
   ```bash
   # Your fork is already set as 'origin'
   # Add the original repo as 'upstream' for updates
   git remote add upstream https://github.com/Zie619/n8n-workflows.git
   ```

3. **Configure n8n API credentials**
   ```bash
   # Copy the example environment file
   cp .env.example .env
   
   # Edit .env and add your n8n API key
   # Get your API key from: https://agent.blurtai.xyz/settings
   nano .env
   ```
   
   Add your credentials:
   ```
   N8N_API_URL=https://agent.blurtai.xyz
   N8N_API_KEY=your_actual_api_key_here
   ```

4. **Install Python dependencies**
   ```bash
   pip3 install -r requirements.txt
   ```

5. **Start the documentation server**
   ```bash
   python3 run.py
   # Access at http://localhost:8000
   ```

## Repository Management

### Pushing Your Changes
```bash
# Make your changes
git add .
git commit -m "feat: your change description"
git push origin main
```

### Getting Updates from Original Repository
```bash
# Fetch updates from upstream
git fetch upstream

# Merge updates (use --allow-unrelated-histories if needed)
git merge upstream/main --allow-unrelated-histories

# Push merged changes to your fork
git push origin main
```

### Important Files
- `.env` - Your local API credentials (NEVER commit this)
- `.env.example` - Template for environment variables
- `CLAUDE.md` - Instructions for Claude Code
- `n8n-mcp-wrapper.sh` - MCP Docker wrapper script

## Using with Claude Code

### Opening in Claude Code
1. Open Claude Code Desktop
2. Use Command+O (Mac) to open folder
3. Navigate to `~/n8n-workflows`
4. Claude will automatically read `CLAUDE.md` for context

### Claude Code Commands for n8n Development

Ask Claude to:
- **Search workflows**: "Find all Telegram bot workflows"
- **Analyze workflows**: "Show me how the RSS to Telegram workflow works"
- **Create workflows**: "Create a workflow that posts to Discord when a GitHub issue is created"
- **Modify workflows**: "Add error handling to this workflow"
- **Test workflows**: "Test this workflow with sample data"

### MCP Integration Commands

Claude can directly interact with your n8n instance:
```
"List my active workflows"
"Create a new workflow for [task]"
"Update workflow ID xyz"
"Execute workflow abc with test data"
```

## n8n MCP Integration

### How MCP Works
1. **MCP Server**: Runs in Docker container
2. **API Connection**: Uses your n8n API key from `.env`
3. **Claude Integration**: Claude Code can directly manage workflows

### Testing MCP Connection
```bash
# Test the MCP wrapper script
./n8n-mcp-wrapper.sh
# Should connect without errors
```

### MCP Capabilities
- List all workflows
- Get workflow details
- Create new workflows
- Update existing workflows
- Execute workflows
- Manage credentials
- Access execution history

## Workflow Development

### Creating New Workflows

1. **Using Claude Code**:
   ```
   "Create a workflow that:
   - Triggers daily at 9am
   - Fetches data from Google Sheets
   - Processes with OpenAI
   - Sends results to Slack"
   ```

2. **Using Examples**:
   - Browse existing workflows in `workflows/` directory
   - Search using the documentation server
   - Copy and modify similar workflows

### Testing Workflows

1. **Local Testing**:
   ```bash
   # Start documentation server
   python3 run.py
   
   # Browse to http://localhost:8000
   # Search and download workflow JSONs
   ```

2. **n8n Instance Testing**:
   - Import workflow JSON to n8n
   - Configure credentials
   - Use Test Workflow feature

### Best Practices

1. **Security**:
   - Never commit API keys or credentials
   - Use environment variables
   - Review workflows before importing

2. **Organization**:
   - Name workflows descriptively
   - Use folders by service/integration
   - Document complex logic

3. **Version Control**:
   - Commit workflow changes regularly
   - Use meaningful commit messages
   - Tag stable versions

## Common Tasks

### Search for Workflows
```bash
# Using API
curl "http://localhost:8000/api/workflows?q=telegram"

# Using Python
python3 -c "from workflow_db import WorkflowDB; db = WorkflowDB(); print(db.search('telegram'))"
```

### Export Workflow from n8n
1. Open workflow in n8n editor
2. Menu → Download
3. Save to `workflows/` directory
4. Remove sensitive data
5. Commit to repository

### Import Workflow to n8n
1. Open n8n editor
2. Menu → Import from File
3. Select workflow JSON
4. Configure credentials
5. Test before activating

### Update Documentation
```bash
# Reindex all workflows
python3 workflow_db.py --index --force

# Start server to view
python3 run.py
```

## Troubleshooting

### MCP Connection Issues
```bash
# Check Docker is running
docker ps

# Test API key
curl -H "X-N8N-API-KEY: $N8N_API_KEY" https://agent.blurtai.xyz/api/v1/workflows

# Check environment variables
echo $N8N_API_KEY
```

### Git Issues
```bash
# If push is rejected due to secrets
# Check for sensitive data in files
grep -r "api_key\|token\|secret" workflows/

# Reset to clean state if needed
git reset --hard HEAD
```

### Python/Server Issues
```bash
# Reinstall dependencies
pip3 install -r requirements.txt --upgrade

# Check Python version (needs 3.7+)
python3 --version

# Run with debug mode
python3 run.py --debug
```

## Advanced Usage

### Batch Operations
```python
# Create Python script for batch operations
from workflow_db import WorkflowDB
import json

db = WorkflowDB()

# Find all Telegram workflows
telegram_workflows = db.search("telegram")

# Export results
with open("telegram_workflows.json", "w") as f:
    json.dump(telegram_workflows, f, indent=2)
```

### Custom Categories
Edit `context/def_categories.json` to add new service mappings:
```json
{
  "Communication & Messaging": ["telegram", "discord", "slack"],
  "AI & Machine Learning": ["openai", "anthropic", "huggingface"]
}
```

### Automation Scripts
Create scripts in `scripts/` directory for common tasks:
```bash
#!/bin/bash
# scripts/backup-workflows.sh
tar -czf "backup-$(date +%Y%m%d).tar.gz" workflows/
```

## Support and Resources

### Documentation
- n8n Docs: https://docs.n8n.io
- n8n Community: https://community.n8n.io
- Claude Code: https://claude.ai/code

### Getting Help
1. Check existing workflows for examples
2. Search documentation at http://localhost:8000
3. Ask Claude Code for assistance
4. Post in n8n community forum

### Contributing
1. Create new workflows
2. Improve documentation
3. Add service categories
4. Report issues on GitHub

---

## Quick Reference Card

### Essential Commands
```bash
# Start documentation server
python3 run.py

# Search workflows
curl "http://localhost:8000/api/workflows?q=search_term"

# Push changes
git add . && git commit -m "message" && git push origin main

# Get updates
git fetch upstream && git merge upstream/main

# Test MCP
./n8n-mcp-wrapper.sh
```

### File Structure
```
n8n-workflows/
├── .env                 # Your API credentials (local only)
├── .env.example         # Template for credentials
├── CLAUDE.md           # Claude Code instructions
├── SETUP_GUIDE.md      # This file
├── workflows/          # 2,055+ workflow examples
├── Documentation/      # Category docs
├── run.py             # Start documentation server
└── n8n-mcp-wrapper.sh # MCP integration script
```

### Environment Variables
```bash
N8N_API_URL=https://agent.blurtai.xyz
N8N_API_KEY=your_api_key_here
```

---

Last Updated: 2025-01-12
Version: 1.0.0