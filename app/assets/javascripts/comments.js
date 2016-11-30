$(document).on('ready page:change', function() {

  //  $(".user-comment").each(function(e) {
  //      if(e<4) {
  //          $(this).addClass("hidden");
  //              }
  //      });

//    $(".see-more").click(function(){
//        $(".user-comment").removeClass('hidden');
//        $(".see-more").hide();
//        $(".hide-comments").show();
//        return false
//        });
//    $(".hide-comments").click(function(){
//        $(".user-comment").each(function(e) {
//            if(e<4) {
//                $(this).addClass("hidden");
//            }
//        });
//        $(".hide-comments").hide();
//        $(".see-more").show();
//        return false
//    });

    $(".hide-comments").click(function(){
        $(".user-comment").addClass('hide');
        $(".see-more").removeClass('hide');
        $(".hide-comments").addClass('hide');
        });

    $(".see-more").click(function(){
        $(".user-comment").removeClass('hide');
        $(".hide-comments").removeClass('hide');
        $(".see-more").addClass('hide');
    });

    $('.comment_form').submit(function (e) {
        e.preventDefault();
        var url = $(this).attr('action');
        var form = $(this);
        $.post(
            url,
            $(this).serialize(),
            function (data) {
                resetForm(form);
                add_comments(data, form.parent().find('ol.comments-list'));
            },
            'JSON'
        ).fail(function (data) {
            resetForm(form);
            var alert = '<div class="alert alert-danger">' +  data.responseJSON.errors.join('<br>') + '</div>';
            $(alert).insertBefore(form);
        });

        function add_comments(data, container) {
            var comment_li = $('li#empty-comment').clone();
            $(comment_li).find('div.user').prepend(data.commenter.avatar_img);
            $(comment_li).find('a.commenter').attr('href', data.commenter.user_url).text(data.commenter.name);
            if( data.destroy_link != undefined ){
                $(comment_li).find('a.delete-comment').attr('href', data.destroy_link).text('');
            }else{
                $(comment_li).find('a.delete-comment').remove();
            }
            $(comment_li).find('p.content').text(data.body);
            $(comment_li).find('span.timestamp').text(data.commented_at);
            $(comment_li).removeAttr('id');
            $(comment_li).removeClass('hidden');
            $(comment_li).css('display', 'inherit');
            $(container).append(comment_li);

            $('.delete-comment', comment_li).on('click', bindDeleteComment);

        }

        function resetForm(form) {
            form.find('input:text, textarea').val('');
            form.parent().find('.alert').remove();
            form.find('input.btn.btn-primary').removeAttr('disabled');
        }
    });

    function bindDeleteComment(e) {
        e.preventDefault();
        var url = $(this).attr('href');
        var link = $(this);
        if(confirm('Are you sure?')){
            $.ajax({
                method: "POST",
                url: url,
                data: {_method: 'DELETE'},
                dataType: 'JSON',
                success: function () {
                    link.parents('li.list-unstyled.user-comment').remove();
                },
                error: function (data) {
                    var alert = '<div class="alert alert-danger">' +  data.responseJSON.errors.join('<br>') + '</div>';
                    $(alert).insertBefore('.user-comment');
                }
            });
        }

    }
    $('.delete-comment').on('click', bindDeleteComment)

});