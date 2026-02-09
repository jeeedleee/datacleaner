# datacleaner

<!-- badges: start --
[![R-CMD-check](https://github.com/jeeedleee/datacleaner/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jeeedleee/datacleaner/actions/workflows/R-CMD-check.yaml)
[![CRAN status](https://www.r-pkg.org/badges/version/datacleaner)](https://CRAN.R-project.org/package=datacleaner)
-- badges: end -->

一个 RStudio 插件，用于数据清洗的智能助手。

## 功能特点

- 🤖 集成 AI 能力，智能生成数据清洗代码
- 📊 支持 CSV 和 Excel 文件导入
- 📝 自动生成可复用的 R 代码
- ⚙️ 可配置的 API 密钥和模型设置
- 🎯 直接在 RStudio 编辑器中插入生成的代码

## 安装方法

### 方式一：从 GitHub 安装（推荐）

```r
# 安装 remotes 包（如果还没有安装）
install.packages("remotes")

# 从 GitHub 安装 datacleaner
remotes::install_github("jeeedleee/datacleaner")
```

### 方式二：从 R-Universe 安装

```r
# 添加 jeeedleee 的 universe
install.packages("datacleaner", repos = c("https://jeeedleee.r-universe.dev", "https://cloud.r-project.org"))
```

### 方式三：下载源码本地安装

1. 下载本仓库所有文件到同一文件夹
2. 在 RStudio 中运行：

```r
setwd("你的文件夹路径")  # 例如：setwd("C:/Users/用户名/Downloads/datacleaner")
source("install.R")
```

脚本会自动完成：
- 配置国内 CRAN 镜像（清华大学）
- 检查并安装依赖包
- 安装 datacleaner 包
- 验证安装

### 方式四：手动安装

如果自动安装失败，可以手动安装：

1. 安装依赖包：

```r
install.packages(c("shiny", "miniUI", "DT", "httr2",
                   "readr", "readxl", "rstudioapi",
                   "jsonlite", "yaml"))
```

2. 从源码安装 datacleaner：

```r
remotes::install_github("jeeedleee/datacleaner")
```

或下载后本地安装：

```r
install.packages("datacleaner_0.1.0.tar.gz", repos = NULL, type = "source")
```

## 依赖包

- shiny - 交互式界面
- miniUI - 迷你 UI 组件
- DT - 数据表格展示
- httr2 - HTTP 请求
- readr - 读取 CSV 文件
- readxl - 读取 Excel 文件
- rstudioapi - RStudio API 集成
- jsonlite - JSON 处理
- yaml - YAML 配置文件

## 使用方法

### 首次使用

1. **重启 RStudio**（安装后必须重启）
2. 点击菜单：**Addins** → **数据清洗助手**
3. 在打开的界面中，点击 **设置** 标签页
4. 配置以下信息：
   - **API 密钥**：你的 API 密钥
   - **模型**：模型名称（如 gpt-4）
5. 点击 **保存设置**

配置将保存在 `~/.datacleaner/config.yml`，下次使用时自动加载。

### 数据清洗流程

1. 点击 **Addins** → **数据清洗助手**
2. 导入数据文件（支持 CSV 或 Excel）
3. 在「清洗规则」标签页指定清洗需求
4. 点击「生成代码」
5. 生成的代码会自动插入到 RStudio 编辑器中

## 常见问题

**Q: 安装时提示缺少依赖包？**
> A: 运行 `install.R` 脚本会自动安装依赖包。如果失败，请尝试手动安装。

**Q: 提示需要 Rtools？**
> A: Windows 用户安装源码包可能需要 Rtools。请从 [CRAN](https://cran.r-project.org/bin/windows/Rtools/) 下载安装。

**Q: API 地址是什么？**
> A: API 地址已固定为 `https://537-ai.net`，无需额外配置。

**Q: 如何更新到新版本？**
> A: 重新运行安装命令即可：
> ```r
> remotes::install_github("jeeedleee/datacleaner")
> ```

**Q: 安装后找不到插件？**
> A: 请确保已重启 RStudio，然后在 Addins 菜单中查找「数据清洗助手」。

## 系统要求

- R >= 4.1.0
- RStudio >= 1.2
- Windows 用户可能需要安装 [Rtools](https://cran.r-project.org/bin/windows/Rtools/)

## 开发计划

- [ ] 支持更多数据源（数据库、JSON 等）
- [ ] 保存常用清洗规则模板
- [ ] 支持更多 LLM 模型
- [ ] 提交到 CRAN

## 联系方式

如有问题或建议，请联系：[jeeedleee14@gmail.com](mailto:jeeedleee14@gmail.com)

## 许可证

MIT License © 2026 jeeedleee

---

⭐ 如果本工具对你有帮助，欢迎 Star 支持！