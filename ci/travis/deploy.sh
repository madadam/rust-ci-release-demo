#!/bin/bash

# set -ex

COMMIT_MESSAGE=$(git log -1 --oneline)

SSH_OPTS="-o StrictHostKeyChecking=no"

export SSHPASS=$APT_PASSWORD
sshpass -e ssh $SSH_OPTS ci@apt.maidsafe.net 'touch messages.txt'
sshpass -e ssh $SSH_OPTS ci@apt.maidsafe.net 'echo "$COMMIT_MESSAGE" >> messages.txt'
