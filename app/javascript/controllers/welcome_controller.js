function on(e) {
	e.preventDefault();
  document.getElementById("overlay").style.display = "block";
	return false;
}

function off() {
  document.getElementById("overlay").style.display = "none";
} 
$(function(){
	$(".closemenu").click(function(e){
        e.preventDefault();
        e.stopPropagation();
  document.getElementById("overlay").classList.add("closeme");
setTimeout(() => {
  console.log("Delayed for 1 second.");
  document.getElementById("overlay").style.display = "none";
  document.getElementById("overlay").classList.remove("closeme");
}, "1000");


});
	$(".navbar-toggler.ijijijkijiji").click(function(e){
        e.preventDefault();
        e.stopPropagation();
  document.getElementById("overlay").style.display = "block";

});


function init() {
	"use strict";
	var posSlider = document.getElementById("myRange");
	var volSlider = document.getElementById("myVol");
	var audio1 = new Audio('/flash/musik/ausflug.mp3');
	var goBut = document.getElementById("goButton");
	var playPic = "/img/play.png";
	var pausePic = "/img/pause.png";

	audio1.addEventListener("loadedmetadata", setSliderMax);
        
	function setSliderMax() {
            console.log(audio1.duration, "audio duration");
		posSlider.setAttribute('max', audio1.duration);
		posSlider.setAttribute('min', 0);
	}
	goBut.addEventListener("click", audioPlayPause);

	function audioPlayPause() {
		if (audio1.paused) {
			audio1.play();
			goBut.src = pausePic;
		} else {
			audio1.pause();
			goBut.src = playPic;
		}
	}

	audio1.addEventListener("timeupdate", setSliderVal);

	function setSliderVal() {
            console.log(audio1.currentTime)
		posSlider.value = audio1.currentTime;
		if (audio1.ended) {
			posSlider.value = 0;
			audio1.currentTime = 0;
			goBut.src = playPic;
			audio1.pause();
		}
	}

	posSlider.addEventListener("input", setPos);

	function setPos() {
		audio1.currentTime = posSlider.value;
	}

	volSlider.addEventListener("input", setVol);

	function setVol() {
		audio1.volume = volSlider.value / 100;
	}
};
init();

});
