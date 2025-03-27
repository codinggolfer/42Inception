NAME = inception
ENV_FILE := srcs/.env
SRC_DIR = srcs

all:
	@mkdir -p /home/eagbomei/data/wordpress
	@mkdir -p /home/eagbomei/data/mariadb
	@echo "Building and starting $(NAME)..."
	docker-compose -f $(SRC_DIR)/docker-compose.yml up --env-file $(ENV_FILE) --build -d
	@ready

down:
	@echo "Stopping and removing containers..."
	@docker-compose -f $(SRC_DIR)/docker-compose.yml --env-file $(ENV_FILE) down
	@echo cleaning

clean: down
	@echo "Removing volumes..."
	@docker volume rm mariadb_data wordpress_data || true

fclean: clean
	@echo "Removing all images..."
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf /home/eagbomei/data/wordpress
	@sudo rm -rf /home/eagbomei/data/mariadb
	@echo fcleaned

re: fclean all

.PHONY: all down clean fclean re