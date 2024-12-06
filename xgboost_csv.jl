using XGBoost
using DataFrames
using CSV

# Read data from CSV file
data = CSV.read("data.csv", DataFrame)

# Convert data to DMatrix (required by XGBoost)
dtrain = DMatrix(select(data, Not(:label)), label=data.label)

# Set training parameters
params = Dict(
    "booster" => "gbtree",
    "objective" => "binary:logistic",
    "eta" => 0.1,
    "max_depth" => 3,
    "eval_metric" => "logloss"
)

# Train the model
num_rounds = 10
bst = xgboost(dtrain, num_boost_round=num_rounds, params=params)

# Generate predictions
y_pred = predict(bst, dtrain)

# Print results
println("Predictions: ", y_pred[1:5]) # Print the first 5 predictions
