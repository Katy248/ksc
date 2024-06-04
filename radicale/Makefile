SERVICE = radicale
SERVICE_FILE = $(SERVICE).service
INSTALLED_SERVICE_FILE = /etc/systemd/system/$(SERVICE_FILE)

all:
	echo "Fuck"
install: $(INSTALLED_SERVICE_FILE)
	python -m pip install --upgrade radicale
	systemctl daemon-reload
	systemctl enable --now $(SERVICE)
	systemctl status $(SERVICE)
	echo "Look now at http://localhost:5232"

uninstall:
	systemctl stop $(SERVICE)
	systemctl disable $(SERVICE)
	rm -f $(INSTALLED_SERVICE_FILE)

$(INSTALLED_SERVICE_FILE): $(SERVICE_FILE)
	cp $< $@
	
