
window.addEventListener("message", function(event){
    // $("allhud").css("display", event.data.show ? "block" : "none");
    let data = event.data
    icon = '<i class="fa fa-university" aria-hidden="true"></i>'
    ceas = '<i class="fa fa-clock" style = "color:rgb(255,255,255, .8); aria-hidden="true" ></i>'
    if (data.action == "deschideHud") {
        const d = new Date();
      //  document.getElementById("demo").innerHTML =  d.getHours() + ":" +d.getMinutes() ;
        // document.querySelector("#number").innerHTML = data.number;
        // var dt = new Date();    
        // var d = new Date(); 
        // calendar =  '<i class="fa fa-calendar-alt" aria-hidden="true" style = "position:absolute;color:rgb(255,255,255);backround: rgb(0,0,0, .8); left: 13px; font-size: 16px; border-radius: 4px; "></i>'
        // var months = ["/01","/02","/03","/04","/05","/06","/07","/08","/09","/10","/11","/12"];
        // document.getElementById("datetime").innerHTML ="<span class='symbol'></span>" + "" + d.getDate() + "" + months[d.getMonth()] + "/" + d.getFullYear() + calendar;


        icon = '<i class="fa fa-university" aria-hidden="true"></i>'
        iconusers = '<i class="fa fa-users" style = "color:#fff; aria-hidden="true"></i>'

        users =  '<i class="fa fa-user" aria-hidden="true" style = "position:absolute;color:#fee935; text-shadow: none; top: 13px; font-size: 15px; border-radius: 4px; "></i>'

        job =  '<i class="fas fa-briefcase" aria-hidden="true" style = "position:absolute;color:rgb(255,255,255); padding: 11px; width: 14%; top: 0px; font-size: 18px; "></i>'  
        bank =  '<i class="fas fa-university" aria-hidden="true" style = "position:absolute;color:rgb(255,255,255); padding: 11px; width: 14%; top: -4px; font-size: 22px; "></i>'  
        
        diamante =  '<i class="fa fa-diamond" aria-hidden="true" style = "position:absolute;color:rgb(255,255,255);backround: rgb(0,0,0, .8); left: -10px; top: 7px; font-size: 16px; border-radius: 4px; "></i>'
        voce =  '<i class="fa fa-headphones" aria-hidden="true" style = "position:absolute;color:rgb(255,255,255);backround: rgb(0,0,0, .8); left: 33px; top: 46px; font-size: 16px; border-radius: 4px; "></i>'
        wallet =  '<i class="fas fa-wallet" aria-hidden="true" style = "position:absolute;color:rgb(255,255,255);padding: 11px; width: 14%;top: 5px; font-size: 22px; "></i>'   
        cerc = '<i class="" padding-left: 5px; font-size: 8px; border-radius: 9999999px; padding-right: 5px; padding-top: 0px; padding-bottom: 0px; border-radius: 99999999999px; border: 2px solid #fff; background: rgb(22, 22, 22); color: rgb(255, 255, 255); text-shadow: none;  font-weight: 700; bottom: -40px;"> </i>'


        document.getElementById("allhud").style.display = "block";
        // document.getElementById("codRadio").style.display = "block";
        
        document.querySelector("#myname").innerHTML ="&nbsp " + "&nbsp " + '<span class="" style="color: #fee935" aria-hidden="true">ID: </span>'+ data.id + " &nbsp " + "&nbsp" + users  + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + data.users + "";        
        // document.querySelector("#factiune").innerHTML = data.factiune +" - "  + data.rank;
       // document.querySelector("#mymoney").innerHTML ="<span class='symbol'></span>" + "$"+data.money;
     //   document.querySelector("#bankmoney").innerHTML ="<span class='symbol'></span>"+ bank+ "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp"  + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp"  + "&nbsp" + "&nbsp" + "&nbsp"+ "&nbsp"+"$"+data.bankmoney;  
 
        document.querySelector("#nume").innerHTML = data.nume;
        // document.querySelector("#ss").innerHTML =data.number;
        // document.querySelector("#soldmana").innerHTML = data.bankmoney +" EUR";
        document.querySelector("#bank").innerHTML ="BANCA: "+data.bankmoney;
        // document.querySelector("#mymoney").innerHTML ="PORTOFEL: " + data.money;
        document.querySelector("#organizatie").innerHTML = data.factiune;
        document.querySelector("#vip").innerHTML = data.vip;
        document.querySelector("#ids").innerHTML = "#"+data.id;
        document.querySelector("#ore").innerHTML = data.ore;
        document.querySelector("#vips").innerHTML = data.vip;
        document.querySelector("#organizaties").innerHTML = data.factiune;
        document.querySelector("#group").innerHTML = data.group;

        document.querySelector("#nameIG").innerHTML = data.nameIG;
        document.querySelector("#number").innerHTML = data.number;
        document.querySelector("#staff").innerHTML = data.staff;
                
   
    }
    if (data.action == "safezone") {
        document.getElementById("safezone").style.display = data.stil;
    }
    if (data.action == "hud") {
        document.getElementById("allhud").style.display = data.value;
    }
    if (data.action == "mission") {
        document.getElementById("quest").style.display = data.value;
        document.querySelector("#misiune").innerHTML = data.misiune;
    }
    if (data.action == "respawn") {

        if (data.stil == "block") {
            $("#respawn").fadeIn();
        }else if (data.stil == "none") {
            $("#respawn").fadeOut();
        }
        document.querySelector("#respawnText").innerHTML = data.text;
    }
    if (data.action == "test") {

        if (data.stil == "block") {
            $(".container").fadeIn();
        }else if (data.stil == "none") {
            $(".container").fadeOut();
        $.post('http://vrp_hud/exitcacat', JSON.stringify({}));
        }
        document.getElementById("diamante-value").innerHTML = data.shopbalance;
    }
    if (data.action == "jail") {
        document.getElementById("jail").style.display = data.stil;
        document.querySelector("#motiv").innerHTML = data.motiv;
        document.querySelector("#minutes").innerHTML = data.minutes + "  MIN";
        document.querySelector("#staffMember").innerHTML = "JAILED BY " + data.staff;
    }
    if (data.action == "comenzi") {
        document.getElementById("texte").style.display = data.value;
    }

    if (data.action == "codRadioTEXT") {
        document.getElementById("codRadio").style.display = data.value;
    }
    
    if(event.data.payday){
      $(".payday").html("<span class='symbol'></span>" + event.data.payday);
    }   

    if (data.action == "voicechat") {
        if (data.toggle == false) {
            voice = " &nbsp   &nbsp   &nbsp &nbsp  " + '<i class="fa fa-microphone-slash" aria-hidden="true" style = "text-shadow: 15px 4px 18px -2px rgba(255,255,255,0.46); position:absolute;color:rgb(255,255,255, .7);font-size: 30px;right: -9%;top: -0.20em;transition: 0.6s;transition-timing-function: ease; text-shadow: none; box-shadow: none; background: none; border-radius: 50%;padding: 8px;"></i>'
            buton = '<i class style="padding-left: 7px; font-size: 14px; border-radius: 9999999px; padding-right: 7px; margin-top: 19.65em; padding-top:2px; padding-bottom: 2px; transition: 0.6s;transition-timing-function: ease;  border: 3px solid rgba(255, 255, 255, 0.521); font-family: fontcustom; font-style: normal; background: rgba(255, 255, 255, 0); color: rgb(255, 255, 255); text-shadow: none;  font-weight: 700;"> N </i>'      


        }else if (data.toggle == true) {
            voice = " &nbsp   &nbsp   &nbsp &nbsp  " +'<i class="fas fa-microphone" aria-hidden="true" style = "text-shadow: 15px 4px 18px -2px rgba(255,255,255, .46); position:absolute;color:white;font-size: 30px;right: -43px;top: -0.20em; transition: -0.6s;transition-timing-function: ease; border-radius: 50%; text-shadow: none; box-shadow: none; background: none; padding: 8px;"></i>'
            buton = '<i class style="padding-left: 7px; font-size: 14px; border-radius: 9999999px; padding-right: 7px; margin-top: 19.65em; padding-top: 2px;transition: 0.6s;transition-timing-function: ease;  padding-bottom: 2px; border: 3px solid rgba(255, 255, 255, 1); font-family: fontcustom; font-style: normal; background: rgba(255, 255, 255, 0); color: rgb(255, 255, 255); text-shadow: none;  font-weight: 700;"> N </i>'      

        }
		document.querySelector("#voceaMagicaAPorumbelului").innerHTML ="&nbsp "+ "&nbsp " + voice +" &nbsp " +  "&nbsp " + buton ;
    }
    if (data.action == "tryTicket") {
        document.getElementById("tickete").style.display = data.stil;
        document.getElementById("tickete").innerHTML = data.tickete;
    }   
});

function cumparaPack() {
    $.post('http://vrp_hud/cumparaStarterPack', JSON.stringify({}));
}

function cumparaGold() {
    $.post('http://vrp_hud/cumparaGold', JSON.stringify({}));
}



function callMedics() {
    $.post('http://vrp_hud/callMedics', JSON.stringify({}));
}

function sunaPolice() {
    $.post('http://vrp_hud/sunaPolice', JSON.stringify({}));
}

function sunaTaxi() {
    $.post('http://vrp_hud/sunaTaxi', JSON.stringify({}));
}

$(function () {
    function display(bool) {
        if (bool) {
            // $("#container").show();
            $("#container").fadeIn();

        } else {
            // $("#container").hide();
            $("#container").fadeOut();
            $.post('http://vrp_hud/exitcacat', JSON.stringify({}));
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://vrp_hud/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('http://vrp_hud/exit', JSON.stringify({}));
        return
    })

    $("#submit").click(function () {
        let inputValue = $("#input").val()
        if (inputValue.length >= 100) {
            $.post("http://vrp_hud/error", JSON.stringify({
                error: "Input was greater than 100"
            }))
            return
        } else if (!inputValue) {
            $.post("http://vrp_hud/error", JSON.stringify({
                error: "There was no value in the input field"
            }))
            return
        }
        $.post('http://vrp_hud/main', JSON.stringify({
            text: inputValue,
        }));
        return;
    })
})

$(function () {
    function display(bool) {
        if (bool) {
            // $("#container").show();
            $("#telefon").fadeIn();

        } else {
            // $("#container").hide();
            $("#telefon").fadeOut();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://vrp_hud/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('http://vrp_hud/exit', JSON.stringify({}));
        return
    })

    $("#submit").click(function () {
        let inputValue = $("#input").val()
        if (inputValue.length >= 100) {
            $.post("http://vrp_hud/error", JSON.stringify({
                error: "Input was greater than 100"
            }))
            return
        } else if (!inputValue) {
            $.post("http://vrp_hud/error", JSON.stringify({
                error: "There was no value in the input field"
            }))
            return
        }
        $.post('http://vrp_hud/main', JSON.stringify({
            text: inputValue,
        }));
        return;
    })
})

function showPopup() {
    event.preventDefault();
    document.getElementById("popup_content").classList.toggle("show");
    return false;
}



window.onclick = function(event) {
    if (!event.target.matches('.thePopup')) {

        var dropdowns = document.getElementsByClassName("popup_content");
        var i;
        for (i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                // openDropdown.classList.remove('show');
            }
        }
    }
}

$('.Show').click(function() {
    $('#target').show(500);
    $('.Show').hide(0);
    $('.Hide').show(0);
});
$('.Hide').click(function() {
    $('#target').hide(500);
    $('.Show').show(0);
    $('.Hide').hide(0);
});
$('.toggle').click(function() {
    $('#target').toggle('slow');
});