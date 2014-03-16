#!/bin/bash - 
#===============================================================================
#
#          FILE: convertPdfToPngAndUploadToGoogleDrive.sh
# 
#         USAGE: ./convertPdfToPngAndUploadToGoogleDrive.sh 
# 
#   DESCRIPTION: Takes a PDF and converts it to a PNG, then it uploads the *PDF*
#                to Google Drive.
# 
#       OPTIONS: ---
#  REQUIREMENTS: Ubuntu 13.04 (or likely any Debian based OS)
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Nick Henry (NSH), nshenry03@gmail.com	
#  ORGANIZATION: 
#       CREATED: 07/17/2013 04:55:33 PM MDT
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # treat unset variables as errors

#===============================================================================
#   GLOBAL DECLARATIONS
#===============================================================================
PDF="${1}"                                      # PDF passed from command line
FILENAME="${PDF%%\.*}"                          # PDF minus the '.pdf' extension

CREDENTIAL_FILE_PATH="${HOME}/.config/google"
CREDENTIAL_FILE="${CREDENTIAL_FILE_PATH}/googleDriveCredentials"


#===============================================================================
#   SANITY CHECKS
#===============================================================================
if [ ! -f "${1}" ];then
	echo "Please provide a PDF; for example: KiwanisNewsletter_2013-05-07.pdf"
	exit 1
fi

if [ ! -f "${CREDENTIAL_FILE}" ];then
	echo "please fill $creditFile (file has just been created)"
	echo "username=$login
password=$pass">$creditFile
        exit -1
fi

dpkg -s imagemagick >/dev/null 2>&1             # is imagemagick installed?
if [[ "${?}" -ne 0 ]]; then
	echo "ImageMagick isn't installed yet. Installing now..."
	sudo apt-get --assume-yes install imagemagick
fi

dpkg -s python-setuptools >/dev/null 2>&1       # is python-setuptools installed?
if [[ "${?}" -ne 0 ]]; then
	echo "python-setuptools isn't installed yet. Installing now..."
	sudo apt-get --assume-yes install python-setuptools
fi

# Make sure that the latest Python Client has been installed
sudo easy_install --upgrade google-api-python-client
#===============================================================================
#   MAIN SCRIPT
#===============================================================================
convert ${FILENAME}{.pdf,.png}

#===============================================================================
#   STATISTICS / CLEANUP
#===============================================================================
exit 0
