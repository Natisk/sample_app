$ ->

  $(".see-more").click (e) ->
    e.preventDefault()
    father = $(this).parent()
    father.find(".hide-comments").removeClass('hide')
    father.find(".see-more").addClass('hide')
    url = $(this).attr('href')
    micropost = $(this).parent().find('ol.comments-list')
    micropost.html('')
    $.get(
      url,
      (data) ->
        $.each(data, ( key, value ) ->
          add_comments(value, micropost)
        )
      , 'JSON'
    ).fail( (data) ->
      alertMessage(data, container)
    )

  $(".hide-comments").click ->
    father = $(this).parent()
    father.find('ol.comments-list').html('')
    father.find(".see-more").removeClass('hide')
    father.find(".hide-comments").addClass('hide')

  $('.comment_form').submit (e) ->
      e.preventDefault()
      url = $(this).attr('action')
      form = $(this)
      $.post(
        url,
        $(this).serialize(),
        (data) ->
            resetForm(form)
            add_comments(data, form.parent().find('ol.comments-list'))
        , 'JSON'
      ).fail( (data) ->
        resetForm(form)
        alertMessage(data, form)
      )

  resetForm = (form) ->
    form.find('input:text, textarea').val('')
    form.parent().find('.alert').remove()
    form.find('input.btn.btn-primary').removeAttr('disabled')

  add_comments = (data, container) ->
    comment_li = $('li#empty-comment').clone()
    $(comment_li).find('div.user').prepend(data.commenter.avatar_img)
    $(comment_li).find('a.commenter').attr('href', data.commenter.user_url).text(data.commenter.name)
    if data.destroy_link != undefined
      $(comment_li).find('a.delete-comment').attr('href', data.destroy_link).text('')
    else
      $(comment_li).find('a.delete-comment').remove()
    $(comment_li).find('p.content').text(data.body)
    $(comment_li).find('span.timestamp').text(data.commented_at)
    $(comment_li).removeAttr('id').removeClass('hidden').css('display', 'inherit')
    $(container).append(comment_li)
    $('.delete-comment', comment_li).on('click', bindDeleteComment)

  bindDeleteComment = (e) ->
    e.preventDefault()
    url = $(this).attr('href')
    link = $(this)
    if confirm('Are you sure?')
      $.ajax({
        method: "POST",
        url: url,
        data: {_method: 'DELETE'},
        dataType: 'JSON',
        success: ->
          link.parents('li.list-unstyled.user-comment').remove()
        , error: (data) -> alertMessage(data, form)
      })

  alertMessage = (data, container) ->
    alert = "<div class='alert alert-danger'>#{data.responseJSON.errors.join('<br>')}</div>"
    $(alert).insertBefore(container)

  $('.delete-comment').on('click', bindDeleteComment)