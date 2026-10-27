#!/bin/bash
# Quick check: can this VM run the labs?  Run: bash ~/labkit/check.sh
. /etc/os-release 2>/dev/null
echo "OS: ${PRETTY_NAME:-unknown}   Kernel: $(uname -r)"
sudo -v 2>/dev/null && echo "OK: sudo works" || echo "NO: sudo (lessons 1-3 still work)"
curl -sI --max-time 8 https://archive.ubuntu.com >/dev/null && echo "OK: internet works" || echo "NO: internet (package and container lessons won't work)"
sudo losetup -f >/dev/null 2>&1 && echo "OK: fake disks supported" || echo "NO: fake disks (read lessons 5-9 instead of running them)"
command -v git >/dev/null && echo "OK: git installed" || echo "NOTE: git missing (sudo apt install -y git)"
