$(document).on('ready page:change', function() {
    $('#micropost_picture').bind('change', function() {
        var size_in_megabytes = this.files[0].size/1024/1024;
        if (size_in_megabytes > 5) {
            alert('Maximum file size is 5MB. Please choose a smaller file.');
        }
    });

    $('.like').click(function (e) {
        e.preventDefault()
        post_id = $(this).data().postid;
        url = '/microposts/' + post_id + '/like';
        $.post(
            url,
            function (data) {
                update_likes(data, post_id);
            },
            'JSON'
        );
    });

    $('.dislike').click(function (e) {
        e.preventDefault();
        post_id = $(this).data().postid;
        url = '/microposts/' + post_id + '/dislike';
        $.post(
            url,
            function (data) {
                update_likes(data, post_id);
            },
            'JSON'
        );
    });

    function update_likes(data, post_id) {
        $('.dislike[data-postid="'+post_id+'"]').text(data.dislike_count).addClass('post-disliked').blur();;
        $('.like[data-postid="'+post_id+'"]').text(data.like_count).addClass('post-liked').blur();
    }
});