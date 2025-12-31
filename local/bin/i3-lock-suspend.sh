#!/bin/bash

scaled_img="/usr/share/backgrounds/wanderer-scaled.jpg"

i3lock \
  -i "$scaled_img" \
  --inside-color=00000088 \
  --ring-color=9ecbff \
  --verif-color=5dade2ff \
  --wrong-color=e74c3cff \
  --line-color=00000000 \
  --keyhl-color=31439e \
  --bshl-color=e74c3cff \
  --separator-color=00000000 \
  --time-color=ffffffff \
  --date-color=ffffffff \
  --layout-color=ffffffff \
  --clock \
  --date-str="%A, %d %B" \
  --time-str="%H:%M" \
  --indicator \
  --radius=100 \
  --ring-width=8
