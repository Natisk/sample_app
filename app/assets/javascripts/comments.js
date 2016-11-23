$(document).on('ready page:change', function() {
    $(".user-comment").slice(5).hide();
    $(".hide-comments").hide();

    $(".see-more").click(function(){
        $(".user-comment").fadeIn();
        $(".see-more").hide();
        $(".hide-comments").fadeIn().click(function(){
            $(".user-comment").slice(5).fadeOut();
            $(".hide-comments").hide();
            $(".see-more").fadeIn();
        });
    });
});