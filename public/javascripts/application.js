// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Initialize the patients/index check in buttons
$(function() {
  $("td.check-in").each(function(i, elt) {
    var $this = $(this);
    var checkedIn = $(this).attr('data-checked-in') === "true";
    if (checkedIn) {
      $this.html('<span class="checked_in">Checked in</span>');
    }
    else {
      $this.html('<a href="javascript:void(0)" rel="nofollow">Check in</a>');
    }
  });
  $("td.check-in a").live('click', function(e) {
    var $this = $(this);
    var patientId = $this.parent().attr('data-patient');
    $.post("/patients/"+patientId+"/check_in", function(data) {
      $this.parent().html('<span class="checked_in">Checked in</span>');
    });
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

  $("#batch_update_dates").click(function(e) {
    var ids = [];
    var dates = [];
    $('input[updateable="true"]').each(function(i, elt) {
      ids.push($(this).attr("appt_id"));
      dates.push($(this).attr("value"));
    });
    $.post('/appointments/batch_update_dates', { ids: ids, dates: dates }, function(data) {
      window.location.reload();
    });
  });

  // var current_time = new Date();
  // $.cookie('time_zone', current_time.getTimezoneOffset());
});
