// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Initialize the patients/index check in buttons
$(function() {
  $("td.check-in").each(function(i, elt) {
    patient_id = $(this).attr("patient");
    checked_in = $(this).attr("checked_in") === "true";
    if (checked_in) {
      $(this).html('<span class="checked_in">Checked in</span>');
    }
    else {
      $(this).html('<a href="/patients/' + patient_id + '/check_in" data-method="post" data-remote="true" rel="nofollow">Check in</a>');
    }
  });

  $('input[datepicker="true"]').datepicker({ dateFormat: "M-dd-yy"});
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
