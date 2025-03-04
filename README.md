# Conway's Game of Life in Fortran

This project implements Conway's Game of Life cellular automaton in Fortran. The Game of Life is a zero-player game that simulates cellular evolution based on a set of simple rules.

## Overview

Conway's Game of Life takes place on a two-dimensional grid of cells, where each cell can be in one of two states: alive or dead. The evolution of the cells follows these rules:

1. Any live cell with fewer than two live neighbors dies (underpopulation)
2. Any live cell with two or three live neighbors lives on to the next generation
3. Any live cell with more than three live neighbors dies (overpopulation)
4. Any dead cell with exactly three live neighbors becomes a live cell (reproduction)

This implementation features:
- Random grid initialization
- Toroidal (wrapping) boundary conditions
- Configurable simulation duration
- Simple ASCII visualization

## Requirements

- A Fortran compiler (e.g., gfortran, ifort)
- Standard terminal/command prompt

## Installation

1. Clone this repository:
