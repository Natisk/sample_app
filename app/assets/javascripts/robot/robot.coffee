class Robot
  DIRECTION = ['NORTH', 'EAST', 'SOUTH', 'WEST']

  place: (x, y, f) =>
    @row = parseInt(x)
    @col = parseInt(y)
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
    @max_x = rows - 1
    @max_y = cols - 1
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
  $('.robot-log').val('Let`s go!')
  $('.init-btn').click ->
    table_y = $('.x-table').val()
    if table_y <= 1
      table_y = 5
    table_x = $('.y-table').val()
    if table_x <= 1
      table_x = 6
    place_x = $('.x-place')
    place_y = $('.y-place')
    place_x.attr('max', table_x)
    place_y.attr('max', table_y)
    width = height = numberOfCell = i = j = 0
    table = $(".table-wrapper")
    cell = $(".table-cell")
    intoContentRow = "<tr class='table-row'></tr>"
    intoContentCell = "<td class='table-cell'></td>"
    robotContent = '<img class="Robot">'
    for i in [0...table_x*table_y]
      while i < table_y
        table.append(intoContentRow)
        i++
      while j < table_x
        $('.table-wrapper').find(".table-row").append(intoContentCell)
        j++
    window.robot1 = new Interface(table_x, table_y)
    $('.place-form').removeClass('disabled hide')
    $('.init-form').hide()
    $('.place-btn').click =>
      x = place_x.val() - 1
      y = place_y.val() - 1
      f = $('.f-place').val()
      if window.robot1.table.fadein(x, y) is true
        window.robot1.place(x,y,f)
        robot_place = document.getElementById("myTable").rows[y].cells.item(x)
        $(robot_place).append(robotContent)
        $('.Robot').addClass(f)
        $('.movement').removeClass('disabled hide')
        $('.place-form').hide()
        robot_pos = window.robot1.robot.report()
        robotLog(robot_pos)
      else
        window.alert('Select another place')
      $('.left-btn').click =>
        robot_pos = window.robot1.robot.report()
        $('.Robot').removeClass(robot_pos.f)
        window.robot1.right()
        robot_pos = window.robot1.robot.report()
        $('.Robot').addClass(robot_pos.f)
        robotLog(robot_pos)
      $('.right-btn').click =>
        robot_pos = window.robot1.robot.report()
        $('.Robot').removeClass(robot_pos.f)
        window.robot1.left()
        robot_pos = window.robot1.robot.report()
        $('.Robot').addClass(robot_pos.f)
        robotLog(robot_pos)
      $('.move-btn').click =>
        if window.robot1.move() is "Error: move out of the table"
          val = $('.robot-log').val()
          $('.robot-log').val("Are you tring to kill Bender? Change direction, bro. <= " + val)
        else
          $('.Robot').remove()
          robot_pos = window.robot1.robot.report()
          robot_current_place = document.getElementById("myTable").rows[robot_pos.y].cells.item(robot_pos.x)
          $(robot_current_place).append(robotContent)
          $('.Robot').addClass(robot_pos.f)
          robotLog(robot_pos)

robotLog = (robot_pos)->
  val = $('.robot-log').val()
  switch robot_pos.f
    when 'NORTH' then robot_pos.f = 'EAST'
    when 'WEST' then robot_pos.f = 'SOUTH'
    when 'SOUTH' then robot_pos.f = 'WEST'
    when 'EAST' then robot_pos.f = 'NORTH'
  $('.robot-log').val("(Robot x:#{robot_pos.y}, y:#{robot_pos.x}, direction:#{robot_pos.f}) <= " + val)

  $('.clean-log').click ->
    $('.robot-log').val('')