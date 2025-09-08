# SJSU Ansible Webserver (Final Repo)

Deploy two Ubuntu servers with Nginx on **port 8080**, each serving:
- VM1 → `Hello World from SJSU-1`
- VM2 → `Hello World from SJSU-2`

This repo is **GitHub-ready**: it ships with `inventory.ini.sample`. Copy it to `inventory.ini` and fill in your two EC2 IPs and key path locally (kept out of git).

---

## Quick Runbook (any time in the future)

### 0) Prereqs (on your laptop)
- **Ansible** installed  
  - macOS: `brew install ansible`
  - Linux: `sudo apt update && sudo apt install -y ansible`
  - Windows: use WSL Ubuntu, then `sudo apt install -y ansible`
- Your AWS key file (e.g. `~/.ssh/my-aws-key.pem`) has strict perms: `chmod 400 ~/.ssh/my-aws-key.pem`

### 1) Launch two EC2 instances (Ubuntu 22.04, t2.micro)
- Security Group inbound rules:
  - SSH TCP **22** from **My IP**
  - Custom TCP **8080** from **0.0.0.0/0** (and optionally `::/0` for IPv6)
- Grab both **Public IPv4** addresses.

### 2) Prepare inventory
```bash
cd ansible-sjsu-final
cp inventory.ini.sample inventory.ini
# edit inventory.ini → put your VM IPs and key path
```

### 3) Sanity check SSH / inventory
```bash
ansible-inventory -i inventory.ini --graph
ansible -i inventory.ini webservers -m ping
```

### 4) Deploy
```bash
# Option A
ansible-playbook -i inventory.ini site.yml --tags deploy
# Option B (helper script)
./scripts/deploy.sh
```

### 5) Test
Open in your browser:
- `http://VM1_PUBLIC_IP:8080` → SJSU-1
- `http://VM2_PUBLIC_IP:8080` → SJSU-2

Or from terminal:
```bash
curl -I http://VM1_PUBLIC_IP:8080
curl -I http://VM2_PUBLIC_IP:8080
```

### 6) Undeploy (cleanup)
```bash
ansible-playbook -i inventory.ini site.yml --tags undeploy
# or
./scripts/undeploy.sh
```

### 7) Stop costs
- **Terminate** the two EC2 instances when done.

---

## Files
- `site.yml` → Playbook with **deploy**/**undeploy** (run via `--tags`).
- `templates/index.html.j2` → HTML page with `SJSU-{{ sjsu_id }}`.
- `templates/sjsu-nginx.conf.j2` → Nginx vhost listening on **8080**.
- `host_vars/vm1.yml` & `host_vars/vm2.yml` → set `sjsu_id: 1/2`.
- `inventory.ini.sample` → copy to `inventory.ini` and fill in IPs/key.
- `scripts/*.sh` → helper wrappers for common commands.
- `REPORT_TEMPLATE.md` → paste into Word for your submission.

---

## Troubleshooting (super short)
- **Browser can’t reach**: open SG inbound **8080**, use `http://IP:8080` (not https), try `curl -I http://IP:8080`.
- **Permission denied (SSH)**: correct key path, `chmod 400`, Security Group 22 from your IP, user is **ubuntu**.
- **Not listening on 8080**: `ansible --tags deploy` again, or on VM `sudo nginx -t`, `sudo ss -ltnp | grep 8080`.

---


