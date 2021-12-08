$(document).on('turbolinks:load', function() {
    var selectpickers = $('.selectPicker')
    if($('.bootstrap-select').length) { console.log('select') }
    if ($('.bootstrap-select')) { $('.selectPicker').selectpicker({noneSelectedText: ''}); }
    //if (selectpickers) { selectpickers.selectpicker({noneSelectedText: ' '}); }

    var resource_format_id = $("#resource_format_id");
    if (resource_format_id) { ShowUploadOrTranslationSection(); }

    resource_format_id.change(function() {
      ShowUploadOrTranslationSection();
    });

    $("#index-search-engine :input").change(function() {
      $("#index-search-engine").submit();
    });
});

var ShowUploadOrTranslationSection = function() {
  var format_id = $("#resource_format_id").val();

  if (format_id){
    var code = $(`#resource_format_id option[value=${format_id}]`).data('code');
  }

  if (code == 'TRA') {
    $(".ressource-translation").removeClass('d-none');
    $(".ressource-upload").addClass('d-none');
    $("#resource_file").removeAttr('required');
  } else {
    $(".ressource-upload").removeClass('d-none');
    $(".ressource-translation").addClass('d-none');
    $("#resource_translation").removeAttr('required');
  }
};
