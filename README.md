# Mixed Pipeline for R and Python Scripts

This project demonstrates the use of a mixed pipeline that integrates R and Python scripts for data processing and machine learning workflows. The pipeline is designed to work with Elyra, leveraging runtime images to execute scripts in isolated environments.

## Project Structure

- **`code/ml/`**: Contains the R and Python scripts used in the pipeline.
  - `datacleaning.r`: An R script for cleaning and preprocessing raw data.
  - Other scripts for machine learning tasks.
- **`container-images/`**: Contains runtime image configurations and setup scripts.
  - `r-xgboost-workbench/`: Configuration for the R runtime image.
- **`utils-runtime/`**: Contains utility files like `requirements-elyra.txt` for Python dependencies.

## Runtime Image Configuration

### R Runtime Image
The R runtime image is based on `quay.io/mmurakam/runtimes:r-xgboost-v0.3.17`. This image includes R and essential libraries for machine learning, such as `xgboost`. Additional R libraries required by the pipeline are dynamically installed at runtime.

#### Key Configuration Files
- **`datascience-ubi9-py39.json`**:
  - Defines the runtime image for Elyra.
  - Example:
    ```json
    {
      "display_name": "Datascience with Python 3.9 (UBI9)",
      "metadata": {
        "tags": ["datascience"],
        "display_name": "Datascience with Python 3.9 (UBI9)",
        "image_name": "quay.io/mmurakam/runtimes:r-xgboost-v0.3.17",
        "pull_policy": "IfNotPresent"
      },
      "schema_name": "runtime-image"
    }
    ```
- **`setup-elyra.sh`**:
  - Configures Elyra to use the runtime image and installs any missing dependencies dynamically.

### Python Runtime Image
The Python runtime image is configured to include all dependencies listed in `requirements-elyra.txt`. This ensures compatibility with Elyra and Python scripts in the pipeline.

## Adding a New Runtime in Elyra

1. **Access Runtime Management**:
   - Open JupyterLab and go to **Elyra > Manage Runtime Images**.

2. **Add a New Runtime**:
   - Click **+** and fill in the details:
     - **Display Name**: `R XGBoost v0.3.17`
     - **Container Image**: `quay.io/mmurakam/runtimes:r-xgboost-v0.3.17`
     - **Pull Policy**: `IfNotPresent`

3. **Save the Configuration**:
   - Click **Save** to add the runtime.

## Running the Pipeline

1. **Create or Open a Pipeline**:
   - Use Elyra to create a new pipeline or open an existing one.

2. **Add Components**:
   - Drag and drop components for R or Python scripts into the pipeline.

3. **Configure Runtime**:
   - For each component, select the appropriate runtime image (e.g., `R XGBoost v0.3.17` for R scripts).

4. **Run the Pipeline**:
   - Click **Run Pipeline** and select the runtime environment (e.g., Kubeflow Pipelines).

## Dynamic Installation of R Libraries

The R scripts in this project dynamically install missing libraries at runtime. For example, the `datacleaning.r` script includes the following logic:
```r
required_packages <- c("tidyverse", "skimr", "dplyr")
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages, repos = "https://cloud.r-project.org")
