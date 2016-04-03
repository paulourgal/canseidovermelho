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
//= require jquery-ui/datepicker
//= require jquery.maskedinput
//= require jquery.maskMoney
//= require_tree .

$(function() {
  $( ".datepicker" ).datepicker({
    dateFormat: "dd/mm/yy",
    monthNamesShort: [ "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago",
      "Set", "Out", "Nov", "Dez" ],
    dayNamesMin: [ "Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab" ],
    changeMonth: true,
    changeYear: true
  });

  $(".money-field").maskMoney({
    showSymbol: true,
    symbol: 'R$ ',
    symbolStay: true,
    decimal:',',
    thousands:'.'
  });

  $('.datepicker').mask('99/99/9999');
});
