# 加載必要的包
if (!requireNamespace("ggplot2", quietly = TRUE)) {
    install.packages("ggplot2")
}
if (!requireNamespace("dplyr", quietly = TRUE)) {
    install.packages("dplyr")
}
if (!requireNamespace("readr", quietly = TRUE)) {
    install.packages("readr")
}
if (!requireNamespace("vcd", quietly = TRUE)) {
    install.packages("vcd")
}

library(ggplot2)
library(dplyr)
library(readr)
library(vcd)

# 選擇並讀取 CSV 文件
file_path <- file.choose()
data <- read_csv(file_path)

# 查看數據的前幾行和列名
print(head(data))
print(colnames(data))

# 確認需要的列是否存在
required_columns <- c("Risk", "Duration", "Credit amount", "Checking account", "Saving accounts", "Sex", "Job", "Housing", "Purpose")
missing_columns <- setdiff(required_columns, colnames(data))

if (length(missing_columns) > 0) {
    stop(paste("缺少以下列:", paste(missing_columns, collapse = ", ")))
}

# 確認 `Risk` 列存在
if ("Risk" %in% colnames(data)) {
    data$Risk <- factor(data$Risk, levels = c(0, 1), labels = c("Low Risk", "High Risk"))
    
    # 繪製二次多項式回歸圖
    plot_poly <- ggplot(data, aes(x = Duration, y = `Credit amount`, color = Risk)) +
        geom_point() +
        geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = FALSE) +
        scale_color_manual(values = c("Low Risk" = "#7bd245", "High Risk" = "#ffa32b")) +
        labs(title = "The Relationship between Credit Amount and Duration Graph with Polynomial Regression",
             x = "Duration",
             y = "Credit amount",
             color = "Credit Risk") +
        theme_minimal()
    
    print(plot_poly)
} else {
    print("數據中沒有 `Risk` 列，請檢查數據文件。")
}

# 進一步數據處理和描述性統計
data <- data %>% filter(!is.na(`Checking account`) & `Checking account` != "" & !is.na(`Saving accounts`) & `Saving accounts` != "")

desc_stats <- data %>%
    group_by(Risk) %>%
    summarise(
        Sex_male = sum(Sex == "male", na.rm = TRUE),
        Sex_female = sum(Sex == "female", na.rm = TRUE),
        Job_0 = sum(Job == 0, na.rm = TRUE),
        Job_1 = sum(Job == 1, na.rm = TRUE),
        Job_2 = sum(Job == 2, na.rm = TRUE),
        Job_3 = sum(Job == 3, na.rm = TRUE),
        Housing_free = sum(Housing == "free", na.rm = TRUE),
        Housing_own = sum(Housing == "own", na.rm = TRUE),
        Housing_rent = sum(Housing == "rent", na.rm = TRUE),
        Saving_accounts_little = sum(`Saving accounts` == "little", na.rm = TRUE),
        Saving_accounts_moderate = sum(`Saving accounts` == "moderate", na.rm = TRUE),
        Saving_accounts_rich = sum(`Saving accounts` == "rich", na.rm = TRUE),
        Saving_accounts_quite_rich = sum(`Saving accounts` == "quite rich", na.rm = TRUE),
        Checking_account_little = sum(`Checking account` == "little", na.rm = TRUE),
        Checking_account_moderate = sum(`Checking account` == "moderate", na.rm = TRUE),
        Checking_account_rich = sum(`Checking account` == "rich", na.rm = TRUE)
    )

print(desc_stats)

# 繪製分類特徵和目標變量的圖表
low_risk_color <- "#7bd245"
high_risk_color <- "#ffa32b"

axis_text_size <- 15
title_text_size <- 15

plot_sex <- ggplot(data, aes(x = Sex, fill = Risk)) +
    geom_bar(position = "dodge") +
    scale_fill_manual(values = c("Low Risk" = low_risk_color, "High Risk" = high_risk_color)) +
    labs(title = "Sex", x = "Sex", y = "Count", fill = "Risk") +
    theme_minimal() +
    theme(plot.title = element_text(size = title_text_size, face = "bold"),
          axis.title.x = element_text(size = axis_text_size),
          axis.title.y = element_text(size = axis_text_size),
          axis.text.x = element_text(size = axis_text_size),
          axis.text.y = element_text(size = axis_text_size))

plot_job <- ggplot(data, aes(x = Job, fill = Risk)) +
    geom_bar(position = "dodge") +
    scale_fill_manual(values = c("Low Risk" = low_risk_color, "High Risk" = high_risk_color)) +
    labs(title = "Job", x = "Job", y = "Count", fill = "Risk") +
    theme_minimal() +
    theme(plot.title = element_text(size = title_text_size, face = "bold"),
          axis.title.x = element_text(size = axis_text_size),
          axis.title.y = element_text(size = axis_text_size),
          axis.text.x = element_text(size = axis_text_size),
          axis.text.y = element_text(size = axis_text_size))

plot_housing <- ggplot(data, aes(x = Housing, fill = Risk)) +
    geom_bar(position = "dodge") +
    scale_fill_manual(values = c("Low Risk" = low_risk_color, "High Risk" = high_risk_color)) +
    labs(title = "Housing", x = "Housing", y = "Count", fill = "Risk") +
    theme_minimal() +
    theme(plot.title = element_text(size = title_text_size, face = "bold"),
          axis.title.x = element_text(size = axis_text_size),
          axis.title.y = element_text(size = axis_text_size),
          axis.text.x = element_text(size = axis_text_size),
          axis.text.y = element_text(size = axis_text_size))

plot_saving_accounts <- ggplot(data, aes(x = `Saving accounts`, fill = Risk)) +
    geom_bar(position = "dodge") +
    scale_fill_manual(values = c("Low Risk" = low_risk_color, "High Risk" = high_risk_color)) +
    labs(title = "Saving accounts", x = "Saving accounts", y = "Count", fill = "Risk") +
    theme_minimal() +
    theme(plot.title = element_text(size = title_text_size, face = "bold"),
          axis.title.x = element_text(size = axis_text_size),
          axis.title.y = element_text(size = axis_text_size),
          axis.text.x = element_text(size = axis_text_size),
          axis.text.y = element_text(size = axis_text_size))

plot_checking_account <- ggplot(data, aes(x = `Checking account`, fill = Risk)) +
    geom_bar(position = "dodge") +
    scale_fill_manual(values = c("Low Risk" = low_risk_color, "High Risk" = high_risk_color)) +
    labs(title = "Checking account", x = "Checking account", y = "Count", fill = "Risk") +
    theme_minimal() +
    theme(plot.title = element_text(size = title_text_size, face = "bold"),
          axis.title.x = element_text(size = axis_text_size),
          axis.title.y = element_text(size = axis_text_size),
          axis.text.x = element_text(size = axis_text_size),
          axis.text.y = element_text(size = axis_text_size))

print(plot_sex)
print(plot_job)
print(plot_housing)
print(plot_saving_accounts)
print(plot_checking_account)

# 進行多元回歸分析
data <- data %>%
    mutate(
        Sex = as.numeric(factor(Sex, levels = c("female", "male"))),
        Job = as.numeric(Job),
        Housing = as.numeric(factor(Housing, levels = c("free", "rent", "own"))),
        `Saving accounts` = as.numeric(factor(`Saving accounts`, levels = c("little", "moderate", "rich", "quite rich"))),
        `Checking account` = as.numeric(factor(`Checking account`, levels = c("little", "moderate", "rich")))
    )

summary(data)

model <- glm(Risk ~ Sex + Job + Housing + `Saving accounts` + `Checking account`, data = data, family = binomial)

coef <- summary(model)$coefficients
confint <- confint(model)

results <- data.frame(
    Term = rownames(coef),
    Estimate = coef[, "Estimate"],
    StdError = coef[, "Std. &#8203;:citation[oaicite:0]{index=0}&#8203;
