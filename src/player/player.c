/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   player.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cmorales <moralesrojascr@gmail.com>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/06/05 18:08:03 by cmorales          #+#    #+#             */
/*   Updated: 2023/06/08 00:09:32 by cmorales         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "cub3D.h"

void init_player(t_player *player, t_game *game)
{
    player->pos_map = malloc(sizeof(t_coord));
    player->p_center = malloc(sizeof(t_coord));
    player->p_line = malloc(sizeof(t_point));
    player->color = WHITE;
    player->tam = 10;
    player->vel_move = 3;
    player->mlx = game->mlx;
    player->img = game->img;
    player->pos_map->x = 0;
    player->pos_map->y = 0;
}

void paint_player(t_game *game, t_player *player)
{
    (void)game;
    init_player(player, game);
    insert_coord(player->p_center, game->map->half_y, game->map->half_x);
    init_points(player->p_line, player->p_center, player->p_center->y - 50, player->p_center->x);
    insert_coord(player->p_center, game->map->half_y - player->tam / 2, game->map->half_x - player->tam / 2);
   /*  player->position->y +=30;
    player->position->x +=30; */
    //init_player(player, game);
    //insert_coord(game->coord, y, x);
    clear_map(game);
    square_paint(player->p_center, player->tam, player->color, player->img);
    printf("Player: %f\n", player->p_center->y - 50);
    printf("x0: %f\n", player->p_line->x);
    printf("x1: %f\n", player->p_line->x1);
    printf("y0: %f\n", player->p_line->y);
    printf("y1: %f\n", player->p_line->y1);
    paint_line(player->p_line, player->img);
}