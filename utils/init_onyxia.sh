#!/bin/sh

SECTION=$1
CHAPTER=$2

WORK_DIR=/home/onyxia/work
CLONE_DIR=${WORK_DIR}/repo-git
COURSE_DIR=${CLONE_DIR}/source

# Clone course repository
REPO_URL=https://github.com/InseeFrLab/formation-python-initiation.git
git clone --depth 1 $REPO_URL $CLONE_DIR

# Put chapter data in the training dir
rm $COURSE_DIR/${SECTION}/${CHAPTER}/tutorial.qmd
cp ${COURSE_DIR}/${SECTION}/${CHAPTER}/* ${WORK_DIR}/

# Give write permissions
chown -R onyxia:users ${WORK_DIR}/

# Install additional packages if needed
REQUIREMENTS_FILE=${FORMATION_DIR}/requirements.txt
[ -f $REQUIREMENTS_FILE ] && pip install -r $REQUIREMENTS_FILE && rm $REQUIREMENTS_FILE

# Remove course Git repository
rm -r $CLONE_DIR

# Open the relevant notebook when starting Jupyter Lab
# jupyter server --generate-config
echo "c.LabApp.default_url = '/lab/tree/formation/tutorial.ipynb'" >> /home/onyxia/.jupyter/jupyter_server_config.py