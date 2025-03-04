program game_of_life
    implicit none
    
    ! Define the grid dimensions
    integer, parameter :: rows = 20, cols = 40
    ! Arrays to hold current and next generation states
    integer :: grid(rows, cols), new_grid(rows, cols)
    ! Loop counters and variables for simulation
    integer :: i, j, neighbors, generations, gen
    real :: random_val
    
    ! Initialize the grid randomly with live (1) and dead (0) cells
    call random_seed()
    do i = 1, rows
        do j = 1, cols
            call random_number(random_val)
            if (random_val > 0.5) then
                grid(i, j) = 1  ! Cell is alive
            else
                grid(i, j) = 0  ! Cell is dead
            end if
        end do
    end do
    
    ! Get user input for simulation duration
    write(*, *) "Enter number of generations: "
    read(*, *) generations
    
    ! Main simulation loop
    do gen = 1, generations
        ! Display the current grid
        call display_grid(grid, rows, cols)
        
        ! Reset new_grid before calculations
        new_grid = 0
        
        ! Calculate the next generation based on Conway's Game of Life rules
        do i = 1, rows
            do j = 1, cols
                ! Count live neighbors for current cell
                neighbors = count_neighbors(grid, i, j, rows, cols)
                
                if (grid(i, j) == 1) then
                    ! Rules for live cells:
                    if (neighbors < 2 .or. neighbors > 3) then
                        new_grid(i, j) = 0  ! Dies from underpopulation or overpopulation
                    else
                        new_grid(i, j) = 1  ! Survives with 2 or 3 neighbors
                    end if
                else
                    ! Rules for dead cells:
                    if (neighbors == 3) then
                        new_grid(i, j) = 1  ! Becomes alive with exactly 3 neighbors (reproduction)
                    else
                        new_grid(i, j) = 0  ! Stays dead
                    end if
                end if
            end do
        end do
        
        ! Update the current grid with the new generation
        grid = new_grid
        
        ! Pause to make the simulation visible to the user
        call pause(0.2)  ! Pause 0.2 seconds between generations
    end do

contains
    ! Subroutine to display the current state of the grid
    subroutine display_grid(grid, rows, cols)
        integer, intent(in) :: grid(rows, cols), rows, cols
        integer :: i, j
        
        do i = 1, rows
            do j = 1, cols
                if (grid(i, j) == 1) then
                    write(*, '(A)', advance='NO') "*"  ! Display live cell as asterisk
                else
                    write(*, '(A)', advance='NO') " "  ! Display dead cell as space
                end if
            end do
            write(*, *) ""  ! New line at end of each row
        end do
        write(*, *) ""  ! Empty line between generations for clarity
    end subroutine display_grid
    
    ! Function to count live neighbors for a cell with wrapping at boundaries
    integer function count_neighbors(grid, row, col, rows, cols)
        integer, intent(in) :: grid(rows, cols), row, col, rows, cols
        integer :: i, j, count, wrapped_i, wrapped_j
        
        count = 0
        do i = -1, 1
            do j = -1, 1
                if (i == 0 .and. j == 0) cycle  ! Skip the cell itself
                
                ! Handle wrapping at grid boundaries (toroidal grid)
                wrapped_i = mod(row + i - 1, rows) + 1
                wrapped_j = mod(col + j - 1, cols) + 1
                
                count = count + grid(wrapped_i, wrapped_j)  ! Add 1 if neighbor is alive
            end do
        end do
        
        count_neighbors = count
    end function count_neighbors
    
    ! Subroutine to create a delay between generations
    subroutine pause(seconds)
        real, intent(in) :: seconds
        integer :: start_time_int, current_time_int, count_rate_int, time_diff
        real :: time_diff_sec
        
        call system_clock(count=start_time_int, count_rate=count_rate_int)
        
        do
            call system_clock(count=current_time_int)
            time_diff = current_time_int - start_time_int
            time_diff_sec = real(time_diff) / real(count_rate_int)
            if (time_diff_sec >= seconds) exit
        end do
    end subroutine pause
    
end program game_of_life