$(function(){
  $('button.act_as_radio_button').click(function(){
    var this_hidden = $('#' + this.name);
    var selected_btn = $('button.btn-info[name=' + this.name + ']');
    //console.log(selected_btn);

    this_hidden.val( $(this).data("value") );
    selected_btn.removeClass($(this).data("selected"));
    $(this).addClass($(this).data("selected"));
  });
  
  $('button.act_as_check_box').click(function(){
    var value = $(this).data("value");
    var this_hidden = $('#' + this.name + '_' + value);
    var checked = this_hidden.prop("checked");
    //console.log($(this).data("selected"));
    if(checked){
      this_hidden.prop('checked', false);
      $(this).removeClass($(this).data("selected"));
    }else{
      this_hidden.prop('checked', true);
      $(this).addClass($(this).data("selected"));
    }
  });
  $('form.edit_house input').change(function() {
    console.log('123');
  });

  $('.datetimepicker').datetimepicker({
    format: 'YYYY-MM-DD'
  });
})
