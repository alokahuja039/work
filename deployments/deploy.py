import json
import os
import shutil
import sys

f = open('deployments/config.json')
data = json.load(f)

DEPLOYMENT_PATH = 'deployments/deploy/'


def deploy_files():
    if data.get('files_upload'):
        for i in data['files_upload']:

            deploy_path = DEPLOYMENT_PATH + i['dir']

            if 'file' in i:
                print('processing file: {}'.format(i['file']))
                if not os.path.exists(deploy_path):
                    os.makedirs(deploy_path)
                shutil.copy(i['file'], deploy_path)
            else:
                print('processing folder: {}'.format(i['dir']))
                shutil.copytree(i['dir'], deploy_path, dirs_exist_ok=True)
        f.close()


def get_files_to_delete():
    if data.get('files_to_delete') and data['files_to_delete'].get('files'):
        files = data['files_to_delete']['files']
        print(":".join(files))

def get_dirs_to_delete():
    if data.get('files_to_delete') and data['files_to_delete'].get('dirs'):
        files = data['files_to_delete']['dirs']
        files = [f'{file}*' for file in files]
        print("*:".join(files))

if __name__ == '__main__':
    globals()[sys.argv[1]]()