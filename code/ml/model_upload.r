library(aws.s3)

# Get environment variables to use for the connection
s3_endpoint_url <- Sys.getenv("S3_ENDPOINT")
s3_access_key <- Sys.getenv("AWS_ACCESS_KEY_ID")
s3_secret_key <- Sys.getenv("AWS_SECRET_ACCESS_KEY")
s3_bucket_name <- Sys.getenv("S3_BUCKET")

# Remove the "https://" or "http://" prefix from the endpoint URL
s3_endpoint_url <- sub("^https?://", "", s3_endpoint_url)



# Print the variables for debugging
cat("Endpoint:", s3_endpoint_url, "\nAccess Key:", s3_access_key, "\nSecret Key:", s3_secret_key, "\nBucket Name:", s3_bucket_name, "\n")

# Format the time as a string suitable for filenames
current_time <- Sys.time()
timestamp <- format(current_time, "%Y%m%d_%H%M%S")

# Create the filename using the formatted timestamp

object_name <- paste0("models/model_", timestamp, ".bst")
print('Uploading model to: ')
print(object_name)

put_object(
  file = "model.bst",
  object = object_name,  # Path to the file in the bucket
  bucket = s3_bucket_name,       # Bucket name
  region = "",                   # Prevent region from being appended
  base_url = s3_endpoint_url     # Explicitly set the endpoint
)

print('Model upload complete')