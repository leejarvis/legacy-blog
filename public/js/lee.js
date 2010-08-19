$(document).ready(function() {

  $("#login-dialog").hide();
  $("#contact-dialog").hide();
  $("#tags-dialog").hide();

  $("#login").toggle(function() {
    $(this).addClass('alive');
    $("#login-dialog").slideDown();
    $("#form-username").focus();
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
    return false;
  }, function() {
    $("#contact-dialog").slideUp();
    $(this).removeClass('alive');
    return false;
  });

  $("#tags").toggle(function() {
    $(this).addClass('blue');
    $("#tags-dialog").slideDown();
    return false;
  }, function() {
    $("#tags-dialog").slideUp();
    $(this).removeClass('blue');
    return false;
  });

});
