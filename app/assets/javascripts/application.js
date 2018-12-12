// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require bootstrap-tagsinput
//= require_tree .

$(function () { // Same as document.addEventListener("DOMContentLoaded"...

  // Same as document.querySelector("#navbarToggle").addEventListener("blur",...
  $("#navbarToggle").blur(function (event) {
    var screenWidth = window.innerWidth;
    if (screenWidth < 768) {
      $("#collapsable-nav").collapse('hide');
    }
  });
});



$(document).on('turbolinks:load', function() {

  $(".navselector").removeClass("active");

  if (window.location.pathname == "/") {
    $("body").css("background-image", "none");
  };

  var loc = window.location.href;

  if (/books/.test(loc)) {
    $("#books").addClass("active");
  }
  else if (/wanted/.test(loc)) {
    $("#wanted").addClass("active");
  }
  else if (/shelf/.test(loc)) {
    $("#shelf").addClass("active");
  }
  else if (/sign_up/.test(loc)) {
    $("#signup").addClass("active");
  }
  else if (/users/.test(loc)) {
    $("#profile").addClass("active");
  }

});
