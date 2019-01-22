$(document).on('turbolinks:load', function() {
    $('.minus').click(function () {
        var $input = $(this).parent().find('#quantity');
        var count = parseInt($input.val()) - 1;
        count = count < 1 ? 1 : count;
        $input.val(count);
        $input.change();
        return false;
    });
    $('.plus').click(function () {
        var $input = $(this).parent().find('#quantity');
        $input.val(parseInt($input.val()) + 1);
        $input.change();
        return false;
    });
});
