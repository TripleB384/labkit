#!/bin/bash
# Linux+ Unit 2 lab setup — creates FAKE practice data in ~/linuxlab2
# Run as your normal user (no sudo):  bash u2.sh
# Safe to run again anytime to reset.

L2="$HOME/linuxlab2"
rm -rf "$L2"
mkdir -p "$L2"/{projects/web,projects/old,projects/empty,configs,scripts,units,container}
cd "$L2" || exit 1

# --- newhires.csv : fake employees to turn into Linux accounts (lesson 11) ---
cat > newhires.csv << 'EOF'
username,fullname,dept
areyes,Ana Reyes,sales
bcarter,Ben Carter,support
cdiaz,Carla Diaz,support
dpatel,Dev Patel,admin
EOF

# --- projects/ : messy folder for find, stat, du (lesson 10) ---
echo "<h1>Pool Pros</h1>" > projects/web/index.html
echo "body{color:navy}"   > projects/web/style.css
head -c 5M /dev/zero > projects/web/video-promo.mp4
head -c 2M /dev/zero > projects/old/backup-2025.tar
echo "old notes"          > projects/old/notes.txt.bak
echo "draft"              > projects/old/draft.txt.bak
echo "temp"               > projects/old/cache.tmp
touch -d "45 days ago" projects/old/backup-2025.tar projects/old/notes.txt.bak
touch -d "10 days ago" projects/old/draft.txt.bak
echo "password=hunter2"   > projects/web/secrets.txt
chmod 777 projects/web/secrets.txt
printf '#!/bin/bash\necho deploy\n' > projects/web/deploy.sh
chmod +x projects/web/deploy.sh

# --- configs/ : two versions of a config for diff/sdiff (lesson 10) ---
cat > configs/site-v1.conf << 'EOF'
server_name poolpros.local
listen 80
root /var/www/html
gzip off
EOF
cat > configs/site-v2.conf << 'EOF'
server_name poolpros.local
listen 443
root /var/www/html
gzip on
ssl_certificate /etc/ssl/pool.crt
EOF

# --- scripts/ : fake programs for process + systemd labs (lessons 12, 14) ---
cat > scripts/poolapp.sh << EOF
#!/bin/bash
# Fake app: writes a heartbeat line every 5 seconds
while true; do
  echo "\$(date '+%H:%M:%S') poolapp heartbeat" >> $L2/poolapp.log
  sleep 5
done
EOF
cat > scripts/cpuhog.sh << 'EOF'
#!/bin/bash
# Burns CPU on purpose so you can practice nice, renice and kill
while :; do :; done
EOF
cat > scripts/report.sh << EOF
#!/bin/bash
echo "\$(date '+%F %T') nightly report ran" >> $L2/report.log
EOF
chmod +x scripts/*.sh

# --- units/ : systemd unit files ready to install (lesson 14) ---
cat > units/poolapp.service << EOF
[Unit]
Description=Pool Pros fake web app
After=network.target

[Service]
Type=simple
User=$USER
ExecStart=$L2/scripts/poolapp.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
cat > units/poolreport.service << EOF
[Unit]
Description=Pool Pros report job

[Service]
Type=oneshot
User=$USER
ExecStart=$L2/scripts/report.sh
EOF
cat > units/poolreport.timer << 'EOF'
[Unit]
Description=Run the Pool Pros report every minute

[Timer]
OnCalendar=*-*-* *:*:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

# --- container/ : files to build your own image (lesson 15) ---
cat > container/index.html << 'EOF'
<h1>Pool Pros - running in a container</h1>
EOF
cat > container/Containerfile << 'EOF'
FROM docker.io/library/nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF

echo ""
echo "Unit 2 lab ready in $L2"
ls "$L2"
