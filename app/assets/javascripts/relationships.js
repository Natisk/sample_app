$(document).on('ready page:change', function() {

    $('button.follow').click(function () {
        $.post(
            '/relationships',
            {followed_id: $(this).data().followedId},
            function (data) {
                update_relationships(data);
            },
            'JSON'
        )
     });

    $('button.unfollow').click(function () {
        followed_id = $(this).data().followedId;
        console.log(followed_id);
        url = '/relationships/' + followed_id;
        console.log(url);
        $.ajax({
            method: "POST",
            url: url,
            data: {_method: 'DELETE'},
            dataType: 'JSON',
            success: function (data) {
                update_relationships(data);
            }
        });
    });

    function update_relationships(data) {
        $('#following.stat').text(data.following_count);
        $('#followers.stat').text(data.followers_count);
    }
});