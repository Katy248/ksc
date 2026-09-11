reset:
	docker compose down
	docker container prune -f
	sudo docker network rm nextcloud-aio -f
	docker volume prune -f
	docker volume rm nextcloud_aio_mastercontainer -f
	sudo rm -rf /mnt/3d1d1d2c-f491-455f-b6fe-c1c147761c82/NextcloudConfig/*
