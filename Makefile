# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: maxence <maxence@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/28 20:57:00 by maxence           #+#    #+#              #
#    Updated: 2025/03/04 21:03:09 by maxence          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME				=	inception

DOCKER_COMPOSE_CMD	=	docker compose
DOCKER_COMPOSE_PATH	=	srcs/docker-compose.yml

all:
	@if [ -f "./srcs/.env" ]; then \
		mkdir -p /home/maxence/data/mariadb; \
		mkdir -p /home/maxence/data/wordpress; \
		mkdir -p /home/maxence/data/uptimekuma; \
		$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) up --build -d; \
	else \
		echo "No .env file found in srcs folder, please create one before running make"; \
	fi

#
stop:
	$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) stop

down:
	$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) down -v

restart: down all

test:
	docker run -it --rm alpine:3.21.2 sh

.PHONY: test
