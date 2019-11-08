#!/bin/bash
# This file is setting up SFTP on the machine
SFTP_HOME=$"/var/lib/sftp-data"

echo "Creating directory ${SFTP_HOME} as sftp-bin folder."
mkdir ${SFTP_HOME}
echo "Folder successfully created...\n"

# Now add the environment variable to ZSH
echo "# SFTP config parameter"	  >> /etc/environment
echo SFTP_HOME=/var/lib/sftp-data >> /etc/environment

exit 0
