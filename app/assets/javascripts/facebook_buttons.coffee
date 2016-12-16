$ ->
  $('.fb-share').click ->
    post = $(this).parents('.users-micropost')
    info_name = post.find('.user-name').text()
    info_content = post.find('.content').text()
    img_url =  post.find('.content').find('img').attr('src')
    FB.ui(
      method: 'feed'
      link: 'http://secret-gorge-27979.herokuapp.com/abyss'
      picture: 'https://secret-gorge-27979.herokuapp.com' + img_url
      description: info_name + ' posted:' + info_content
    )