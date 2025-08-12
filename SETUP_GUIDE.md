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

### 🎯 Leveraging the 2,055+ Example Workflows

The power of this repository is the massive collection of pre-built workflows from https://github.com/Zie619/n8n-workflows. Here's how to use them effectively:

#### Finding the Right Example

1. **Start the Documentation Server**:
   ```bash
   python3 run.py
   # Opens at http://localhost:8000
   ```

2. **Search Strategies**:
   - **By Service**: Search "telegram", "discord", "openai", etc.
   - **By Trigger Type**: Filter by Webhook, Scheduled, Manual
   - **By Complexity**: Low (≤5 nodes), Medium (6-15), High (16+)
   - **By Integration Combo**: "telegram openai" for AI bots

3. **Example Searches**:
   ```bash
   # Find all Telegram bots
   curl "http://localhost:8000/api/workflows?q=telegram"
   
   # Find scheduled data syncs
   curl "http://localhost:8000/api/workflows?trigger=Scheduled&q=sync"
   
   # Find OpenAI integrations
   curl "http://localhost:8000/api/workflows?q=openai"
   ```

#### Using Examples as Templates

1. **Find Similar Workflow**:
   ```
   Ask Claude: "Find workflows that post to Discord when something happens"
   Claude will search the 2,055 examples and show relevant ones
   ```

2. **Copy and Modify Pattern**:
   ```
   Original: Telegram bot that responds to messages
   Your need: Discord bot that responds to messages
   
   Claude can:
   - Take the Telegram workflow structure
   - Replace Telegram nodes with Discord nodes
   - Keep the same logic flow
   - Deploy to your n8n
   ```

3. **Combine Multiple Examples**:
   ```
   Example 1: RSS to Telegram (scheduled fetch + send)
   Example 2: OpenAI text processing
   Combined: RSS → OpenAI Summary → Telegram
   ```

### Creating New Workflows (Step-by-Step)

#### Method 1: Claude Code Automation (Recommended)

1. **Describe Your Need**:
   ```
   "I need a workflow that:
   - Monitors my Gmail for invoices
   - Extracts data from PDFs
   - Adds to Google Sheets
   - Sends Slack notification"
   ```

2. **Claude Will**:
   - Search the 2,055 workflows for similar patterns
   - Find: Gmail trigger examples, PDF extraction examples, Sheets examples
   - Combine the patterns into your custom workflow
   - Deploy directly to your n8n via MCP

#### Method 2: Manual with Examples

1. **Search for Components**:
   ```bash
   # Find Gmail workflows
   python3 -c "from workflow_db import WorkflowDB; db = WorkflowDB(); results = db.search('gmail'); print(f'Found {len(results)} Gmail examples')"
   
   # Find PDF extraction workflows
   curl "http://localhost:8000/api/workflows?q=pdf+extract"
   ```

2. **Download Example JSONs**:
   ```bash
   # Download specific workflow
   curl "http://localhost:8000/api/workflows/0828_Extractfromfile_Gmail_Send_Triggered.json/download" -o gmail_pdf_example.json
   ```

3. **Merge Patterns**:
   - Open examples in n8n editor
   - Copy nodes you need
   - Connect them in your workflow
   - Adjust parameters

### Real-World Example Usage

#### Scenario: Create a Customer Support Bot

1. **Find Relevant Examples**:
   ```
   Claude searches and finds:
   - 1941_Telegram_Stickynote_Automate_Triggered.json (Telegram echo bot)
   - 0419_Telegram_Automate_Triggered.json (Telegram with OpenAI)
   - 1001_Telegram_Stickynote_Automation_Triggered.json (MCP Client example)
   ```

2. **Extract Patterns**:
   - **Trigger**: Telegram webhook receiver
   - **Processing**: OpenAI for understanding intent
   - **Logic**: Switch node for routing responses
   - **Response**: Send back to Telegram

3. **Customize**:
   - Add your custom prompts
   - Include your knowledge base
   - Add logging to Google Sheets
   - Include error notifications

4. **Deploy**:
   ```
   Claude uses MCP to:
   - Create the workflow in your n8n
   - Set up the webhook URL
   - Configure test data
   ```

### Workflow Categories & Common Patterns

The repository includes examples for:

#### Communication (450+ workflows)
- Telegram bots, Discord notifications, Slack alerts
- **Pattern**: Trigger → Process → Send
- **Example**: `0751_Openweathermap_Telegram_Automate_Triggered.json`

#### Data Processing (300+ workflows)
- ETL pipelines, data transformation, aggregation
- **Pattern**: Fetch → Transform → Store
- **Example**: `0472_Aggregate_Gmail_Create_Triggered.json`

#### AI/ML Integration (200+ workflows)
- OpenAI, ChatGPT, image generation
- **Pattern**: Input → AI Process → Output
- **Example**: `1375_Telegram_Automate_Triggered.json`

#### Scheduled Automation (226 workflows)
- Daily reports, backups, monitoring
- **Pattern**: Schedule → Action → Notify
- **Example**: `0748_Noop_Telegram_Automation_Scheduled.json`

### Advanced Workflow Creation

#### Batch Creation from Examples
```python
# Script to find and modify multiple workflows
from workflow_db import WorkflowDB
import json

db = WorkflowDB()

# Find all Discord notification workflows
discord_workflows = db.search("discord notification")

for workflow in discord_workflows:
    # Load workflow JSON
    with open(f"workflows/{workflow['filename']}", 'r') as f:
        wf_data = json.load(f)
    
    # Modify for your needs (e.g., change webhook URL)
    # ... modifications ...
    
    # Save as new workflow
    with open(f"my_workflows/{workflow['filename']}", 'w') as f:
        json.dump(wf_data, f, indent=2)
```

### Testing Workflows

1. **Test with Example Data**:
   - Most example workflows include test data
   - Use n8n's "Execute Workflow" with test mode

2. **Local Testing Before Deploy**:
   ```bash
   # Validate JSON structure
   python3 -c "import json; json.load(open('my_workflow.json'))"
   
   # Check for required nodes
   python3 -c "
   import json
   wf = json.load(open('my_workflow.json'))
   nodes = [n['type'] for n in wf['nodes']]
   print('Nodes:', nodes)
   "
   ```

### Best Practices

1. **Always Start with Examples**:
   - Don't build from scratch
   - 2,055 workflows cover most use cases
   - Modify existing patterns

2. **Security**:
   - Never commit API keys or credentials
   - Use n8n's credential system
   - Review workflows before importing

3. **Organization**:
   - Save your workflows in a separate folder
   - Use naming convention from examples
   - Document modifications

4. **Version Control**:
   - Commit your custom workflows
   - Keep upstream examples unchanged
   - Track which examples you based workflows on

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