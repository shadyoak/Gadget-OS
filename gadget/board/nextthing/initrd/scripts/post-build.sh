#!/bin/bash

echo "##############################################################################"
echo "## $0 "
echo "##############################################################################"

ROOT_DIR="${BR2_EXTERNAL_GADGETOS_PATH}"
BOARD_DIR=${ROOT_DIR}/board/nextthing/chippro

echo "TERM=xterm" | tee -a ${TARGET_DIR}/etc/profile
