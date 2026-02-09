# datacleaner 一键安装脚本
# 使用方法：在 R 中运行 source("install.R")

cat("=== datacleaner 安装脚本 ===\n\n")

# 1. 配置国内镜像（可选，推荐）
cat("步骤 1/4: 配置 CRAN 镜像...\n")
options(repos = c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
cat("  ✓ 已配置清华大学镜像\n\n")

# 2. 检查并安装依赖包
cat("步骤 2/4: 检查依赖包...\n")
required_packages <- c(
  "shiny", "miniUI", "DT", "httr2",
  "readr", "readxl", "rstudioapi",
  "jsonlite", "yaml"
)

missing_packages <- required_packages[
  !required_packages %in% installed.packages()[,"Package"]
]

if(length(missing_packages) > 0) {
  cat("  需要安装以下依赖包：", paste(missing_packages, collapse = ", "), "\n")
  cat("  正在安装...\n")
  install.packages(missing_packages)
  cat("  ✓ 依赖包安装完成\n\n")
} else {
  cat("  ✓ 所有依赖包已安装\n\n")
}

# 3. 安装 datacleaner
cat("步骤 3/4: 安装 datacleaner...\n")
pkg_file <- "datacleaner_0.1.0.tar.gz"

if(!file.exists(pkg_file)) {
  cat("  ✗ 错误：找不到", pkg_file, "\n")
  cat("  请确保 install.R 和", pkg_file, "在同一目录\n")
  stop("安装失败")
}

cat("  正在安装 datacleaner...\n")
install.packages(pkg_file, repos = NULL, type = "source")
cat("  ✓ datacleaner 安装完成\n\n")

# 4. 验证安装
cat("步骤 4/4: 验证安装...\n")
if("datacleaner" %in% installed.packages()[,"Package"]) {
  cat("  ✓ 安装成功！\n\n")
} else {
  cat("  ✗ 安装失败\n")
  stop("安装验证失败")
}

# 显示使用说明
cat("=== 安装完成 ===\n\n")
cat("重要提示：\n")
cat("请重启 RStudio，然后在菜单中找到 Addins -> Data Cleaner\n\n")
cat("使用方法：\n")
cat("1. 重启 RStudio 后，点击 Addins -> Data Cleaner\n")
cat("2. 首次使用需要配置 API 密钥和模型\n")
cat("3. 导入数据文件，指定清洗规则，生成代码\n\n")
cat("祝使用愉快！\n")
