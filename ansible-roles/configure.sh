# Without ansible.cfg:
#  ansible-playbook -i inventory.toml playbook.yml -u ubuntu
#
# With ansible.cfg:
#ansible-playbook playbook.yml | sed 's/\\n/\n/g'
ansible-playbook playbook.yml

