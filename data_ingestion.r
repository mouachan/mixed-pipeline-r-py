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


# Download and save the file locally
save_object(
  object = "data/raw-data.csv",  # Path to the file in the bucket
  bucket = s3_bucket_name,       # Bucket name
  file = "raw_data.csv",         # Local file name to save as
  region = "",                   # Prevent region from being appended
  base_url = s3_endpoint_url     # Explicitly set the endpoint
)

cat("File raw-data.csv has been saved locally as raw_data.csv\n")