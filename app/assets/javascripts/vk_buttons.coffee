$ ->

  $('.vk-share-btn').click (e)->
    e.preventDefault()

    post = $(this).parents('.users-micropost')
    info_name = post.find('.user-name').html()
    info_content = post.find('.content').text()
    img_url =  post.find('.content').find('img').attr('src')
    img_path = 'https://secret-gorge-27979.herokuapp.com' + img_url

    VK.api(
      "wall.post",
      {
        "message": info_name + ' posted' + info_content + img_path
        "attachments": 'https://secret-gorge-27979.herokuapp.com/abyss'
      },
      (response)->
        response
    )