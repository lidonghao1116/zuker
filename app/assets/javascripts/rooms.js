function hidden_helper_btn(input, btn_id) {
  $('#'+input.id).val( $('#'+btn_id).data("value") );
  $('.btn-info.room_type_btn').removeClass('btn-info');
  $('#'+btn_id).addClass('btn-info');
}