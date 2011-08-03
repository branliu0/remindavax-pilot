// Used for /anms/* views

$(function() {
  $("form#new_anm input:checkbox").change(function(e) {
    if ($(this).is(':checked')) {
      $("form#new_anm input:submit").attr("data-confirm", "Are you sure you wish to replace another ANM?");
    }
    else {
      $("form#new_anm input:submit").removeAttr("data-confirm");
    }
  });
});
