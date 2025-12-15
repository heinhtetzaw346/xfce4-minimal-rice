#!/bin/bash
# lock.sh 

# Screenshot & blur (using maim for multi-monitor support)
maim /tmp/screen.png
convert /tmp/screen.png -blur 0x6 /tmp/screen_blur.png

# Lock screen with i3lock-color
i3lock \
  -i /tmp/screen_blur.png \
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
  --clock --date-str="%A, %d %B" \
  --time-str="%H:%M" \
  --indicator \
  --radius=100 \
  --ring-width=8

# Clean up
rm -f /tmp/screen*.png
