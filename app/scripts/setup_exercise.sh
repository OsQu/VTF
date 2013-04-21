#!/bin/bash

USER=$1
EXERCISE=$2
EXERCISE_ROOT=exercises

# Validate that User is only letters and exercise is only numbers

if [[ ! $USER =~ ^[a-z]+$ ]]; then
  echo "USER parameter was invalid"
  exit 1
fi

if [[ ! $EXERCISE =~ ^[a-z]+$ ]]; then
  echo "EXERCISE parameter was invalid"
  exit 1
fi

if [ ! -d $EXERCISE_ROOT/$EXERCISE ]; then
  echo "Exercise $EXERCISE does not exists."
  exit 1
fi

NAME=$USER$EXERCISE

# Create user with correct home folder template
echo "Creating user.."
useradd -m -k $EXERCISE_ROOT/$EXERCISE $NAME

# Create PostgreSQL user and database for user
echo "Creating postgresql user"
createuser -S -D -R $NAME
echo "Creating database"
createdb -O $NAME $NAME

# Replace placeholders in with NAME
echo "Replacing placeholder with name"
cd /home/$NAME
find . -type f -print0 | xargs -0 sed -i "s/PLACEHOLDER/$NAME/g"

# Give correct permissions to app
echo "Permissioins to app"
chmod 755 public_html/app

# Run setup script if present
echo "Running the setup script if exists"
cd public_html/app/

if [ -f setup.sh ]; then
  echo "existed! chmodding.."
  chmod u+x setup.sh
  echo "and running"
  su $NAME -c ./setup.sh
fi
