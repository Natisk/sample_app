$(document).on('ready page:change', function() {

    $(".see-more").click(function(e){
        e.preventDefault();
        $(this).parent().find(".hide-comments").removeClass('hide');
        $(this).parent().find(".see-more").addClass('hide');
        url = $(this).attr('href');
        micropost = $(this).parent().find('ol.comments-list');
        $(this).parent().find('ol.comments-list').html(''); // FixME: double selection!!! must be micropost.html('')
        $.get(
            url,
            function(data) {
                $.each(data, function( key, value ) {
                    add_comments(value, micropost);
                });
            },
            'JSON'
        ).fail(function (data) {
            var alert = '<div class="alert alert-danger">' +  data.responseJSON.errors.join('<br>') + '</div>';
            // FixME: Alert has been created and not used!
        });
    });

    $(".hide-comments").click(function(){
        //TODO: may be put  $(this).parent() into var?
        $(this).parent().find('ol.comments-list').html('');
        $(this).parent().find(".see-more").removeClass('hide');
        $(this).parent().find(".hide-comments").addClass('hide');
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

        function resetForm(form) {
            form.find('input:text, textarea').val('');
            form.parent().find('.alert').remove();
            form.find('input.btn.btn-primary').removeAttr('disabled');
        }
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
        // TODO: rework into one line
        $(comment_li).removeAttr('id');
        $(comment_li).removeClass('hidden');
        $(comment_li).css('display', 'inherit');
        $(container).append(comment_li);

        $('.delete-comment', comment_li).on('click', bindDeleteComment);

    }

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