#!/bin/bash
#####
# WinVMTyping
#####
# Get something in your copy buffer and then, launch WinVMTyping.
# It will use X server commands to write what's in the copy buffer to the
# selected window and hit enter.
# Created initially to enable auto password typing in Windows
# Windows virtual machines at login
#####

MISSING_REQUIREMENTS=""

# Cheking requirements
if ! command -v xsel &> null
then
    MISSING_REQUIREMENTS="$MISSING_REQUIREMENTS xsel"
fi

if ! command -v xdotool &> null
then
    MISSING_REQUIREMENTS="$MISSING_REQUIREMENTS xdotool"
fi

if ! [ -n MISSING_REQUIREMENTS ]
then
    echo "Missing requirement, please install following packages"
    echo "$MISSING_REQUIREMENTS"
    exit
fi

# Getting content of copy buffer
XDOTYPE=$(xsel)

# Enforce X server control over the keyboard layout
setxkbmap
# On selected X window, typing the content of copy buffer and hit Enter
xdotool selectwindow windowfocus type $XDOTYPE
xdotool key Return
