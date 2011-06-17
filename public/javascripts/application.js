// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Initialize the patients/index check in buttons
$(function() {
  $("table#patients tbody tr").each(function(i, elt) {
    patient_id = $(this).attr("patient");
    checked_in = $(this).attr("checked_in") === "true";
    set_checked_in(patient_id, checked_in);
  });

  $('input[datepicker="true"]').datepicker({ dateFormat: "dd-mm-yy"});
  $('input[autocomplete="patient"]').autocomplete({
    minLength: 2,
    source: function(req, add) {
      $.getJSON('/patients/autocomplete/', req, function(data) {
        add(data);
      });
    }
  });

  var current_time = new Date();
  $.cookie('time_zone', current_time.getTimezoneOffset());
});

function set_checked_in(patient_id, checked_in) {
  elt = $("table#patients tr[patient=" + patient_id + "] td:first-child").first();
  if (checked_in) {
    elt.html('<span class="checked_in">Checked in</span>');
  }
  else {
    elt.html('<a href="/patients/' + patient_id + '/check_in" data-method="post" data-remote="true" rel="nofollow">Check in</a>');
  }
}
