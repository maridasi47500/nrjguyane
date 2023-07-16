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
});
