#!/bin/bash
# Linux+ Unit 1 STORAGE lab setup — creates 5 FAKE disks (image files)
# and attaches them as loop devices. Nothing touches your real disk.
# Run with:  sudo bash u1-disks.sh
# ONLY run this in a throwaway lab VM (never your own computer)

if [ "$EUID" -ne 0 ]; then
  echo "Run me with sudo:  sudo bash u1-disks.sh"; exit 1
fi

# Install the tools the labs need (Ubuntu/Debian/Kali). Safe to re-run.
if command -v apt-get >/dev/null; then
  echo "Installing storage tools (can take a minute)..."
  apt-get update -qq >/dev/null 2>&1
  DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
    lvm2 mdadm xfsprogs btrfs-progs fdisk gdisk parted >/dev/null 2>&1
fi

missing=""
for t in pvcreate mdadm mkfs.xfs mkfs.btrfs fdisk gdisk parted losetup; do
  command -v "$t" >/dev/null || missing="$missing $t"
done
if [ -n "$missing" ]; then
  echo "WARNING: missing tools:$missing"
  echo "  The VM may have no internet. Lessons that use these will fail."
fi

DL=/root/disklab
mkdir -p "$DL"
cd "$DL" || exit 1

: > disks.env
for n in 1 2 3 4 5; do
  if [ ! -f disk$n.img ]; then
    truncate -s 300M disk$n.img
  fi
  dev=$(losetup -j "$DL/disk$n.img" | cut -d: -f1)
  if [ -z "$dev" ]; then
    dev=$(losetup -fP --show "$DL/disk$n.img")
  fi
  if [ -z "$dev" ]; then
    echo "ERROR: could not attach disk$n.img. This VM may not allow loop devices."
    echo "  Do the storage lessons by reading the steps and expected output."
    exit 1
  fi
  echo "export DISK$n=$dev" >> disks.env
done
cp disks.env /tmp/disks.env
chmod 644 /tmp/disks.env

echo ""
echo "Fake disks ready (each 300 MB):"
cat disks.env
echo ""
echo "NEXT: type this so \$DISK1..\$DISK5 work in your shell:"
echo "  source /tmp/disks.env"
echo ""
echo "Plan:  DISK1 = partitions lab | DISK2+DISK3 = LVM lab | DISK4+DISK5 = RAID lab"
