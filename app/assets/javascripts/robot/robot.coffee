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
    @step = @featureMove()
    @row = @step.x
    @col = @step.y

  featureMove: =>
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

  i = j = 0

  constructor: (rows = 5, cols = 6) ->
    @max_x = rows - 1
    @max_y = cols - 1
    @min_x = @min_y = 0
    for i in [0...rows*cols]
      while i < cols
        $(".table-wrapper").append("<tr class='table-row'></tr>")
        i++
      while j < rows
        $('.table-wrapper').find(".table-row").append("<td class='table-cell'></td>")
        j++

  fadein: (x, y) =>
    x >= @min_x and x <= @max_x and y >= @min_y and y <= @max_y

  report: =>
    {x: @max_x, y: @max_y}


class Interface

  robotContent = '<img class="Robot">'

  constructor: (x = 5, y = 6) ->
    if x <= 1 then x = 5
    if y <= 1 then y = 6
    @table = new Table(x, y)
    @robot = new Robot
    $('.robot-log').val('Let`s go!')
    $('.place-form').removeClass('disabled hide')
    $('.init-form').hide()

  place: (x, y, f) =>
    x = x - 1
    y = y - 1
    if @table.fadein(x, y) is true
      @robot.place(x, y, f)
      robot_place = document.getElementById("myTable").rows[y].cells.item(x)
      $(robot_place).append(robotContent)
      $('.Robot').addClass(f)
      @report()
      $('.movement').removeClass('disabled hide')
      $('.place-form').hide()
    else
      window.alert("Error: Position x: #{x} and/or y: #{y} are out of the table. Please set another x and y")

  move: =>
    if robotPlacedOnTable(@robot.report())
      new_position = @robot.featureMove()
      if @table.fadein(new_position.x, new_position.y)
        @robot.move()
        $('.Robot').remove()
        robot_pos = @robot.report()
        robot_web_current_place = document.getElementById("myTable").rows[robot_pos.y].cells.item(robot_pos.x)
        $(robot_web_current_place).append(robotContent)
        $('.Robot').addClass(robot_pos.f)
        @report()
      else
        @printLog("Move out of the table. Are you tring to kill Bender? Change direction, bro.")

  left: =>
    robot_pos_old = @robot.report()
    @robot.left() if robotPlacedOnTable(@robot.report())
    @robotWebDirection(robot_pos_old)

  right: =>
    robot_pos_old = @robot.report()
    @robot.right() if robotPlacedOnTable(@robot.report())
    @robotWebDirection(robot_pos_old)

  robotWebDirection: (robot_pos_old) =>
    robot_pos_new = @robot.report()
    $('.Robot').removeClass(robot_pos_old.f).addClass(robot_pos_new.f)
    @report()

  report: =>
    if robotPlacedOnTable(@robot.report())
      report = @robot.report()
      switch report.f
        when 'NORTH' then report.f = 'EAST'
        when 'WEST' then report.f = 'SOUTH'
        when 'SOUTH' then report.f = 'WEST'
        when 'EAST' then report.f = 'NORTH'
      @printLog("Robot x:#{report.y}, y:#{report.x}, direction:#{report.f}")
    else
      @printLog("Robot out of table")

  printLog: (text)->
    $('.robot-log').val $('.robot-log').val() + '\n~' + text

  robotPlacedOnTable = (position)=>
    !(typeof position.x is 'undefined' or typeof position.x is 'null' or typeof position.y is 'undefined' or typeof position.y is 'null')

$ ->
  $('.robot-log').val('')
  $('.init-btn').click ->
    table_y = $('.x-table').val()
    table_x = $('.y-table').val()
    place_x = $('.x-place')
    place_y = $('.y-place')
    place_x.attr('max', table_x)
    place_y.attr('max', table_y)
    window.robot1 = new Interface(table_x, table_y)

    $('.place-btn').click =>
      x = place_x.val()
      y = place_y.val()
      f = $('.f-place').val()
      window.robot1.place(x,y,f)

      $('.left-btn').click =>
        window.robot1.right()

      $('.right-btn').click =>
        window.robot1.left()

      $('.move-btn').click =>
        window.robot1.move()

      $('.clean-log').click ->
        $('.robot-log').val('')