import subprocess
import json
import os
from datetime import datetime

date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
rootfolder = os.path.dirname(os.path.abspath(__file__))
project_folder = os.path.join(rootfolder, "project")
deployment_log = os.path.join(rootfolder, "deployment.log")

# Check if root directory exists, if not create it
if not os.path.exists(project_folder):
    os.makedirs(project_folder)

# Log start of the Python script
with open(deployment_log, 'a') as log:
    log.write(f"Python script started at {date}\n")

# Read config.json
with open(os.path.join(rootfolder, "config.json"), 'r') as file:
    data = json.load(file)
    git_url = data['git_url']
    git_branch = data['git_branch']

    # Check for new commits
    gitdata = subprocess.Popen(['git', 'ls-remote', git_url], stdout=subprocess.PIPE)
    output, _ = gitdata.communicate()
    formatted_output = output.decode('ascii').split()[0]

    if data.get('commit_id') == formatted_output:
        with open(deployment_log, 'a') as log:
            log.write("No new commits\n")
    else:
        data['commit_id'] = formatted_output
        with open(deployment_log, 'a') as log:
            log.write("New commit found\n")
            log.write(f"Commit ID: {formatted_output}\n")

        # Update config.json with new commit ID
        with open(os.path.join(rootfolder, "config.json"), 'w') as outputfile:
            json.dump(data, outputfile, indent=4)

        # Run deployment script
        subprocess.call(['/bin/bash', os.path.join(rootfolder, "AutoDeployScript.sh")])

        with open(deployment_log, 'a') as log:
            log.write("New commit has been deployed\n")
