/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   player_paint.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cmorales <moralesrojascr@gmail.com>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/06/15 17:24:17 by cmorales          #+#    #+#             */
/*   Updated: 2023/06/19 20:55:34 by cmorales         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "cub3D.h"

void get_square_corner(t_player *player, t_square *square);

void paint_player(t_game *game, t_player *player)
{
    init_player(player, game, player->square);
    init_points(player->p_line, player->square->p_center, player->direction);//Iniciar linea
    paint_line(player->p_line, game->img);
    square_paint(player->square->mid_square, player->tam, player->color, player->img);
	get_square_corner(player, player->square);
}

void repaint(t_game *game, t_player *player)
{
	clear_map(game->map);
	create_map(game, game->map, 0, 0);
	//create_map(game, game->map, game->map->mid_map->x, game->map->mid_map->y);
	init_points(player->p_line, player->square->p_center, player->direction);//Iniciar linea
    paint_line(player->p_line, game->img);
    square_paint(player->square->mid_square, player->tam, player->color, player->img);
	get_square_corner(player, player->square);
	update_direction(player);//actualizamos
}

void get_square_corner(t_player *player, t_square *square)
{
	square->p_left_down->x = square->p_center->x - player->tam / 2;
	square->p_left_down->y = square->p_center->y + player->tam / 2;
	
	square->p_right_down->x = square->p_center->x + player->tam / 2;
	square->p_right_down->y = square->p_center->y + player->tam / 2;

	square->p_left_up->x = square->p_center->x - player->tam / 2;
	square->p_left_up->y = square->p_center->y - player->tam / 2;

	square->p_right_up->x = square->p_center->x + player->tam / 2;
	square->p_right_up->y = square->p_center->y - player->tam / 2;

	square_paint(player->square->p_left_down, 0.1, CYAN, player->img);
	square_paint(player->square->p_right_down, 0.1, CYAN, player->img);
	square_paint(player->square->p_left_up, 0.1, CYAN, player->img);
	square_paint(player->square->p_right_up, 0.1, CYAN, player->img);
}