#!/bin/bash
# Undo everything from the storage labs. Run with: sudo bash u1-clean.sh
[ "$EUID" -ne 0 ] && { echo "Run with sudo"; exit 1; }

# Remove any lab lines added to /etc/fstab (lesson 8)
if grep -q "vg_lab" /etc/fstab; then
  cp /etc/fstab /etc/fstab.before-cleanup
  sed -i '/vg_lab/d' /etc/fstab
  echo "Removed lab entries from /etc/fstab"
fi

for m in /mnt/data /mnt/xfsdata /mnt/raid /mnt/tiny /mnt/ram; do
  umount "$m" 2>/dev/null
done
mdadm --stop /dev/md0 2>/dev/null
vgchange -an vg_lab 2>/dev/null
vgremove -f vg_lab 2>/dev/null
for l in $(losetup -a | grep /root/disklab | cut -d: -f1); do
  pvremove -ff -y "$l" >/dev/null 2>&1
  wipefs -a "$l" >/dev/null 2>&1
  losetup -d "$l"
done
rm -rf /root/disklab /tmp/disks.env
echo "Storage lab cleaned up. Run u1-disks.sh again for a fresh start."
