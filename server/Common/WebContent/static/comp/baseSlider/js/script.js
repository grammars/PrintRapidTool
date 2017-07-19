$(document).ready(function(){
	// Set options
	var speed = 500;			// Fade speed
	var autoSwitch = true;		// Auto slider options
	var autoSwitchSpeed = 4000;	// Auto slider speed
	var hoverPause = true;	// Pause auto slider on hover
	var keyPressSwitch = true;	// Key press next/prev
	
	// Add initial active class
	$('#sliderContainer .slide').first().addClass('active');
	
	// Hide all slides
	$('#sliderContainer .slide').hide();
	
	// Show first slide
	$('#sliderContainer .active').show();
		
	// Switch to next slide
	function nextSlide(){
		$('#sliderContainer .active').removeClass('active').addClass('oldActive');
		if($('#sliderContainer .oldActive').is(':last-child')){
			$('#sliderContainer .slide').first().addClass('active');
		} else {
			$('#sliderContainer .oldActive').next().addClass('active');
		}
		$('#sliderContainer .oldActive').removeClass('oldActive');
		$('#sliderContainer .slide').fadeOut(speed);
		$('#sliderContainer .active').fadeIn(speed);
	}
	
	// Switch to prev slide
	function prevSlide(){
		$('#sliderContainer .active').removeClass('active').addClass('oldActive');
		if($('#sliderContainer .oldActive').is(':first-child')){
			$('#sliderContainer .slide').last().addClass('active');
		} else {
			$('#sliderContainer .oldActive').prev().addClass('active');
		}
		$('#sliderContainer .oldActive').removeClass('oldActive');
		$('#sliderContainer .slide').fadeOut(speed);
		$('#sliderContainer .active').fadeIn(speed);
	}

	// Key press event handler
	if(keyPressSwitch === true){
		$("body").keydown(function(e){
			if(e.keyCode === 37){
		    	nextSlide();
		  	} else if(e.keyCode === 39){
		    	prevSlide();
		  	}
		});
	}

	// Next handler
	$('#sliderContainer #next').on('click', nextSlide);
	
	// Prev handler
	$('#sliderContainer #prev').on('click', prevSlide);
	
	// Auto slider handler
	if(autoSwitch === true){
		var interval = null;
		interval = window.setInterval(function(){nextSlide();},autoSwitchSpeed);
	}

	// Stop and start on hover
	if(autoSwitch === true && hoverPause === true){
		$('#slider,#prev,#next').hover(function() {
		    window.clearInterval(interval);    
		}, function() {
		    interval = window.setInterval(function(){nextSlide();},autoSwitchSpeed);
		});
	}

	// Slider hover class handler
	$('#sliderContainer').hover(function() {
	    $('#sliderContainer').addClass('sliderHovered');
	}, function() {
	    $('#sliderContainer').removeClass('sliderHovered');
	});

});







