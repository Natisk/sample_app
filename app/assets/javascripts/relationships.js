$(document).on('ready page:change', function() {

    $('button.follow').click(function () {
        $.post(
            '/relationships',
            {followed_id: $(this).data().followedId},
            function (data) {
                update_relationships(data);
                $('button.follow').addClass('unfollow');
                $('button.follow').removeClass('follow');
                $('button.follow').attr('data-followed-id', data.relationship_id);
                $('span.glyphicon.glyphicon-send').text('Unfollow');
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
                $('button.follow').removeClass('follow');
                $('button.follow').addClass('unfollow');
                $('button.follow').data('followed-id', 'Kill me, please');
                $('span.glyphicon.glyphicon-send').text('Follow');
            }
        });
    });

    function update_relationships(data) {
        $('#following.stat').text(data.following_count);
        $('#followers.stat').text(data.followers_count);
    }
});