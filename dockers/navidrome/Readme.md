# My _Navidrome_ container

## Setup

Service won't start without `.env` file in this folder

Copy `.env.example` to `.env` and fill it with valid data from <https://www.last.fm/api/accounts> page

```bash
cp ./.env.example ./.env
xdg-open https://www.last.fm/api/accounts &
$EDITOR ./.env
```

## Run

```bash
sudo docker compose up -d
```
