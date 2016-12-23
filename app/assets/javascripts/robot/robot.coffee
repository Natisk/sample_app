class Robot
  DIRECTION = ['NORTH', 'EAST', 'SOUTH', 'WEST']

  place: (x, y, f) =>
    @row = x
    @col = y
    if DIRECTION.includes(f)
      @direction = f
    else
      "DIRECTION error. Must be only: #{DIRECTION}"

  move: =>
    @step = @feature_move()
    @row = @step.x
    @col = @step.y

  feature_move: =>
    @maybe_step = { x: @row, y: @col }
    if @direction is 'NORTH'
      @maybe_step.y = @col + 1
    else if @direction is 'EAST'
      @maybe_step.x = @row + 1
    else if @direction is 'SOUTH'
      @maybe_step.y = @col - 1
    else
      @maybe_step.x = @row - 1
    @maybe_step

  left: =>
    @direction = DIRECTION[DIRECTION.indexOf(@direction) - 1] or 'WEST'

  right: =>
    @direction = DIRECTION[DIRECTION.indexOf(@direction) + 1] or 'NORTH'

  report: =>
    {x: @row, y: @col, f: @direction}



class Table

  constructor: (rows = 5, cols = 6) ->
    @max_x = rows
    @max_y = cols
    @min_x = @min_y = 0

  fadein: (x, y) =>
    x >= @min_x and x <= @max_x and y >= @min_y and y <= @max_y

  report: =>
    {x: @max_x, y: @max_y}


class Interface

  constructor: (x = 5, y = 6) ->
    @table = new Table(x, y)
    @robot = new Robot

  place: (x, y, f) =>
    if @table.fadein(x, y) is true
      @robot.place(x, y, f)
    else
      "Error: Position x: #{x} and/or y: #{y} are out of the table. Max x: #{@table.report[x]}, max y: #{@table.report[y]}"

  move: =>
    if robot_placed_on_table(@robot.report())
      new_position = @robot.feature_move()
      if @table.fadein(new_position.x, new_position.y)
        @robot.move()
      else
        'Error: move out of the table'

  left: =>
    @robot.left() if robot_placed_on_table(@robot.report())

  right: =>
    @robot.right() if robot_placed_on_table(@robot.report())

  report: =>
    if robot_placed_on_table(@robot.report())
      report = @robot.report()
      "Robot position #{report.x}, #{report.y}, #{report.f}"
    else
      "Robot out of table"

  robot_placed_on_table = (position)=>
    !(typeof position.x is 'undefined' or typeof position.x is 'null' or typeof position.y is 'undefined' or typeof position.y is 'null')

$ ->
  $('.init-btn').click ->
    x = $('.x-table').val()
    y = $('.y-table').val()
    console.log(window.robot1 = new Interface(x, y))
    $('.place-btn').removeClass('disabled')
    $('.place-btn').click =>
      x = $('.x-place').val()
      y = $('.y-place').val()
      f = $('.f-place').val()
      $('.left-btn, .right-btn, .move-btn').removeClass('disabled')
      console.log(window.robot1.place(x,y,f))
    $('.left-btn').click =>
      window.robot1.left()
      console.log(window.robot1.report())
    $('.right-btn').click =>
      window.robot1.right()
      console.log(window.robot1.report())
    $('.move-btn').click =>
      window.robot1.move()
      console.log(window.robot1.report())