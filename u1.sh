#!/bin/bash
# Linux+ Unit 1 lab setup — creates FAKE practice data in ~/linuxlab
# Safe: only writes inside ~/linuxlab. Run again anytime to reset.

LAB="$HOME/linuxlab"
rm -rf "$LAB"
mkdir -p "$LAB/config" "$LAB/scripts" "$LAB/reports"
cd "$LAB" || exit 1

# --- customers.csv : fake pool-service company customers ---
cat > customers.csv << 'EOF'
id,name,city,plan,monthly
101,Ana Reyes,Springfield,Gold,149
102,Ben Carter,Riverside,Basic,59
103,Carla Diaz,Springfield,Silver,99
104,Dev Patel,Lakeside,Gold,149
105,Eva Brooks,Fairview,Basic,59
106,Frank Lee,Springfield,Basic,59
107,Gina Torres,Riverside,Silver,99
108,Hugo Martin,Lakeside,Basic,59
109,Iris Chen,Springfield,Gold,149
110,Jake Wood,Fairview,Silver,99
111,Kim Nguyen,Riverside,Gold,149
112,Leo Grant,Springfield,Silver,99
EOF

# --- app.log : fake application log ---
cat > app.log << 'EOF'
2026-10-19 08:00:01 INFO server: starting web app
2026-10-19 08:00:02 INFO db: connected to database
2026-10-19 08:05:13 WARN disk: /var is 81% full
2026-10-19 08:10:45 INFO api: GET /customers 200
2026-10-19 08:11:02 ERROR db: connection refused
2026-10-19 08:11:05 INFO db: retrying connection
2026-10-19 08:11:09 INFO db: connected to database
2026-10-19 08:30:22 WARN api: slow response 2400ms
2026-10-19 09:02:51 ERROR api: POST /invoice 500
2026-10-19 09:15:00 INFO backup: nightly job queued
2026-10-19 09:40:18 WARN disk: /var is 88% full
2026-10-19 10:01:33 ERROR disk: /var is 97% full
2026-10-19 10:05:00 INFO server: health check ok
EOF

# --- access.log : fake web server log (IP first) ---
cat > access.log << 'EOF'
10.0.0.5 - - [19/Oct/2026:08:10:45] "GET /customers HTTP/1.1" 200
10.0.0.7 - - [19/Oct/2026:08:12:01] "GET /login HTTP/1.1" 200
10.0.0.5 - - [19/Oct/2026:08:15:22] "GET /invoice HTTP/1.1" 200
192.168.1.20 - - [19/Oct/2026:08:20:10] "POST /login HTTP/1.1" 401
10.0.0.5 - - [19/Oct/2026:08:25:30] "GET /reports HTTP/1.1" 200
192.168.1.20 - - [19/Oct/2026:08:26:11] "POST /login HTTP/1.1" 401
10.0.0.9 - - [19/Oct/2026:08:40:00] "GET /customers HTTP/1.1" 200
192.168.1.20 - - [19/Oct/2026:08:41:42] "POST /login HTTP/1.1" 401
10.0.0.7 - - [19/Oct/2026:09:02:51] "POST /invoice HTTP/1.1" 500
10.0.0.5 - - [19/Oct/2026:09:30:05] "GET /customers HTTP/1.1" 200
EOF

# --- config/app.conf : fake config with comments and blank lines ---
cat > config/app.conf << 'EOF'
# App configuration file
# Lines starting with # are comments

port=8080
host=0.0.0.0

# Database settings
db_host=localhost
db_user=poolapp
debug=true

# Email
smtp_server=mail.example.com
EOF

# --- scripts/hello.sh : tiny script for the noexec mount lab ---
cat > scripts/hello.sh << 'EOF'
#!/bin/bash
echo "Hello from the lab script!"
EOF
chmod +x scripts/hello.sh

# --- servers.txt : unsorted list with duplicates ---
cat > servers.txt << 'EOF'
web02
db01
web01
web02
cache01
db01
web02
EOF

echo ""
echo "Lab ready in $LAB"
ls -R "$LAB"
