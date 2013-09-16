//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-datepicker/bootstrap-datepicker
//= require bootstrap-datepicker/locales/bootstrap-datepicker.pt-BR
//= require_tree ./admin/

// require libs/chosen/chosen.jquery
// require libs/maskedinput/jquery.maskedinput
// require general

$('.datepicker').datepicker({
  language: 'pt-BR',
  format: 'dd-mm-yyyy'
});
