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
//= require_tree .


function advertising() {
    alert("Ensure that Ads been created - Only TRUE or False ");
}

function subscribed() {
    alert("DO NOT CHANGE THIS FIELD");
}

function websiteID() {
    alert("DO NOT CHANGE THIS FIELD");
}

 $.getScript('http://www.chartjs.org/assets/Chart.js',function(){
        var ctx = $("#mycanvas").get(0).getContext('2d');

        var chart = new Chart(ctx).Doughnut(data);
        var div = document.getElementById('searches');
        var color = document.getElementById('blue');
        div.innerHTML = data[0].label
        color.style.background = "rgb(100,149,237)";

        var div0 = document.getElementById('clicks');
        var color0 = document.getElementById('orange');
        div0.innerHTML = data[1].label
        color0.style.background = "rgb(255,165,0)";

        var div1 = document.getElementById('calls');
        var color1 = document.getElementById('green');
        div1.innerHTML = data[2].label
        color1.style.background = "rgb(144, 238, 144)";
        console.log(data[0].label)
        console.log(data[0].color)

        // Chert 2 ---------------------------------------------->
         var ctx1 = $("#mycanvas2").get(0).getContext('2d')
         

        var chart = new Chart(ctx1).Doughnut(data_chart2);
        var div_chart1 = document.getElementById('smartphones');
        var color_chart1 = document.getElementById('lightblue');
        div_chart1.innerHTML = data_chart2[0].label
        color_chart1.style.background = "#63ff90";

        var div_chart2 = document.getElementById('tablets');
        var color_chart2 = document.getElementById('red');
        div_chart2.innerHTML = data_chart2[1].label
        color_chart2.style.background = "#ff6384";

        var div_chart3 = document.getElementById('computers');
        var color_chart3 = document.getElementById('limegreen');
        div_chart3.innerHTML = data_chart2[2].label
        color_chart3.style.background = "#63d2ff";
        


      });

