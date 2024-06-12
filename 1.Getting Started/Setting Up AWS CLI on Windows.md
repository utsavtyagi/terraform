# Setting Up AWS CLI on Windows

Follow these steps to install and configure the AWS Command Line Interface (CLI) on Windows.

## Installation Steps

### 1. Download AWS CLI MSI Installer

1. Go to the [AWS CLI download page](https://aws.amazon.com/cli/).
2. Scroll down to the "AWS CLI version 2" section and click on "Windows" to download the MSI installer.

### 2. Install AWS CLI

1. Double-click the downloaded MSI installer to start the installation process.
2. Follow the prompts in the installer to complete the installation. You can choose the default settings for most options.

### 3. Verify Installation

1. Open a new Command Prompt or PowerShell window.
2. Run the following command to verify that the AWS CLI is installed correctly:

    ```powershell
    aws --version
    ```

   You should see the installed version of the AWS CLI displayed.

## Configuration Steps

### 1. Configure AWS CLI

1. Run the following command to start the configuration process:

    ```powershell
    aws configure
    ```

2. Enter your AWS Access Key ID, Secret Access Key, default region, and output format when prompted. You can obtain these credentials from the AWS Management Console.

    ```
    AWS Access Key ID: <Enter your access key>
    AWS Secret Access Key: <Enter your secret key>
    Default region name: <Enter your preferred region>
    Default output format: <Enter your preferred output format (e.g., json)>
    ```

3. Once you've entered the required information, the AWS CLI configuration is complete.

### 2. Verify Configuration

1. Run the following command to verify that the AWS CLI is configured correctly:

    ```powershell
    aws ec2 describe-instances
    ```

   If the configuration is correct, you should see a list of EC2 instances in your AWS account.

The AWS CLI is now installed and configured on your Windows system.
