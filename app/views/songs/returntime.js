	var audio1 = new Audio('/uploads/<%=@song.filename%>');
	audio1.addEventListener("loadedmetadata", setSliderMax);
        
	function setSliderMax() {
                $.ajax({url: "/songs/<%=@song.id%>", data: {song: {duree: audio1.duration}}, type: "patch"});
               
                
	}

