class SnakesAndLadders

  ONE = 1
  SIX = 6

  def initialize(board_size:, snakes_ladders:, users:)
    @users = users
    @board_size = board_size
    @snakes_ladders = create_board(number_of_snakes_ladders: snakes_ladders, board_size: board_size)
  end
  
  def play
    players_starting_positions = @users.map{0}
    starting_player = rand(@users.length)
    winner = move(players_starting_positions: players_starting_positions, starting_player: starting_player)
    puts "#{@users[winner]} won!"
  end
  
  private

  def throw_dice
    ONE + rand(SIX)
  end
  
  def move(players_starting_positions:, starting_player:)
    new_position = players_starting_positions[starting_player] + throw_dice
    new_position = @snakes_ladders[new_position] if @snakes_ladders.has_key?(new_position)
    return starting_player if new_position >= @board_size 
    players_starting_positions[starting_player] = new_position
    next_player = (starting_player + ONE) % players_starting_positions.length
    move(players_starting_positions: players_starting_positions, starting_player: next_player)
  end
  
  def create_board(number_of_snakes_ladders:, board_size:)
    snakes_ladders = {}
    number_of_snakes_ladders.times do
      snakes_ladders = snakes_ladders.merge(snake_or_ladder(board_size: board_size))
    end
    snakes_ladders
  end
  
  def snake_or_ladder(board_size:)
    start = cell_start_value(board_size: board_size)
    ending = cell_start_value(board_size: board_size)
    return {start=>ending} unless start==ending
    snake_or_ladder(board_size: board_size) 
  end
  
  def cell_start_value(board_size:)
    ONE + rand(board_size - ONE)
  end
end

snake_ladder = SnakesAndLadders.new(users: ["Siba", "Prasad", "Shakti"], board_size: 100, snakes_ladders: 5)
snake_ladder.play
