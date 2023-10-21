#!/bin/sh

MIB_MAIN_DIR="/mibs"
ORIGINAL_MIBDIRS=${MIBDIRS:-}
NEW_MIBDIRS=$(find $MIB_MAIN_DIR -type d | grep -v "^$MIB_MAIN_DIR$" | tr '\n' ':' | sed 's/:$//')
MIBDIRS="$NEW_MIBDIRS:$ORIGINAL_MIBDIRS"
MIBDIRS=$(echo $MIBDIRS | sed 's/:$//')
export MIBDIRS

# Execute the passed command
exec "$@"
