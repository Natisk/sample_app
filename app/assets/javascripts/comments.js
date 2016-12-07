$(document).on('ready page:change', function() {

    $(".see-more").click(function(e){
        e.preventDefault();
        father = $(this).parent();
        father.find(".hide-comments").removeClass('hide');
        father.find(".see-more").addClass('hide');
        url = $(this).attr('href');
        micropost = $(this).parent().find('ol.comments-list');
        micropost.html('');
        $.get(
            url,
            function(data) {
                $.each(data, function( key, value ) {
                    add_comments(value, micropost);
                });
            },
            'JSON'
        ).fail(function (data) {
            alertMessage (data, container);
        });
    });

    $(".hide-comments").click(function(){
        father = $(this).parent();
        father.find('ol.comments-list').html('');
        father.find(".see-more").removeClass('hide');
        father.find(".hide-comments").addClass('hide');
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
            alertMessage (data, form);
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
        $(comment_li).removeAttr('id').removeClass('hidden').css('display', 'inherit');
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
                error: (function (data) {
                    alertMessage (data, form);
                })
            });
        }

    }

    function alertMessage (data, container) {
        var alert = '<div class="alert alert-danger">' +  data.responseJSON.errors.join('<br>') + '</div>';
        $(alert).insertBefore(container);
    }

    $('.delete-comment').on('click', bindDeleteComment)

});