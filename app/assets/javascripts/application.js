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

//MOBILE NAV

	$(document).on('click', "#menu_icon", function(){
		$("#mobile_nav").slideToggle();
		$("#content").toggle();
	});
	$(window).resize(function(){
		var w = $(window).width();
		if(w > 480){
			$("#mobile_nav").hide();
			$("#content").show();
		}
	});

//SLIDER

	var currentImageIndex = 0;
	var numImages = $('.slider-img').length;

//SLIDER-NAVAGATION

	$('#slider').hover(
		function() {
			$('.slider-nav').show();
		}, function() {
			$('.slider-nav').hide();
		}
	);

	$('#next').click( function() {
		$('.slider-img').eq(currentImageIndex).fadeOut(800);

		currentImageIndex = (currentImageIndex + 1) % numImages;

		$('.slider-img').eq(currentImageIndex).fadeIn(800);
	});

	$('#prev').click( function() {
		$('.slider-img').eq(currentImageIndex).fadeOut(800);

		currentImageIndex = (currentImageIndex - 1) % numImages;

		$('.slider-img').eq(currentImageIndex).fadeIn(800);
	});

//LIGHTBOX

	$('#tour').click(function() {
		$('#lightbox-wrapper').fadeIn();
		$('body').addClass('lightbox-on');
	});

	$('#exit').click( function() {
		$('#lightbox-wrapper').fadeOut();
		$('body').removeClass('lightbox-on');
	});

});
