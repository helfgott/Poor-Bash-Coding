#!/bin/bash
# miguelleonardo.ortiz

TOKEN='<YOUR GITHUB TOKEN>'
ORG='<YOUR_ORG>'
REPO_NAME=$1
REPO="https://${TOKEN}@github.com/${ORG}/${REPO_NAME}"
TICKET='<JIRA_TICKET>'
KEYWORDS='<YOUR-KEYWORDS>'
VERSION=$2
BRANCH_VERSION="remotebranch/${VERSION}" #it could be master too, but then version would not be used.
NEW_REMOTE_BRANCH="${TICKET}-${KEYWORDS}-${VERSION}"

# Will clone an specific branch and create a new remote branch based on it.
# E.g: remotebranch/1.1 --> origin/JIRA-123-YOUR-KEYWORDS-1.1

#------------------------------------------------------

if [[ -d "${REPO_NAME}" ]]
then
   echo "Deleting existing local repository: ${REPO_NAME}"
   rm -rf ${REPO_NAME}
fi
        echo 'Git clone:'
        echo "git clone -b ${BRANCH_VERSION} ${REPO}"

git clone -b ${BRANCH_VERSION} ${REPO}

        echo "Moving to repo:"
        echo "cd ${REPO_NAME}"

cd ${REPO_NAME}

        echo "Creating new local branch:"
        echo "git checkout -b ${NEW_REMOTE_BRANCH}"

git checkout -b ${NEW_REMOTE_BRANCH}

        echo "Pushing new branch to remote:"
        echo "git push -u origin ${NEW_REMOTE_BRANCH}"

git push -u origin ${NEW_REMOTE_BRANCH}
