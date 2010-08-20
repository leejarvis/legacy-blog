$(document).ready(function() {

  function scrollDown() {
    $('html, body').animate({scrollTop: $("#container").height()}, 800);
  }

  $("#login-dialog").hide();
  $("#contact-dialog").hide();
  $("#tags-dialog").hide();
  $("#admin-post-listing").hide();

  $("#login").toggle(function(e) {
    e.preventDefault();
    $(this).addClass('alive');
    $("#login-dialog").slideDown();
    $("#form-username").focus();
    scrollDown();
  }, function(e) {
    e.preventDefault();
    $("#login-dialog").slideUp();
    $(this).removeClass('alive');
  });

  $("#login-dialog .close").click(function(e) {
    e.preventDefault();
    $("#login-dialog").slideUp();
    $("#login").removeClass('alive');
  });

  $("#contact").toggle(function(e) {
    e.preventDefault();
    $(this).addClass('alive');
    $("#contact-dialog").slideDown();
    scrollDown();
  }, function(e) {
    e.preventDefault();
    $("#contact-dialog").slideUp();
    $(this).removeClass('alive');
  });

  $("#tags").toggle(function(e) {
    e.preventDefault();
    $(this).addClass('blue');
    $("#tags-dialog").slideDown();
    scrollDown();
  }, function(e) {
    e.preventDefault();
    $("#tags-dialog").slideUp();
    $(this).removeClass('blue');
  });

  $("#admin-edit").click(function(e) {
    e.preventDefault();
    $("#admin-post-listing").slideDown();
  });

  $("#admin-post-listing a").click(function() {
    $(this).parent().slideUp();
    return true;
  });

  $("#down").click(function(e) {
    e.preventDefault();
    scrollDown();
  });

  $("#up").click(function(e) {
    e.preventDefault();
    $('html, body').animate({scrollTop: 0}, 800);
  });

});
