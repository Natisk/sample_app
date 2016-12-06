// ToDo: Remove useless lines
$(document).on('ready page:change', function() {

    $('button.follow').click(function () {
        $.post(
            '/relationships',
            {followed_id: $(this).data().followedId},
            function (data) {
                update_relationships(data);
                $('button.follow').addClass('hide');
                $('button.unfollow').clone();
                $('button.unfollow').removeClass('hide');
                $('button.unfollow').attr('data-followed-id', data.relationship_id);
                $('button.unfollow').data('followed-id', data.relationship_id);
            },
            'JSON'
        )
     });

    $('button.unfollow').click(function () {
        followed_id = $(this).data().followedId;
        console.log(followed_id);
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
                $('button.follow').attr('data-followed-id', data.relationship_id);
            }
        });
    });

    function update_relationships(data) {
        $('#following.stat').text(data.following_count);
        $('#followers.stat').text(data.followers_count);
    }
});