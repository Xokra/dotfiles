#!/bin/bash
echo "=== ZSH STARTUP PROFILING ==="
time zsh -i -c 'zprof | head -20'
