CURRENT_DIR = $(shell basename ${PWD})

up:
	@docker-compose up -d

stress-mysql: restart-mysql
	@sleep 5
	@./process-mysql.sh 'docker exec $(CURRENT_DIR)_mysql_1 mysqlslap --user=root --password=root --create-schema=employees --query=/queries.sql --verbose' 'mysql'

stress-memcached: restart-memcached
	@sleep 3
	@./process.sh 'docker run --rm --network $(CURRENT_DIR)_default dockerhub.ir/redislabs/memtier_benchmark:latest --protocol=memcache_text --server=memcached --port=11211 --generate-keys' 'memcached'

stress-redis: restart-redis
	@sleep 3
	@./process.sh 'docker run --rm --network $(CURRENT_DIR)_default dockerhub.ir/redislabs/memtier_benchmark:latest --server=redis --generate-keys' 'redis'

restart-redis:
	@docker-compose restart redis
 
restart-memcached:
	@docker-compose restart memcached

restart-mysql:
	@docker-compose restart mysql

down:	
	@docker-compose down
