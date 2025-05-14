[webservers]
%{ for idx, ip in public_ips ~}
web${idx + 1} ansible_host=${ip} ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/id_rsa
%{ endfor ~}