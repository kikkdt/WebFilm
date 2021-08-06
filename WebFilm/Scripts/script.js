$(function () {
    $('.navbar-item').click(function () {
        if ($(this).hasClass('active')) {
            $(this).removeClass('active');
            return;
        }

        $('.navbar-item').removeClass('active');
        $(this).addClass('active');
    });

    var toggle = $('#toggleNavbar');
    menu = $('nav');
    menuHeight = menu.height();

    $(toggle).click(function (e) {
        e.preventDefault();
        menu.slideToggle('fast');
        if (document.getElementById('overlay').style.display == 'none')
            document.getElementById('overlay').style.display = "block";
        else document.getElementById('overlay').style.display = 'none';
    });

    $(window).resize(function () {
        var w = $(window).width();
        if (w > 320 && menu.is(':hidden')) {
            menu.removeAttr('style');
        }
    });

    $('#overlay').click(function (e) {
        e.preventDefault();
        menu.slideToggle('fast');
        document.getElementById('overlay').style.display = 'none';
    });
});

var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
})