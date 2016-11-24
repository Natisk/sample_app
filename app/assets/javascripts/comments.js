$(document).on('ready page:change', function() {
   // $(".user-comment").slice(5).hide();
   // $(".hide-comments").hide();

   // $(".see-more").click(function(){
   //     $(".user-comment").fadeIn();
   //    $(".see-more").hide();
   //     $(".hide-comments").fadeIn().click(function(){
   //         $(".user-comment").slice(5).fadeOut();
   //         $(".hide-comments").hide();
   //         $(".see-more").fadeIn();
   //    });
   // });

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
                $(comment_li).find('a.destroy_comment').attr('href', data.destroy_link).text('');
            }else{
                $(comment_li).find('a.destroy_comment').remove();
            }
            $(comment_li).find('p.content').text(data.body);
            $(comment_li).find('span.timestamp').text(data.commented_at);
            $(comment_li).removeAttr('id');
            $(comment_li).removeClass('hidden');
            $(comment_li).css('display', 'inherit');
            $(container).append(comment_li);

            $('.delete-comment').unbind('click');
            bindDeleteComment();

        }

        function resetForm(form) {
            form.find('input:text, textarea').val('');
            form.parent().find('.alert').remove();
            form.find('input[type="submit"]').removeAttr('disabled');
        }
    });

    function bindDeleteComment() {
        $('.delete-comment').bind('click', function (e) {
            console.log('Test message');
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
        });
    }

    bindDeleteComment();

});