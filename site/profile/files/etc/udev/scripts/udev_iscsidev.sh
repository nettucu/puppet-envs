#!/bin/bash

log() {
  msg="${1}"
  lvl=${2:-"debug"}
  logger "iscsidev.sh - ${msg}"
}

#{{{ BUS is available
BUS=${1}

if [[ ! -z ${BUS} ]]; then
  HOST=${BUS%%:*}
  LID=`echo ${BUS}|awk -F":" '{print $NF}'`

  log "${LINENO} BUS=${BUS},HOST=${HOST},LID=${LID}"

  [ -e /sys/class/iscsi_host ] || exit 1

  #file="/sys/class/iscsi_host/host${HOST}/device/session*/iscsi_session*/**/targetname"
  if [ -f /sys/class/iscsi_host/host${HOST}/device/session*/iscsi_session*/targetname ]; then
    file="/sys/class/iscsi_host/host${HOST}/device/session*/iscsi_session*/targetname"
  else
    file="/sys/class/iscsi_host/host${HOST}/device/session*/iscsi_session/session*/targetname"
  fi

  full_tgt_name=$( cat ${file} )

  # This is not an open-scsi drive
  [[ -z "${full_tgt_name}" ]] && exit 1

  tgt_name=${full_tgt_name##*:}
  tgt_name=${tgt_name/./-}
  target_name="${tgt_name}-$LID"

  log "Full Target Name: ${full_tgt_name}"
  log "TGT Name:         ${tgt_name}"
  log "Target Name:      ${target_name}"

  echo "${target_name##*.}"
  exit 0
fi
#}}}

# Use ID_PATH env variable if available
[[ -z $ID_PATH ]] && {
  log "NO ID_PATH available" error
  exit 1
}

log "ID_PATH=${ID_PATH}"

tgt_name=${ID_PATH##*:}

echo ${tgt_name}
