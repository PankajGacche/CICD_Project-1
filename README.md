# Continuous Integration/Continuous Deployment (CI/CD) Project

This project provides a simple CI/CD pipeline to automatically deploy changes from a Git repository to a web server.

## Setup

### Prerequisites

- OS : ubuntu
- Git
- Nginx

### Installation

1. Clone this repository:

    ```bash
    git clone https://github.com/PankajGacche/CICD_Project-1.git
    ```

2. Configure Nginx to serve your web application.

3. Set up your CI/CD pipeline by configuring the `config.json` file located in `CI_CD_project/` directory.

4. Run the `GitAutoDeployer.py` script to start the CI/CD pipeline:

    ```bash
    python GitAutoDeployer.py
    ```
5. Run the `GitAutoDeployer.py` script in a cron job to check for commits every minute:

    ```bash
    crontab -e
    * * * * * python3 <project_folder>/GitAutoDeployer.py
    * * * * * python3 /home/ubuntu/CICD_Project-1/GitAutoDeployer.py
    ```

## Usage

1. Make changes to your web application code.

2. Push your changes to the configured Git repository.

3. The CI/CD pipeline will automatically deploy the changes to your web server.

## Files

- `GitAutoDeployer.py`: Python script to automate deployment process.
- `AutoDeployScript.sh`: Bash script to clone the latest version of the project, deploy it, and restart Nginx.
- `config.json`: Configuration file specifying Git repository URL and branch.
- `deployment.log`: Log file recording deployment history.



