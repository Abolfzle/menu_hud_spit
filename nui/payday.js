$(document).ready(function(){
    window.addEventListener('message', function(event) {
      var not = new Audio('not.mp3')
      var data = event.data;
      if (data.action == "paydayDetails") {
    	var html = `
        <div class="paydayContainer">
            <p class="textpd">${data.textPayday}</p>
            <p class="textpd2">AI GRIJA CE FACI CU EL!</p>
        </div>
        ` 
        $(html).prependTo(".content").hide().fadeIn(1000).delay(7000).fadeOut(1000);
      }

      if (data.action == "paydaySound") {
          not.volume = 0.4;
          not.play()
        }
    });
});