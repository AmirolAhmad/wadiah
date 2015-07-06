$(document).ready( function () {
  $('#payment_payment_date').datepicker({
      format: 'dd/mm/yyyy',
      todayBtn: "linked",
      weekStart: 1,
      todayHighlight: true,
      autoclose: true
  });
  $('#payment_payment_time').timepicker({
    minuteStep: 5,
    showInputs: false,
    disableFocus: true
  });
});