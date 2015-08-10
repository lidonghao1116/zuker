$(function(){
  $('button.act_as_radio_button').click(function(){
    var this_hidden = $('#' + this.name);
    var selected_btn = $('button.btn-info[name=' + this.name + ']');
    //console.log(selected_btn);

    this_hidden.val( $(this).data("value") );
    selected_btn.removeClass('btn-info');
    $(this).addClass('btn-info');
  });
})
