/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   player.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cmorales <moralesrojascr@gmail.com>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/06/05 18:08:03 by cmorales          #+#    #+#             */
/*   Updated: 2023/06/13 20:53:27 by cmorales         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "cub3D.h"
    
static void init_direction(t_player *player)
{
    player->direction = malloc(sizeof(t_coord));
    player->len_dir = 40;
    player->dir_x = 0.0;
    player->dir_y = (player->len_dir * -1); //-1 pq el eje y es para abajo el positivo
    update_direction(player); //Iniciamos la direcciona de la linea
}

void update_direction(t_player *player)
{
    insert_coord(player->direction, player->p_center->x + player->dir_x, player->p_center->y + player->dir_y);
}

void init_player(t_player *player, t_game *game)
{
    player->mlx = game->mlx;
    player->img = game->img;
    player->color = WHITE;
    player->tam = 10;
    player->vel_move = 2;
    player->angle = get_player_angle(game->map);
    player->p_center = malloc(sizeof(t_coord));
    insert_coord(player->p_center, WIDTH / 2, HEIGHT / 2);//Punto medio
    player->mid_square = malloc(sizeof(t_coord));
    insert_coord(player->mid_square, player->p_center->x - player->tam / 2, 
        player->p_center->y - player->tam / 2);//Pintar el cuadrado en medio
    player->p_line = malloc(sizeof(t_point));
    init_direction(player);
  /*   player->pos_map = malloc(sizeof(t_coord));
    player->pos_map = get_player_pos(game->map);
    printf("Pos x: %f", player->pos_map->x);
    printf("Pos y: %f", player->pos_map->y); */
}

void paint_player(t_game *game, t_player *player)
{
    //clear_map(game->map);
    init_player(player, game);
    square_paint(player->mid_square, player->tam, player->color, player->img);
    init_points(player->p_line, player->p_center, player->direction);//Iniciar linea
    //paint_line(player->p_line, player->img);
    //bresenham(player->p_line->x,player->p_line->y, player->p_line->x1, player->p_line->y1, *game->img);
    paint_line(player->p_line, player->p_center, player->direction, player->img);
}