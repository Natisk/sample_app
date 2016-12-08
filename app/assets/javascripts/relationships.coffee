$ ->

  $('button.follow').click ->
    $.post(
      '/relationships',
      followed_id: $(this).data().followedId,
      (data) =>
        update_relationships(data)
        $(this).addClass('hide')
        $('button.unfollow').removeClass('hide')
        $('button.unfollow').data('followed-id', data.relationship_id)
      , 'JSON'
    )

  $('button.unfollow').click ->
    followed_id = $(this).data().followedId
    url = "/relationships/#{followed_id}"
    $.ajax({
      method: "POST",
      url: url,
      data: {_method: 'DELETE'},
      dataType: 'JSON',
      success: (data) =>
        update_relationships(data)
        $(this).addClass('hide')
        $('button.follow').removeClass('hide')
    })

  update_relationships = (data) ->
    $('#following.stat').text(data.following_count)
    $('#followers.stat').text(data.followers_count)