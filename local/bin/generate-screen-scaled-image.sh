#!/bin/bash
set -e

if [ "$#" -eq 0 ]; then
	read -p "Please enter the original image path -> " img
	read -p "Please enter the scaled image path -> " scaled_img
else
	img="$1"
	scaled_img="$2"
fi

# Get primary screen resolution
res=$(xrandr | awk '/\*/ {print $1; exit}')

# Resize image to fill screen while preserving aspect ratio
convert "$img" \
	-resize "${res}^" \
	-gravity center \
	-extent "$res" \
	"$scaled_img"

echo "Scaled image saved at $scaled_img"
