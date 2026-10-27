# labkit

Hands-on practice labs for **CompTIA Linux+ (XK0-006)**.

Every script only creates **fake practice data** (made-up companies, users and files). Run them in a throwaway Linux VM, never on a computer you care about.

## Get the kit (type this in the VM terminal)

With git:

```bash
sudo apt install -y git
git clone https://github.com/TripleB384/labkit ~/labkit
```

Without git:

```bash
cd ~ && curl -sL https://github.com/TripleB384/labkit/archive/main.tar.gz | tar xz && mv labkit-main labkit
```

Get the newest version later: `cd ~/labkit && git pull`

## Set up a lab

| Lessons | Command | What it makes |
|---|---|---|
| 1–4 (shell, text tools, devices) | `bash ~/labkit/u1.sh` | `~/linuxlab` with fake logs, a customer list and a config file |
| 5–9 (partitions, RAID, LVM, mounts, filesystems) | `sudo bash ~/labkit/u1-disks.sh` then `source /tmp/disks.env` | Five fake 300 MB disks (loop devices). VM only. |
| Reset the storage labs | `sudo bash ~/labkit/u1-clean.sh` | Removes the fake disks, RAID array, LVM pool and lab fstab lines |
| 10–15 (files, users, processes, packages, systemd, containers) | `bash ~/labkit/u2.sh` | `~/linuxlab2` with fake employees, a fake app, unit files and a Containerfile |

Run any setup again to reset it.

## Lab steps

Each lesson's steps, commands and expected output are in `steps/`:

```bash
less ~/labkit/steps/l10.txt
```

Inside `less`: arrow keys scroll, `/word` searches, `q` quits.
To copy a command inside the VM terminal: select it with the mouse, then `Ctrl+Shift+C`, and paste with `Ctrl+Shift+V`.

| File | Lesson | Objective |
|---|---|---|
| l01 | Redirection & Pipes | 1.5 |
| l02 | Text Tools & Regex | 1.5 |
| l03 | Shell Skills & Editors | 1.5 |
| l04 | Devices, Modules & initrd | 1.2 |
| l05 | Partitions | 1.3 |
| l06 | RAID | 1.3 |
| l07 | LVM | 1.3 |
| l08 | Mounting & fstab | 1.3 |
| l09 | Filesystems & Inodes | 1.3 |
| l10 | Files & Directories | 2.1 |
| l11 | Users & Groups | 2.2 |
| l12 | Processes & Jobs | 2.3 |
| l13 | Software & Packages | 2.4 |
| l14 | systemd | 2.5 |
| l15 | Containers | 2.6 |
