NAME = inception

SRC_DIR = srcs

all:
	@mkdir -p /home/eagbomei/data/wordpress
	@mkdir -p /home/eagbomei/data/mariadb
	@echo "Building and starting $(NAME)..."
	docker-compose -f $(SRC_DIR)/docker-compose.yml up --build

down:
	@echo "Stopping and removing containers..."
	docker-compose -f $(SRC_DIR)/docker-compose.yml down

clean: down
	@echo "Removing volumes..."
	docker volume rm mariadb_data wordpress_data || true

fclean: clean
	@echo "Removing all images..."
	docker rmi srcs-nginx srcs-wordpress srcs-mariadb || true

re: fclean all

.PHONY: all down clean fclean re