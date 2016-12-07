$(document).on('ready page:change', function() {

    $('button.follow').click(function () {
        $.post(
            '/relationships',
            {followed_id: $(this).data().followedId},
            function (data) {
                update_relationships(data);
                $('button.follow').addClass('hide');
                $('button.unfollow').removeClass('hide');
                $('button.unfollow').data('followed-id', data.relationship_id);
            },
            'JSON'
        )
     });

    $('button.unfollow').click(function () {
        followed_id = $(this).data().followedId;
        url = '/relationships/' + followed_id;
        $.ajax({
            method: "POST",
            url: url,
            data: {_method: 'DELETE'},
            dataType: 'JSON',
            success: function (data) {
                update_relationships(data);
                $('button.unfollow').addClass('hide');
                $('button.follow').removeClass('hide');
            }
        });
    });

    function update_relationships(data) {
        $('#following.stat').text(data.following_count);
        $('#followers.stat').text(data.followers_count);
    }
});