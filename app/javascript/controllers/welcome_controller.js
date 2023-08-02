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
	var audio1=new Audio();
        var minduration;
        /*$.ajax({url:"/songs/jouerunechanson",success:function(data){
                minduration=data.maduree;
        audio1=new Audio('/uploads/'+data.song.filename);*/

	var goBut = document.getElementById("goButton");
	var playPic = "/img/play.png";
	var pausePic = "/img/pause.png";
        var paspremier=false;
	var mydata;
       
	$(goBut).click(function (e) {
            e.preventDefault();
		if (!audio1 || audio1.paused) {
                     $.ajax({type:"get",url:"/songs/playmusique",data:{play:1},
        success:function(data){
console.log(data);
        }
        });
			
                        $.ajax({url:"/songs/jouerunechanson",success:function(data){
                            minduration=data.maduree;
                            mydata=data;
                            if(data.song){
                    audio1.src=('/uploads/'+data.song.filename);
                            }
                    if (!paspremier){
                    audio1.addEventListener('loadedmetadata',setMax);
        function setMax() {
            //e.preventDefault();
            console.log(audio1.duration, "audio duration");
		posSlider.setAttribute('max', audio1.duration);
		posSlider.setAttribute('min', 0);
                //alert(minduration);
                audio1.currentTime = minduration;
                audio1.play();
                $(".precedent").html("<h6>précédente</h6><span>"+(mydata.song.artist_prec|| "")+"</span><span>"+(mydata.song.title_prec|| "")+"</span>");
                $(".encours").html("<h6>Maintenant</h6><span>"+(mydata.song.artist|| "")+"</span><span>"+(mydata.song.title|| "")+"</span>");
                $(".avenir").html("<h6>Suivante</h6><span>"+(mydata.song.artist_suiv|| "")+"</span><span>"+(mydata.song.title_suiv|| "")+"</span>");
                //posSlider.value = minduration;
	};
                audio1.addEventListener("timeupdate", voirmusique);
	function voirmusique() {
            console.log("tyui CURRENTIME",audio1.currentTime);
		posSlider.value = 0;
		//posSlider.value = audio1.currentTime;
		if (audio1.ended || audio1.max === audio1.duration) {
                    $.ajax({url:"/songs/jouerunechanson",success:function(data){
                                    minduration=data.maduree;
                                    mydata=data;
                                    if(data.song){
                            audio1.src='/uploads/'+data.song.filename;
                                    }
                        }});
			posSlider.value = 0;
			audio1.currentTime = 0;
			//goBut.src = playPic;
			//audio1.pause();
		}
	};
        paspremier=true;
        }
                    audio1.play();
			goBut.src = pausePic;
                }});
            
                        
		} else {
			audio1.pause();
			goBut.src = playPic;
                          $.ajax({type:"get",url:"/songs/playmusique",data:{play:0},
        success:function(data){
console.log(data);
        }
        });
		}
	});


	/*$(posSlider).on('input',function (e) {
            e.preventDefault();
		audio1.currentTime = posSlider.value;
	});*/

	$(volSlider).on('input',function (e) {
            e.preventDefault();
		audio1.volume = volSlider.value / 100;
                $.ajax({type:"get",url:"/songs/playmusique1",data:{myvol: $("#myVol").val()},
        success:function(data){
console.log(data);
        }
        });
	});
     
        $.ajax({url:"/songs/musique",
        success:function(data){
            if (data.ok === "1"){
                //alert(data.myvol)
                $(goBut).click();
                $("#myVol")[0].value=(parseInt(data.myvol));
                audio1.volume = volSlider.value / 100;
            }
        }
        });
            /*}});*/
};

init();

});
