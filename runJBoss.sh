#!/bin/bash - 
#===============================================================================
#
#          FILE: runJBoss.sh
# 
#         USAGE: ./runJBoss.sh 
# 
#   DESCRIPTION: Starts JBoss
# 
#       OPTIONS:
#                insecure: Listen on all interfaces rather than just localhost
#                debug:    Start JBoss in debug mode
#                help:     Display usage information
#
#  REQUIREMENTS: You must configure P2JBOSS to match your environment
#
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Nick Henry (NSH), nickh@standingcloud.com
#  ORGANIZATION: Standing Cloud
#       CREATED: 08/21/2013 03:14:44 PM MDT
#      REVISION:  0.1.0
#===============================================================================

set -o nounset                                  # treat unset variables as errors

#===============================================================================
#   GLOBAL DECLARATIONS
#===============================================================================
P2JBOSS='/opt/jboss'

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
cat <<- EOT

  Arguments:
    -i|--insecure   Listen on all interfaces rather than just localhost
    -d|--debug      Start JBoss in debug Mode
    -h|--help       Display this message

  ----------------------------------------------------------

  Example:
    ${0} --insecure --debug

EOT
}    # ----------  end of function usage  ----------

#===============================================================================
#   SANITY CHECKS
#===============================================================================

#===============================================================================
#   MAIN SCRIPT
#===============================================================================

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------
# :WARNING: The quotes around `$@' are essential! 
OPTS=$(getopt --quiet --options idh --long insecure,debug,help --name "${0}" -- "${@}")

# :WARNING: The quotes around `$OPTS' are essential!
eval set -- "$OPTS"

while true ; do
  case "${1}" in
    --insecure|-i)   JBOPTIONS="${JBOPTIONS:-} -b 0.0.0.0";                                                                      shift 1 ;;
       --debug|-d)   JBOPTIONS="${JBOPTIONS:-} -Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n"; shift 1 ;;
        --help|-h)   usage;                                                                                                       exit 0 ;;
              \? )   echo -e "\n  Option does not exist : $OPTARG\n"; usage;                                                      exit 1 ;;
               --)   shift;                                                                                                        break ;;
  esac
done

#-------------------------------------------------------------------------------
#  Cleanup before starting JBoss
#-------------------------------------------------------------------------------
rm -rf ${P2JBOSS}/server/default/{tmp,work,data}
rm -rf ${P2JBOSS}/server/default/log/*.*


#-------------------------------------------------------------------------------
#  Start JBoss
#-------------------------------------------------------------------------------
${P2JBOSS}/bin/run.sh ${JBOPTIONS}


#===============================================================================
#   STATISTICS / CLEANUP
#===============================================================================
exit 0
