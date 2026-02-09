# datacleaner 0.1.0

## 首次发布 (2026-02-09)

这是 datacleaner 的首个公开版本。

### 主要功能

- **数据导入**：支持 CSV 和 Excel 文件导入
- **可视化预览**：使用 DT 表格展示数据，支持交互式操作
- **自然语言规则**：用自然语言描述数据清洗需求
- **智能代码生成**：基于 LLM 自动生成 R 数据清洗代码
- **RStudio 集成**：作为 Addin 无缝集成到 RStudio
- **代码插入**：生成的代码直接插入到编辑器
- **配置管理**：简单的 API 配置界面

### 技术特性

- 固定 API 地址为 https://537-ai.net
- 用户只需配置 API 密钥和模型名称
- 配置持久化保存在 ~/.datacleaner/config.yml
- 支持所有兼容 OpenAI API 格式的模型

### 依赖包

- shiny (>= 1.7.0)
- miniUI (>= 0.1.1)
- DT (>= 0.20)
- httr2 (>= 0.2.0)
- readr (>= 2.1.0)
- readxl (>= 1.4.0)
- rstudioapi (>= 0.13)
- jsonlite (>= 1.8.0)
- yaml (>= 2.3.0)
