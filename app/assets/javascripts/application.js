// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require semantic-ui
//= require moment
//= require moment/zh-tw
//= require moment/az
//= require nprogress
//= require nprogress-turbolinks
//= require bootstrap-datetimepicker
//= require pickers
//= require gmaps
//= require jquery.twzipcode.min
//= require turbolinks
//= require_tree .

$(function() {
  $('.ui.form').form({
    on: 'blur',
    fields: {
      last_name: {
        identifier: 'user[last_name]',
        rules: [
          {
            type   : 'empty',
            prompt : 'Please enter your name'
          }
        ]
      },
      first_name: {
        identifier: 'user[first_name]',
        rules: [
          {
            type   : 'empty',
            prompt : 'Please enter your name'
          }
        ]
      },
      phone_number: {
        identifier: 'user[phone_number]',
        rules: [
          {
            type   : 'empty',
            prompt : 'Please enter your phone number'
          },
          {
            type   : 'regExp[/^[0][9][0-9]{2}[0-9]{6}$/]',
            prompt : 'Please enter a valid phone number'
          }
        ]
      },
      password: {
        identifier: 'user[password]',
        rules: [
          {
            type   : 'empty',
            prompt : 'Please enter a password'
          },
          {
            type   : 'minLength[6]',
            prompt : 'Your password must be at least {ruleValue} characters'
          }
        ]
      },
      password_confirmation: {
        identifier: 'user[password_confirmation]',
        rules: [
          {
            type   : 'empty',
            prompt : 'Please re-enter your password'
          },
          {
            type   : 'match[user_password]',
            prompt : 'Should match password'
          }
        ]
      }
    }
  })
});