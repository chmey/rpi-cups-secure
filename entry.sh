#!/bin/bash
if [[ -z "${CUPS_PASS}" ]]; then
  # Environment variable unset, change password to random
  rndpass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1) 
  echo "print:$rndpass" | chpasswd 
  echo "May login as 'print' using password: $rndpass"
else
  # set the password to user print
  echo "print:${CUPS_PASS}" | chpasswd
fi

/usr/sbin/cupsd -f