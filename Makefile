# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmorales <moralesrojascr@gmail.com>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/31 20:40:36 by anmarque          #+#    #+#              #
#    Updated: 2023/07/13 20:12:49 by cmorales         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#/--------------COLORS-----------------/
NOC         = \033[0m
BOLD        = \033[1m
UNDERLINE   = \033[4m

DEFAULT = \033[0;39m
GRAY = \033[0;90m
RED = \033[0;91m
GREEN = \033[0;92m
YELLOW = \033[0;93m
BLUE = \033[0;94m
MAGENTA = \033[0;95m
CYAN = \033[0;96m
WHITE = \033[0;97m

INFO = $(CYAN) ℹ️
SUCCESS = $(GREEN) ✅
WARNING = $(WHITE)[$(YELLOW)⚠️$(WHITE)] $(YELLOW)
ERROR = $(WHITE)[$(RED)❌$(WHITE)] $(RED)
WARNING = $(WHITE)[$(YELLOW)⚠️$(WHITE)] $(YELLOW)
TRASH = $(RED) 🗑


#/-----------Files and Flags--------------------/
NAME = Cub3D

BONUS = 0

CC = gcc

CFLAGS = -Wall -Wextra -Werror  -g 

SRC_DIR = ./src/
OBJ_DIR = ./obj/

INC = ./includes/

MAP = map map_utils map_data minimap
PLAYER = player movement player_utils
HOOKS = hooks
PAINT = paint line repaint coord_paint_p
COLLISIONS = collisions collision_utils collision_sides
RAYCASTING = raycast raycast_horizontal raycast_vertical cast
PARSE = argv_check get_comp parse_utils parse rgb atoi_base itoa_base map_check walls clean_up
COLOR = color

SRCS = 	$(addsuffix .c, $(addprefix map/, $(MAP))) \
		$(addsuffix .c, $(addprefix hooks/, $(HOOKS))) \
		$(addsuffix .c, $(addprefix paint/, $(PAINT))) \
		$(addsuffix .c, $(addprefix player/, $(PLAYER))) \
		$(addsuffix .c, $(addprefix collisions/, $(COLLISIONS))) \
		$(addsuffix .c, $(addprefix raycasting/, $(RAYCASTING))) \
		$(addsuffix .c, $(addprefix parse/, $(PARSE))) \
		$(addsuffix .c, $(addprefix color/, $(COLOR))) \
		utils.c \
		main.c \

OBJS = $(addprefix $(OBJ_DIR), $(SRCS:.c=.o))


#/--------------Libft-----------------/
LIBFT = -L libft -lft

LIBFT_INC = ./libft


#/--------------MLX42-----------------/
MLX42_LIB = MLX42/build/libmlx42.a

MLX42 = ./MLX42/

DEPENDENCIES_MAC = $(MLX42_LIB) -framework Cocoa -framework OpenGL -framework IOKit

DEPENDENCIES_LINUX = $(MLX42_LIB) -Iinclude -ldl -lglfw -pthread -lm

INC_MLX = $(MLX42)/include

GLFW =  -lglfw -L"/Users/$(USER)/.brew/opt/glfw/lib/"

LINUX = Linux
MAC = Darwin

MEMORY_LEAKS = ./memory-leaks/memory_leaks.a
MEMORY_LEAKS_INC = ./memory-leaks/include

#/--------------Actions-----------------/
all:  lib obj  $(NAME)


obj:
	@echo "$(INFO) Creating objects folder... $(NOC)"
	@mkdir -p $(OBJ_DIR)
	@mkdir -p $(OBJ_DIR)/map
	@mkdir -p $(OBJ_DIR)/hooks
	@mkdir -p $(OBJ_DIR)/paint
	@mkdir -p $(OBJ_DIR)/player
	@mkdir -p $(OBJ_DIR)/collisions
	@mkdir -p $(OBJ_DIR)/raycasting
	@mkdir -p $(OBJ_DIR)/parse
	@mkdir -p $(OBJ_DIR)/color

lib:
	@make -C ./libft
	@echo "$(NOC)"

$(MLX42_LIB):
	@echo "$(INFO) Compiling MLX42... $(NOC)"
	cmake $(MLX42) -B $(MLX42)/build
	make -C $(MLX42)/build -j4

$(MEMORY_LEAKS):
		make -C ./memory-leaks

ifeq ($(shell uname -s), $(LINUX))

$(OBJ_DIR)%.o:$(SRC_DIR)%.c $(MLX42_LIB)
	@$(CC) $(CFLAGS) -DBONUS=$(BONUS) -I $(INC) -I $(LIBFT_INC) -I $(INC_MLX) -I $(MEMORY_LEAKS_INC) -o $@ -c $<
-include $(OBJ_DIR)*.d

$(NAME): $(OBJS) $(MLX42_LIB) $(MEMORY_LEAKS)
	@echo "$(INFO) Building $(NAME)...$(NOC)"
	@$(CC) $(CFLAGS) -DBONUS=$(BONUS) $(MEMORY_LEAKS) $(OBJS) $(DEPENDENCIES_LINUX) $(LIBFT) -o $(NAME)
	@echo "$(SUCCESS)$(NAME) built successfully!$(NOC)"


else ifeq ($(shell uname -s), $(MAC))

$(OBJ_DIR)%.o:$(SRC_DIR)%.c $(MLX42_LIB)
	@$(CC) $(CFLAGS) -DBONUS=$(BONUS) -I $(INC) -I $(LIBFT_INC) -I $(INC_MLX) -I $(MEMORY_LEAKS_INC) -o $@ -c $<
-include $(OBJ_DIR)*.d

$(NAME): $(OBJS) $(MLX42_LIB) $(MEMORY_LEAKS)
	@echo "$(INFO) Building $(NAME)...$(NOC)"
	@$(CC) $(CFLAGS) -DBONUS=$(BONUS) $(MEMORY_LEAKS) $(OBJS) $(LIBFT) $(DEPENDENCIES_MAC) $(GLFW) -o $(NAME)
	@echo "$(SUCCESS)$(NAME) built successfully!$(NOC)"

endif


clean:
	@make clean -C libft/
	@make -C ./memory-leaks fclean
	@echo "$(NOC)"
	@echo "$(TRASH) Deleting .o files...$(NOC)"
	@rm -rf $(MLX42)/build 
	@rm -rf obj $(OBJS)
	@echo "$(SUCCESS).o files deleted successfully!$(NOC)"
	
	
fclean: clean
	@echo "$(TRASH) Deleting $(NAME)...$(NOC)"
	@rm -rf obj $(NAME)
	@rm -rf $(NAME).dSYM
	@echo "$(SUCCESS)$(NAME) deleted successfully!$(NOC)"


re: fclean 
	@make all

r: all
	./$(NAME) assets/maps/01.cub  

val: all
	valgrind --leak-check=full ./$(NAME)
	rm -rf $(NAME).dSYM

bonus:
	@echo "$(INFO) Building $(NAME) with bonus...$(NOC)"
	@make re BONUS=1
	@echo "$(SUCCESS) $(NAME) built successfully with bonus!$(NOC)"
	
.PHONY:	all clean fclean re val