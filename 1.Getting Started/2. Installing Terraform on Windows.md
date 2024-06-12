# Installing Terraform on Windows

Follow these steps to install Terraform on Windows.

## Installation Steps

### 1. Download Terraform

1. Go to the [Terraform download page](https://developer.hashicorp.com/terraform/install).
2. Under the "Windows" section, download the Windows binary zip file.

### 2. Extract the Zip File

1. Extract the downloaded `.zip` file to a directory of your choice. For example, you might extract it to `C:\Program Files\Terraform`.

### 3. Copy the Executable

1. Ensure that the extracted folder contains the `terraform.exe` file.
2. Copy the `terraform.exe` file to a desired location such as `C:\Program Files\Terraform`.

### 4. Add to System Environment Variable Path

1. Open the Start Menu, search for "Environment Variables", and select "Edit the system environment variables".
2. In the System Properties window, click the "Environment Variables" button.
3. In the Environment Variables window, find the `Path` variable in the "System variables" section, and click "Edit".
4. Click "New" and add the path to the directory where you copied the `terraform.exe` file (e.g., `C:\Program Files\Terraform`).
5. Click "OK" to close all windows.

### 5. Verify Installation

1. Open a new Command Prompt or PowerShell window.
2. Run the following command to verify that Terraform is installed correctly and accessible from your `PATH`:

    ```powershell
    terraform -version
    ```

   You should see the installed version of Terraform displayed.

Terraform is now installed and ready to use on your Windows system.
