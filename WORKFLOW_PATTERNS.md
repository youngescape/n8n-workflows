# n8n Workflow Patterns Guide

Quick reference for finding and using workflow patterns from the 2,055+ examples.

## 🔍 How to Use This Guide

1. **Find your use case** below
2. **Note the example workflow files**
3. **Search for them** in the documentation server
4. **Combine patterns** to create your workflow

## 📊 Most Useful Workflow Patterns

### 🤖 AI/Chatbot Patterns

#### Basic AI Chatbot
- **Example**: `0419_Telegram_Automate_Triggered.json`
- **Pattern**: Webhook → OpenAI → Response
- **Use for**: Customer support, Q&A bots

#### Advanced AI with Memory
- **Example**: `1001_Telegram_Stickynote_Automation_Triggered.json`
- **Pattern**: Webhook → Context Store → OpenAI → Response
- **Use for**: Conversational bots with context

#### Multi-Service AI Bot
- **Example**: `0480_Aggregate_Telegram_Automate_Triggered.json`
- **Pattern**: Multiple Triggers → OpenAI → Route to Service
- **Use for**: Bots that work across Telegram, Discord, Slack

### 📧 Email Automation Patterns

#### Email to Spreadsheet
- **Example**: `0852_Gmail_GoogleSheets_Create_Triggered.json`
- **Pattern**: Gmail Trigger → Parse → Google Sheets
- **Use for**: Invoice tracking, lead capture

#### Email with PDF Processing
- **Example**: `0828_Extractfromfile_Gmail_Send_Triggered.json`
- **Pattern**: Gmail → Extract PDF → Process → Store
- **Use for**: Document automation, receipt processing

#### Email Digest/Summary
- **Example**: `1324_Aggregate_Gmail_Send_Triggered.json`
- **Pattern**: Schedule → Aggregate Emails → Summarize → Send
- **Use for**: Daily digests, report summaries

### 📅 Scheduled Automation Patterns

#### Daily Data Sync
- **Example**: `0748_Noop_Telegram_Automation_Scheduled.json`
- **Pattern**: Schedule → Fetch → Process → Notify
- **Use for**: RSS monitoring, data syncs

#### Scheduled Reports
- **Example**: `0234_GoogleSheets_Cron_Create_Scheduled.json`
- **Pattern**: Schedule → Query Data → Format → Send
- **Use for**: Analytics reports, KPI tracking

#### Backup Automation
- **Example**: `0781_Code_Schedule_Export_Scheduled.json`
- **Pattern**: Schedule → Export → Compress → Store
- **Use for**: Database backups, file archiving

### 🔄 Data Processing Patterns

#### ETL Pipeline
- **Example**: `0472_Aggregate_Gmail_Create_Triggered.json`
- **Pattern**: Extract → Transform → Load
- **Use for**: Data migration, synchronization

#### Data Aggregation
- **Example**: `0681_Aggregate_HTTP_Create_Webhook.json`
- **Pattern**: Multiple Sources → Aggregate → Process
- **Use for**: Combining data from multiple APIs

#### Data Validation & Cleaning
- **Example**: `0623_Comparedatasets_Manual_Create_Triggered.json`
- **Pattern**: Input → Validate → Clean → Output
- **Use for**: Data quality assurance

### 🔔 Notification Patterns

#### Multi-Channel Notifications
- **Example**: `0360_Discord_Cron_Automation_Scheduled.json`
- **Pattern**: Trigger → Route → Multiple Channels
- **Use for**: Alert systems, broadcast messages

#### Error Notifications
- **Example**: `1948_Error_Telegram_Send_Triggered.json`
- **Pattern**: Error Trigger → Format → Notify
- **Use for**: System monitoring, error alerts

#### Conditional Notifications
- **Example**: `0335_Filter_Telegram_Send_Triggered.json`
- **Pattern**: Trigger → Filter → Conditional Send
- **Use for**: Smart alerts, threshold monitoring

### 🌐 Web Scraping Patterns

#### Basic Web Scraping
- **Example**: `workflows/reddit_scraper_example.json`
- **Pattern**: Schedule → Scrape → Parse → Store
- **Use for**: Price monitoring, content tracking

#### API Integration Pattern
- **Example**: `1964_HTTP_Aggregate_Automation_Webhook.json`
- **Pattern**: Webhook → API Call → Process → Response
- **Use for**: Third-party integrations

### 📁 File Processing Patterns

#### File Upload Processing
- **Example**: `0601_Extractfromfile_Manual_Create_Webhook.json`
- **Pattern**: Upload → Extract → Process → Store
- **Use for**: Document management, file conversion

#### Image Processing
- **Example**: `0575_Editimage_Manual_Update_Webhook.json`
- **Pattern**: Upload → Edit Image → Store/Send
- **Use for**: Thumbnail generation, watermarking

#### PDF Generation
- **Example**: `1224_Apitemplateio_Typeform_Automation_Triggered.json`
- **Pattern**: Data → Template → Generate PDF → Send
- **Use for**: Invoice generation, reports

### 🔐 Authentication & Security Patterns

#### API Key Validation
- **Example**: `0097_Executecommand_Mailgun_Automation_Webhook.json`
- **Pattern**: Request → Validate → Process/Reject
- **Use for**: API security, access control

#### OAuth Flow
- **Example**: `1085_Affinity_Create_Triggered.json`
- **Pattern**: Auth Request → Token → API Access
- **Use for**: Third-party service integration

## 💡 Combining Patterns

### Example: Email + AI + Notification
Combine these patterns:
1. Email trigger from `0852_Gmail_GoogleSheets_Create_Triggered.json`
2. AI processing from `0419_Telegram_Automate_Triggered.json`
3. Notification from `0360_Discord_Cron_Automation_Scheduled.json`

Result: Email → AI Analysis → Smart Notification

### Example: Scheduled Scraping + Processing
Combine:
1. Schedule from `0748_Noop_Telegram_Automation_Scheduled.json`
2. Scraping from `workflows/reddit_scraper_example.json`
3. Storage from `0234_GoogleSheets_Cron_Create_Scheduled.json`

Result: Daily web scraping with automated storage

## 🛠 Quick Commands

### Find Patterns by Service
```bash
# Telegram patterns
curl "http://localhost:8000/api/workflows?q=telegram"

# OpenAI patterns
curl "http://localhost:8000/api/workflows?q=openai"

# Google Sheets patterns
curl "http://localhost:8000/api/workflows?q=sheets"
```

### Find Patterns by Trigger
```bash
# Webhook patterns
curl "http://localhost:8000/api/workflows?trigger=Webhook"

# Scheduled patterns
curl "http://localhost:8000/api/workflows?trigger=Scheduled"

# Manual patterns
curl "http://localhost:8000/api/workflows?trigger=Manual"
```

### Find Complex Workflows
```bash
# High complexity (16+ nodes)
curl "http://localhost:8000/api/workflows?complexity=high"

# Multi-service workflows
curl "http://localhost:8000/api/workflows?q=telegram+openai+sheets"
```

## 📈 Statistics

### Most Common Patterns
1. **Webhook → Process → Response** (519 workflows)
2. **Schedule → Fetch → Store** (226 workflows)
3. **Trigger → Transform → Notify** (450+ workflows)
4. **Manual → Process → Export** (477 workflows)

### Most Integrated Services
1. **Telegram** - 184 workflows
2. **Discord** - 150+ workflows
3. **Google Sheets** - 200+ workflows
4. **OpenAI** - 100+ workflows
5. **Slack** - 180+ workflows

## 🎯 Pattern Selection Guide

Choose patterns based on:

1. **Trigger Type**:
   - Real-time → Webhook patterns
   - Periodic → Scheduled patterns
   - On-demand → Manual patterns

2. **Data Flow**:
   - One-way → Simple trigger patterns
   - Two-way → Request/response patterns
   - Multi-source → Aggregation patterns

3. **Complexity**:
   - Simple (≤5 nodes) → Basic patterns
   - Medium (6-15 nodes) → Standard patterns
   - Complex (16+ nodes) → Advanced patterns

4. **Error Handling**:
   - Basic → Try/catch patterns
   - Advanced → Error workflow patterns
   - Critical → Multi-level error patterns

## 📝 Notes

- Always test patterns with sample data first
- Modify webhook URLs and API keys for your instance
- Combine patterns for complex workflows
- Use error handling patterns for production workflows

---

Generated from analysis of 2,055 workflows in the repository.
Last updated: 2025-01-12