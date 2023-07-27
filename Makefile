build:
	flutter build web --dart-define=DB_HOST=pokappweb-database\
      --dart-define=DB_DB=pokappweb\
      --dart-define=DB_USER=pokappadmin\
      --dart-define=DB_PWD=RlJPTSBodHRwZDpsYXRlc3QKCkNP\
      --dart-define=DB_PORT=3306

compose:
	docker-compose up --build

clean:
	flutter clean

run: clean build compose