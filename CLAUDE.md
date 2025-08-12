# n8n-workflows Repository

## Overview
This repository contains a collection of n8n workflow automation files. n8n is a workflow automation tool that allows creating complex automations through a visual node-based interface. Each workflow is stored as a JSON file containing node definitions, connections, and configurations.

## Repository Structure
```
n8n-workflows/
├── workflows/           # Main directory containing all n8n workflow JSON files
│   ├── *.json          # Individual workflow files
├── README.md           # Repository documentation
├── claude.md           # This file - AI assistant context
└── [other files]       # Additional configuration or documentation files
```

## Workflow File Format
Each workflow JSON file contains:
- **name**: Workflow identifier
- **nodes**: Array of node objects defining operations
- **connections**: Object defining how nodes are connected
- **settings**: Workflow-level configuration
- **staticData**: Persistent data across executions
- **tags**: Categorization tags
- **createdAt/updatedAt**: Timestamps

## Common Node Types
- **Trigger Nodes**: webhook, cron, manual
- **Integration Nodes**: HTTP Request, database connectors, API integrations
- **Logic Nodes**: IF, Switch, Merge, Loop
- **Data Nodes**: Function, Set, Transform Data
- **Communication**: Email, Slack, Discord, etc.

## Working with This Repository

### For Analysis Tasks
When analyzing workflows in this repository:
1. Parse JSON files to understand workflow structure
2. Examine node chains to determine functionality
3. Identify external integrations and dependencies
4. Consider the business logic implemented by node connections

### For Documentation Tasks
When documenting workflows:
1. Verify existing descriptions against actual implementation
2. Identify trigger mechanisms and schedules
3. List all external services and APIs used
4. Note data transformations and business logic
5. Highlight any error handling or retry mechanisms

### For Modification Tasks
When modifying workflows:
1. Preserve the JSON structure and required fields
2. Maintain node ID uniqueness
3. Update connections when adding/removing nodes
4. Test compatibility with n8n version requirements

## Key Considerations

### Security
- Workflow files may contain sensitive information in webhook URLs or API configurations
- Credentials are typically stored separately in n8n, not in the workflow files
- Be cautious with any hardcoded values or endpoints

### Best Practices
- Workflows should have clear, descriptive names
- Complex workflows benefit from documentation nodes or comments
- Error handling nodes improve reliability
- Modular workflows (calling sub-workflows) improve maintainability

### Common Patterns
- **Data Pipeline**: Trigger → Fetch Data → Transform → Store/Send
- **Integration Sync**: Cron → API Call → Compare → Update Systems
- **Automation**: Webhook → Process → Conditional Logic → Actions
- **Monitoring**: Schedule → Check Status → Alert if Issues

## Helpful Context for AI Assistants

When assisting with this repository:

1. **Workflow Analysis**: Focus on understanding the business purpose by examining the node flow, not just individual nodes.

2. **Documentation Generation**: Create descriptions that explain what the workflow accomplishes, not just what nodes it contains.

3. **Troubleshooting**: Common issues include:
   - Incorrect node connections
   - Missing error handling
   - Inefficient data processing in loops
   - Hardcoded values that should be parameters

4. **Optimization Suggestions**:
   - Identify redundant operations
   - Suggest batch processing where applicable
   - Recommend error handling additions
   - Propose splitting complex workflows

5. **Code Generation**: When creating tools to analyze these workflows:
   - Handle various n8n format versions
   - Account for custom nodes
   - Parse expressions in node parameters
   - Consider node execution order

## Repository-Specific Information

### Accessing User's n8n Workflows
When the user mentions "my flows" or provides URLs like `https://agent.blurtai.xyz/workflow/[ID]`, these should be accessed through the n8n MCP server configured in mcp.json. Do not attempt to fetch these URLs directly via WebFetch - use the appropriate n8n MCP tools instead.

### Workflow Naming Conventions
- Format: `[ServiceName]_[Action]_[TriggerType].json`
- Examples: `Telegram_Automate_Triggered.json`, `Discord_Create_Webhook.json`
- Use PascalCase for service names and actions

### n8n MCP Integration Instructions

#### Available MCP Commands
When the user asks about their n8n workflows, use these MCP tools:
- `listWorkflows()` - Get all workflows from the user's n8n instance
- `getWorkflow(id)` - Get specific workflow details
- `createWorkflow(data)` - Create new workflow
- `updateWorkflow(id, data)` - Update existing workflow
- `executeWorkflow(id, data)` - Run a workflow with data
- `getExecutions(workflowId)` - Get execution history

#### Creating Workflows for the User

**IMPORTANT**: Always use the 2,055+ example workflows as templates. Never create from scratch.

1. **Search for similar examples** in `workflows/` directory:
   ```python
   # Start documentation server
   python3 run.py
   
   # Search via API
   curl "http://localhost:8000/api/workflows?q=[service_name]"
   ```

2. **Identify patterns to reuse**:
   - Find workflows with similar triggers (Webhook, Scheduled, Manual)
   - Look for workflows using the same services
   - Check complexity level to match user needs

3. **Combine multiple examples**:
   - Take trigger from one workflow
   - Processing logic from another
   - Output/notification from a third
   - This is how to create complex workflows quickly

4. **Modify for user's needs**:
   - Replace service nodes (e.g., Telegram → Discord)
   - Adjust parameters and settings
   - Add user's specific business logic

5. **Deploy via MCP** to user's n8n instance

#### Workflow Development Process

1. **Understand requirement**: Ask clarifying questions about:
   - Trigger type needed
   - Services to integrate
   - Data flow requirements
   - Error handling needs

2. **Find examples** (ALWAYS DO THIS FIRST):
   ```bash
   # Search by service
   curl "http://localhost:8000/api/workflows?q=telegram"
   
   # Search by multiple services
   curl "http://localhost:8000/api/workflows?q=gmail+sheets"
   
   # Filter by trigger type
   curl "http://localhost:8000/api/workflows?trigger=Scheduled"
   ```

3. **Analyze example structure**:
   - Note the node types used
   - Understand the connection flow
   - Identify reusable patterns

4. **Create/modify workflow**:
   - Start with closest matching example
   - Modify nodes and connections
   - Add error handling from error workflow examples
   - Test with sample data

5. **Deploy and test**:
   - Use MCP createWorkflow or updateWorkflow
   - Execute with test data
   - Verify error handling works

6. **Document**: Explain:
   - Which examples were used as base
   - What modifications were made
   - Any credentials user needs to configure

#### Example Workflow Creation

User asks: "Create a workflow that monitors RSS feeds and posts summaries to Discord"

Your process:
1. Search for RSS workflows: Find `0748_Noop_Telegram_Automation_Scheduled.json` (RSS to Telegram)
2. Search for Discord workflows: Find `0525_Bannerbear_Discord_Create_Webhook.json` (Discord posting)
3. Search for summarization: Find workflows with OpenAI nodes
4. Combine: RSS fetch → OpenAI summarize → Discord post
5. Deploy via MCP

### Environment Setup
- API URL: `https://agent.blurtai.xyz`
- API Key: Loaded from `.env` file (never hardcode)
- MCP Wrapper: `./n8n-mcp-wrapper.sh`

### Special Considerations
- **Security**: Never expose API keys or credentials in code
- **Testing**: Always suggest testing workflows before production use
- **Credentials**: Remind user to configure credentials in n8n UI
- **Error Handling**: Always include error handling nodes
- **Documentation**: Provide clear descriptions for complex workflows

## Quick Reference for Claude

### To search workflows:
```python
# Start server if needed
python3 run.py

# Search via API
curl "http://localhost:8000/api/workflows?q=telegram"
```

### To create a new workflow:
1. Find similar example in `workflows/`
2. Modify the JSON structure
3. Use MCP to deploy to user's n8n

### To help user with workflows:
1. **List their workflows**: Use MCP listWorkflows
2. **Show specific workflow**: Use MCP getWorkflow
3. **Create new**: Build JSON and use MCP createWorkflow
4. **Update existing**: Modify and use MCP updateWorkflow
5. **Test execution**: Use MCP executeWorkflow with test data

## Version Compatibility
- n8n version: 1.0+ (compatible with latest)
- MCP Integration: v1.0.0
- Last updated: 2025-01-12
- Python: 3.7+ required

---

[中文](./CLAUDE_ZH.md)