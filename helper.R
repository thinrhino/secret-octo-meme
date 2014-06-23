# Helper file

# Read Data
data <- read.csv('data/rspm_data.csv',
                 colClasses = c(rep("character", 4), rep("integer", 3))
)
