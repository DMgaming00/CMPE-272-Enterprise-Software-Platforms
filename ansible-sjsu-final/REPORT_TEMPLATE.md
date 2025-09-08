# SJSU Webserver Assignment – Report Template

Fill this out and paste into Word (or export to PDF).

## 1. Overview
- Goal: Two webservers on port 8080 with different messages.
- Tools: AWS EC2, Ubuntu 22.04, Ansible, Nginx.

## 2. Architecture
- VM1 → Hello World from SJSU-1
- VM2 → Hello World from SJSU-2
- Ansible control: my laptop

## 3. Steps Performed
1. Created two EC2 instances (t2.micro, Ubuntu 22.04).
2. Security group rules: 22 (My IP), 8080 (0.0.0.0/0).
3. Configured Ansible inventory with IPs and key.
4. Ran deploy: `ansible-playbook -i inventory.ini site.yml --tags deploy`.
5. Tested in browser: `http://IP:8080`.
6. Ran undeploy: `ansible-playbook -i inventory.ini site.yml --tags undeploy`.

## 4. Screenshots
- [ ] EC2 Instances list showing both running
- [ ] Security Group inbound rules (22 + 8080)
- [ ] Terminal: `ansible -m ping`
- [ ] Terminal: deploy run output
- [ ] Browser: VM1 page (SJSU-1)
- [ ] Browser: VM2 page (SJSU-2)
- [ ] Terminal: undeploy run output
- [ ] GitHub repo page with code

## 5. Code Links
- GitHub repository URL: ___________________________

## 6. Notes / Issues
- (write any troubleshooting steps here)
