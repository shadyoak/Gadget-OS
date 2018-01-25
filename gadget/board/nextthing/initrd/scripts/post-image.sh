#!/bin/bash

# Environment variables passed in from buildroot:
# BR2_CONFIG, HOST_DIR, STAGING_DIR, TARGET_DIR, BUILD_DIR, BINARIES_DIR and BASE_DIR.

echo "##############################################################################"
echo "## $0 "
echo "##############################################################################"

echo "# \$1 = $1"
echo "# \$2 = $2"

IFS=", " read -r -a EXTRA_ARGS <<< "$2"

BOARD="${EXTRA_ARGS[0]}"
NAND_CONFIG="${EXTRA_ARGS[1]}"

echo "# BOARD = $BOARD"
echo "# NAND_CONFIG = $NAND_CONFIG"
echo "# BR2_CONFIG=$BR2_CONFIG"
echo "# HOST_DIR=$HOST_DIR"
echo "# STAGING_DIR=$STAGING_DIR"
echo "# TARGET_DIR=$TARGET_DIR"
echo "# BUILD_DIR=$BUILD_DIR"
echo "# BINARIES_DIR=$BINARIES_DIR"
echo "# BASE_DIR=$BASE_DIR"

ROOT_DIR="${BR2_EXTERNAL_GADGETOS_PATH}"
BOARD_DIR=${ROOT_DIR}/board/nextthing/$BOARD

## create U-BOOT SCRIPT
mkimage -A arm -T script -C none -n "Flash" -d "${ROOT_DIR}/board/nextthing/initrd/uboot.script.source" "${1}/uboot.script"
