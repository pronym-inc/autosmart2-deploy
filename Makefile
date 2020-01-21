export VAGRANT_GIT_EMAIL=$(shell git config --get user.email)
export VAGRANT_GIT_NAME=$(shell git config --get user.name)

spinup:
	echo "192.168.50.42  autosmart2.local" | sudo tee -a /etc/hosts
	cp ~/.ssh/id_rsa git_ssh_key
	vagrant up
	sleep 5s
	open -a "Google Chrome" http://autosmart2.local
update:
	vagrant ssh -c "sudo sudo -u autosmart2 git -C /webapps/autosmart2/src/autosmart2 pull"
	vagrant ssh -c "sudo sudo -u autosmart2 HOME=/home/autosmart2 /webapps/autosmart2/bin/pip install -r /webapps/autosmart2/src/autosmart2/requirements.pip --upgrade"
	vagrant ssh -c "sudo sudo -u autosmart2 /webapps/autosmart2/bin/python /webapps/autosmart2/bin/manage.py migrate"