#!/bin/sh

position=$1

sizeStr=`xrandr | grep -o -E "current [0-9]{3,} x [0-9]{3,}" | tr -d 'current'`
size=(${sizeStr//x/ })
width=${size[0]}
height=${size[1]}


((available_w=$width-20))
((available_h=$height-81))
((half_w=$available_w/2))
((half_h=$available_h/2))

if [ "$position" = "left" ];then
  eval "i3-msg move position 4 62"
  eval "i3-msg resize set $half_w $available_h"
elif [ "$position" = "right" ];then
  ((marginLeft=$half_w+10))
  eval "i3-msg move position $marginLeft 62"
  eval "i3-msg resize set $half_w $available_h"
elif [ "$position" = "top" ];then
  ((half_h=$half_h-30))
  eval "i3-msg move position 4 62"
  eval "i3-msg resize set $available_w $half_h"
elif [ "$position" = "bottom" ];then
  ((marginTop=$half_h+70))
  ((half_h=$half_h-30))
  eval "i3-msg move position 4 $marginTop"
  eval "i3-msg resize set $available_w $half_h"
fi
