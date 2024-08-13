# 加載必要的套件
library(ggplot2)
library(dplyr)

# 確認數據框
str(data)

# 繪製數值型變量的分佈圖
numeric_columns <- c('Age', 'Job', 'Credit.amount', 'Duration')

for (column in numeric_columns) {
    p <- ggplot(data, aes(x = .data[[column]])) + 
        geom_histogram(aes(y = after_stat(density)), bins = 30, fill = "blue", alpha = 0.7) +
        geom_density(color = "red") +
        ggtitle(paste("Distribution of", column)) +
        theme_minimal() +
        theme(
            plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
            axis.title = element_text(size = 14),
            axis.text = element_text(size = 12)
        )
    print(p)
}
# 繪製分類型變量的分佈圖
categorical_columns <- c('Sex', 'Housing', 'Saving.accounts', 'Purpose')

for (column in categorical_columns) {
    p <- ggplot(data, aes(x = .data[[column]])) + 
        geom_bar(fill = "blue", alpha = 0.7) +
        ggtitle(paste("Distribution of", column)) +
        theme_minimal() +
        theme(
            plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
            axis.title = element_text(size = 14),
            axis.text = element_text(size = 12)
        )
    print(p)
}
