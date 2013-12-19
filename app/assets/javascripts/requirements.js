$(function(){

    $('#requirements_filter').submit(function() {
        $.get(this.action, $(this).serialize(), null, 'script');
        return false;
        });
});


