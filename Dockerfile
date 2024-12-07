# # Base image with Julia
# FROM julia:1.10.4

# # Install required packages for XGBoost
# RUN apt-get update && apt-get install -y

# # Install Julia dependencies
# RUN julia -e 'using Pkg; Pkg.add(["XGBoost", "DataFrames", "CSV"]);'

# # Set the working directory
# WORKDIR /app

# # Copy the Julia script to the container
# COPY . .

# # Command to execute the script
# CMD ["julia", "xgboost_csv.jl"]

# Base image with Julia
FROM julia:1.10.4

# Set the working directory
WORKDIR /app

# Copy Project and Manifest files first
COPY Project.toml .
# COPY Manifest.toml .

# Set up the environment and install dependencies
RUN julia --project=/app -e 'using Pkg; Pkg.instantiate();'

# Copy the rest of the application
COPY . .

# Command to execute the script
CMD ["julia", "--project=/app", "xgboost_csv.jl"]
