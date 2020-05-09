// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery.jpostal
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require_tree .
window.addEventListener('load',function(){
  $("#user_postal_code").jpostal({
    postcode : [ "#user_postal_code" ],
    address  : {
       // 入力項目フォーマット
       //   %3  都道府県
       //   %4  市区町村
       //   %5  町域
       //   %6  大口事業所の番地
       //   %7  大口事業所の名称
        "#user_prefecture_code"    : "%3",
        "#address_city"            : "%4%5",
        "#address_street"          : "%6%7"
    }
  })
});


let map;
let geocoder;

function initMap(){
geocoder = new google.maps.Geocoder()

  // Mapを表示する
  map = new google.maps.Map(document.getElementById('map'), {
    // latが緯度、lngが経度
    center: {lat: 40.7828, lng: 73.9653},
    // zoomは0〜21まで指定できる。数値が大きいほど拡大できる
    zoom: 12,
  });

  codeAddress()
  function codeAddress(){
    var address = $('#address').text()
    console.log(address)
    geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == 'OK') {
      map.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
        });
      }
    });
  }
}
