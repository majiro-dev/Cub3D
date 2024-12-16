# Cub3D

Cub3D is a 3D game project developed as part of the curriculum at the **42** programming school. It is a simple 3D game engine that uses raycasting to render a 3D environment from a 2D map.

## Features

- **Raycasting**: Render a 3D environment from a 2D map.
- **Player Movement**: Move the player within the 3D environment.
- **Minimap**: Display a minimap of the environment.
- **Collision Detection**: Detect and handle collisions with walls.
- **Bonus Features**: Additional features like cursor hooks and minimap display.

## Installation

### Prerequisites

- **CMake**
- **GLFW**
- **GNU Make**
- **GCC**

### Building the Project

1. Build the project:
    ```sh
    make
    ```

2. Run the project:
    ```sh
    ./Cub3D assets/maps/01.cub
    ```

## Usage

### Running the Game

To run the game, use the following command:
```sh
./Cub3D path/to/map.cub
```

### Controls

- **W**: Move forward
- **A**: Move left
- **S**: Move backward
- **D**: Move right
- **ESC**: Exit the game

## Project Structure

- **src/**: Source code for the project.
- **includes/**: Header files for the project.
- **assets/**: Assets like maps and textures.
- **libft/**: Custom library for utility functions.
- **MLX42/**: Graphics library used for rendering.
- **memory-leaks/**: Tools for detecting memory leaks.

## Makefile Targets

- `make`: Build the project.
- `make clean`: Clean the object files.
- `make fclean`: Clean the object files and the executable.
- `make bonus` : Build the project with bonus features.

