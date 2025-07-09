# Load necessary libraries
library(dplyr)
library(ggplot2)
library(tidyr)


df<- read.csv("C:/Users/HP/Downloads/student/Student Depression Dataset.csv",header = TRUE,sep = ",")
df <- na.omit(df)  


categorical_vars <- df %>% select_if(is.character) %>% colnames()
numerical_vars <- df %>% select_if(is.numeric) %>% colnames()
numerical_vars <- setdiff(numerical_vars, "Depression")


if (length(categorical_vars) == 0) {
  cat("No categorical variables found.\n")
  stop("Please ensure the dataset contains categorical variables.")
}


dependent_var <- "Depression"
cat("Using", dependent_var, "as the dependent variable for analysis.\n")
df[[dependent_var]] <- as.factor(df[[dependent_var]])


if (length(numerical_vars) > 1) {
  spearman_corr <- cor(df[numerical_vars], method = "spearman", use = "complete.obs")
  print("Spearman Correlation Matrix:")
  print(spearman_corr)
  
  
  key_var <- numerical_vars[8]  
  if (key_var %in% numerical_vars) {
    correlation_data <- data.frame(
      Variable = rownames(spearman_corr),
      Correlation = spearman_corr[, key_var]
    )
    ggplot(correlation_data, aes(x = reorder(Variable, Correlation), y = Correlation)) +
      geom_bar(stat = "identity", aes(fill = Correlation > 0)) +
      labs(
        title = paste("Correlation with", key_var, "(Spearman)"),
        x = "Variables",
        y = paste("Correlation with", key_var)
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      scale_fill_manual(values = c("red", "green"))+
      coord_cartesian(ylim = c(-0.5, 1))
  } else {
    warning("Key variable not found in numerical variables.")
  }
} else {
  warning("Not enough numerical variables for correlation analysis.")
}


anova_results <- list()

for (var in numerical_vars) {
  formula <- as.formula(paste(var, "~", dependent_var))
  anova_result <- aov(formula, data = df)
  summary_result <- summary(anova_result)
  anova_results[[var]] <- data.frame(
    Variable = var,
    F_Score = summary_result[[1]]$`F value`[1],
    P_Value = summary_result[[1]]$`Pr(>F)`[1]
  )
}

anova_df <- bind_rows(anova_results)
anova_df <- anova_df[order(anova_df$P_Value), ]
cat("ANOVA Results:\n")
print(anova_df)

ggplot(anova_df, aes(x = reorder(Variable, -F_Score), y = F_Score, fill = P_Value < 0.05)) +
  geom_bar(stat = "identity") +
  labs(
    title = paste("ANOVA Results (", dependent_var, ")", sep = ""),
    x = "Variables",
    y = "F-Score",
    fill = "Significant"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_fill_manual(values = c("grey", "blue"))


chi_square_results <- list()

for (var_name in categorical_vars) {
  if (var_name != dependent_var) {
    contingency_table <- table(df[[var_name]], df[[dependent_var]])
    
    test_result <- tryCatch({
      chisq.test(contingency_table)
    }, error = function(e) NULL)
    
    if (!is.null(test_result)) {
      chi_square_results[[var_name]] <- data.frame(
        Variable = var_name,
        Chi_Square_Statistic = test_result$statistic,
        P_Value = test_result$p.value
      )
    }
  }
}

if (length(chi_square_results) > 0) {
  chi_square_df <- bind_rows(chi_square_results)
  chi_square_df <- chi_square_df[order(chi_square_df$P_Value), ]
  cat("Chi-Square Test Results:\n")
  print(chi_square_df)
  
  ggplot(chi_square_df, aes(x = reorder(Variable, -Chi_Square_Statistic), y = Chi_Square_Statistic, fill = P_Value < 0.05)) +
    geom_bar(stat = "identity") +
    labs(
      title = paste("Chi-Square Test Results (", dependent_var, ")", sep = ""),
      x = "Variables",
      y = "Chi-Square Statistic",
      fill = "Significant"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    scale_fill_manual(values = c("grey", "green"))
} else {
  warning("No significant Chi-Square test results.")
}
