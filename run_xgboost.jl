using XGBoost
using DataFrames

# Generate a synthetic dataset
n_samples = 100
n_features = 10
X = rand(Float32, n_samples, n_features) # Ensure data is in Float32
y = rand(0:1, n_samples)

# Convert data to DMatrix (required by XGBoost)
dtrain = DMatrix(X, label=y)

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
println("Predictions: ", y_pred[1:10]) # Print the first 10 predictions
