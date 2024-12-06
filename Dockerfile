# Base image with Julia
FROM julia:1.10.4

# Install required packages for XGBoost
RUN apt-get update && apt-get install -y

# Install Julia dependencies
RUN julia -e 'using Pkg; Pkg.add(["XGBoost", "DataFrames", "CSV"]);'

# Set the working directory
WORKDIR /app

# Copy the Julia script to the container
COPY . .

# Command to execute the script
CMD ["julia", "xgboost_csv.jl"]
