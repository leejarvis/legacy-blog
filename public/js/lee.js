$(document).ready(function() {

  function scrollDown() {
    $('html, body').animate({scrollTop: $("#container").height()}, 800);
  }

  $("#login-dialog").hide();
  $("#contact-dialog").hide();
  $("#tags-dialog").hide();
  $("#admin-post-listing").hide();

  $("#login").toggle(function() {
    $(this).addClass('alive');
    $("#login-dialog").slideDown();
    $("#form-username").focus();
    scrollDown();
    return false;
  }, function() {
    $("#login-dialog").slideUp();
    $(this).removeClass('alive');
    return false;
  });

  $("#login-dialog .close").click(function() {
    $("#login-dialog").slideUp();
    $("#login").removeClass('alive');
    return false;
  });

  $("#contact").toggle(function() {
    $(this).addClass('alive');
    $("#contact-dialog").slideDown();
    scrollDown();
    return false;
  }, function() {
    $("#contact-dialog").slideUp();
    $(this).removeClass('alive');
    return false;
  });

  $("#tags").toggle(function() {
    $(this).addClass('blue');
    $("#tags-dialog").slideDown();
    scrollDown();
    return false;
  }, function() {
    $("#tags-dialog").slideUp();
    $(this).removeClass('blue');
    return false;
  });

  $("#admin-edit").click(function() {
    $("#admin-post-listing").slideDown();
    return false;  
  });

  $("#admin-post-listing a").click(function() {
    $(this).parent().slideUp();
    return true;
  });

});
