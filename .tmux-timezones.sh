#!/bin/bash
sv=$(/usr/bin/env TZ=America/Los_Angeles date +'%a %d %b %Y %H:%M')
bali=$(/usr/bin/env TZ=Asia/Makassar date +'%a %d %b %Y %H:%M')
jakarta=$(/usr/bin/env TZ=Asia/Jakarta date +'%a %d %b %Y %H:%M')
echo "#[bg=#16161e,fg=#8a3fa6]#[bg=#8a3fa6,fg=#e0e0e9,bold] SV: $sv #[bg=#8a3fa6,fg=#16161e]#[bg=#16161e,fg=#2aa198]#[bg=#2aa198,fg=#d4af37,bold] Bali: $bali #[bg=#2aa198,fg=#16161e]#[bg=#16161e,fg=#737aa2]#[bg=#737aa2,fg=#e0e0e9,bold] Jakarta: $jakarta"
