// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready( function (){
	menu_iconToggled = true
	$("#menu_icon").click( function(){
		if(menu_iconToggled){
			$("#mobile_nav").show();
			$("#content").hide();
			menu_iconToggled = false
		}else{
			$("#mobile_nav").hide();
			$("#content").show();
			menu_iconToggled = true
		}
	});
	$(".mobile_menu_item").click( function(){
		$("#mobile_nav").hide();
		$("#content").show();
		menu_iconToggled = true
	});
	$(window).resize(function(){
		var w = $(window).width();
		if(w > 480){
			$("#mobile_nav").hide();
			$("#content").show();
			menu_iconToggled = true
		}
	});
});
