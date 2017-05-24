$ ->

  $('#micropost_picture').bind('change', ->
    size_in_megabytes = this.files[0].size/1024/1024
    alert('Maximum file size is 5MB. Please choose a smaller file.') if size_in_megabytes > 5
  )

  $('.popup-link').click (e) ->
    e.preventDefault()
    url = $(this).data('url')
    $(this).magnificPopup({
      items: {
        src: url
      },
      type: 'image'
    })

  $('.like').click (e) ->
    e.preventDefault()
    post_id = $(this).data().postid
    url = "/microposts/#{post_id}/like"
    $.post(
      url,
      (data) ->
        update_likes(data, post_id)
      , 'JSON'
    )

  $('.dislike').click (e) ->
    e.preventDefault()
    post_id = $(this).data().postid
    url = "/microposts/#{post_id}/dislike"
    $.post(
      url,
      (data) ->
        update_likes(data, post_id)
      , 'JSON'
    )

  update_likes = (data, post_id) ->
    $('.dislike[data-postid="'+post_id+'"]').text(data.dislike_count).addClass('post-disliked').blur()
    $('.like[data-postid="'+post_id+'"]').text(data.like_count).addClass('post-liked').blur()