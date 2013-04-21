#!/bin/bash

USER=$1
EXERCISE=$2

# Validate that User is only letters and exercise is only numbers

if [[ ! $USER =~ ^[a-z]+$ ]]; then
  echo "USER parameter was invalid"
  exit
fi

if [[ ! $EXERCISE =~ ^[a-z]+$ ]]; then
  echo "EXERCISE parameter was invalid"
  exit
fi

if [ ! -d ../../exercises/$EXERCISE ]; then
  echo "Exercise $EXERCISE does not exists."
  exit
fi

NAME=$USER$EXERCISE

# Create user with correct home folder template
useradd -m -k ../../exercises/$EXERCISE $NAME

# Create PostgreSQL user and database for user
createuser -S -D -R $NAME
createdb -O $NAME $NAME

# Replace placeholders in with NAME
cd /home/$NAME
find . -type f -print0 | xargs -0 sed -i "s/PLACEHOLDER/$NAME/g"

# Give correct permissions to app
chmod 755 public_html/app

# Run setup script if present
cd public_html/app/

if [ -f setup.sh ]; then
  chmod u+x setup.sh
  su $NAME -c ./setup.sh
fi
