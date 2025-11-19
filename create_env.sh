#!/bin/bash
python3 deployments/deploy.py get_files_to_delete
export FILES_TO_DELETE=$(python3 deployments/deploy.py get_files_to_delete  2>&1)

python3 deployments/deploy.py get_dirs_to_delete
export DIRS_TO_DELETE=$(python3 deployments/deploy.py get_dirs_to_delete  2>&1)