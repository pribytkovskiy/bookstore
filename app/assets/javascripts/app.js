$(document).ready(function() {
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

function copyValueTo(fromElem, toElemId) {
    var elem = document.getElementById(toElemId);
    elem.value = fromElem.value;
    alert(fromElem.value);
};

function showMessage() {
    alert( 'Hi!' );
  }
