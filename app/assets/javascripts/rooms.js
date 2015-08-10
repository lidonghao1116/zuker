$(function(){
  $('button.act_as_radio_button').click(function(){
    var this_hidden = $('#' + this.name);
    var selected_btn = $('button.btn-info[name=' + this.name + ']');
    //console.log(selected_btn);

    this_hidden.val( $(this).data("value") );
    selected_btn.removeClass('btn-info');
    $(this).addClass('btn-info');
  });
  
  $('button.act_as_check_box').click(function(){
    var value = $(this).data("value");
    var this_hidden = $('#' + this.name + '_' + value);
    var checked = this_hidden.prop("checked");
    //console.log(checked);
    if(checked){
      this_hidden.prop('checked', false);
      $(this).removeClass('btn-info');
    }else{
      this_hidden.prop('checked', true);
      $(this).addClass('btn-info');
    }
    //console.log(checked);
  });
})
