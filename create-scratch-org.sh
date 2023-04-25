#!/bin/sh
# Use this script to create scratch or for development

echo "Clean up previous scratch org..."
sfdx force:org:delete -p

echo "Creating scratch org..."
sfdx force:org:create -f config/project-scratch-def.json -d 30 -w 15 -s -a $1

# Installing of packages, uncomment if required
#echo "Install packages..."
#echo "Install Batch Panel:"
#sfdx force:package:install --wait 10 --publishwait 10 --package 04t3V000000JhSjQAK -k RdHf5S23jLk --noprompt
#echo "Install Trigger Framework:"
#sfdx force:package:install --wait 10 --publishwait 10 --package 04t3V000000JhbCQAS -k DgE6Gf9GzWd --noprompt
#echo "Install Integration Framework:"
#sfdx force:package:install --wait 10 --publishwait 10 --package 04t3V000000JhZaQAK -k DgE6Gf9GzWd --noprompt

echo "Pushing project in progress..."
sfdx force:org:open -p 'lightning/setup/DeployStatus/home'
sfdx force:source:push -f

echo "Post setup in progress..."

# Assigning permission sets, uncomment if required
#echo "Assign permission set or group to admin user..."
#sfdx force:user:permset:assign --permsetname YOUR_PERM_SET_OR_GROUP_NAME

#Importing of data, uncomment if required:
#echo "Importing of data..."
#sfdx force:data:tree:import -p data/YOUR_DATA_IMPORRT_FILE.json

