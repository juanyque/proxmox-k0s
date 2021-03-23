# bash:
#read -s -p "Introduzca la password del usuario administrador de proxmox (root@pam): " password
# zsh:
read -rs 'password?Introduzca la password del usuario administrador de proxmox (root@pam):'

export TF_VAR_pm_api_url=https://server:8006/api2/json
export TF_VAR_pm_user=root@pam
export TF_VAR_pm_pass=$password

