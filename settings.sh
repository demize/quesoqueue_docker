#!/bin/sh

cat <<- EOF > settings.json
{
  "username": "$USERNAME",
  "password": "$PASSWORD",
  "channel": "$CHANNEL",
  "start_open": $START_OPEN,
  "enable_absolute_position": $ENABLE_ABS_POS,
  "custom_codes_enabled": $ENABLE_CUSTOM_CODES,
  "romhacks_enabled": $ENABLE_ROMHACKS,
  "max_size": $MAX_SIZE,
  "level_timeout": $LEVEL_TIMEOUT,
  "level_selection": [$(echo $LEVEL_SELECTION | tr \' \")],
  "message_cooldown": $MESSAGE_COOLDOWN,
  "dataIdCourseThreshold": $( if [ x$DATAID_COURSE_THRESHOLD = x ]; then echo null; elif [ x$DATAID_COURSE_THRESHOLD = xundefined ]; then echo null; else echo $DATAID_COURSE_THRESHOLD; fi),
  "dataIdMakerThreshold": $( if [ x$DATAID_MAKER_THRESHOLD = x ]; then echo null; elif [ x$DATAID_MAKER_THRESHOLD = xundefined ]; then echo null; else echo $DATAID_MAKER_THRESHOLD; fi)
}
EOF

echo "Config set up" > configured.txt
