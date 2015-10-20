// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.arcticmodal-0.3.min
//= require_tree .

$(function(){
    $(document).on('click', '.faq li', function(){
        $(this).next().toggle();
        $(this).toggleClass('active')
    });

    //change visual academic level radio-button
    $(document).on('click', '[type=radio]', function(){
        var id = $(this).attr('id');
        var is_checked = ($(this).attr('checked') == 'checked')?false:true;
        if(is_checked) {
            $('[type=radio]:not(this)').attr('checked', false);
            $(this).prop('checked', true);
            $('.radio[for="' + id + '"]').addClass('active');
            $('.radio').not('[for=' + id + ']').removeClass('active');
        }
    });

    //amount of pages
    var counter = 1;
    $(document).on('click','.plus, .minus', function(){
        var _this = $(this).hasClass('minus')?true:false;
        var pages_count = parseInt($('#order_pages').val());
        if(_this){
            if(pages_count <= 1){
                $('input.count').val(1);
                counter = 1;
                words = 275*counter;
                $('#order .words').text(words+' words');
            }else{
                counter = pages_count - 1;
                $('input.count').val(counter);
                words = 275*counter;
                $('#order .words').text(words+' words');
            }
        }else{
            if(pages_count >= 99){
                $('input.count').val(99);
                counter = 99;
                words = 275*counter;
                $('#order .words').text(words+' words');
            }else{
                counter = pages_count + 1;
                words = 275*counter;
                $('input.count').val(counter);
                $('#order .words').text(words+' words');
            }
        }
        calculate_order(true);
    });

    //change select list
    $(document).on('change','[name="order[academic_level]"], [name="order[deadline]"], [name="order[pages]"], [name="order[type_of_paper]"]', function(){
      calculate_order(true);
      change_select_color();
    });

    $(document).on('change', '[name="order[discipline]"]', function(){
      change_select_color();
    });

    //change select color
    change_select_color = function(){
        if($('[name="order[type_of_paper]"]').val() !=''){
            $('[name="order[type_of_paper]"]').addClass('grey');
        }else{
            $('[name="order[type_of_paper]"]').removeClass('grey');
        }

        if($('[name="order[deadline]"]').val() !=''){
            $('[name="order[deadline]"]').addClass('grey');
        }else{
            $('[name="order[deadline]"]').removeClass('grey');
        }

        if($('[name="order[discipline]"]').val() !=''){
            $('[name="order[discipline]"]').addClass('grey');
        }else{
            $('[name="order[discipline]"]').removeClass('grey');
        }
    }

    $(document).bind('input', '[name="order[pages]"]', function(){
        calculate_order(true);
    });
    calculate_order = function (flag) {
        var url = $('.disappear').attr('href');
        var form = $('#order').serialize();
        var type = $('#order_type_of_paper');
        var deadline = $('[name="order[deadline]"]');
        var pages = $('#order .count');
        if(flag){
            if(type.val() != '' && deadline.val() != '' && pages.val() !='') {
                calculate_order();
            }
        }else {
            if (type.val()=='' || deadline.val()=='' || pages.val()=='') {
                (type.val()=='')?type.addClass('error-field'):type.removeClass('error-field');
                (deadline.val()=='')?deadline.addClass('error-field'):deadline.removeClass('error-field');
                (pages.val()=='')?$('.pages-steps').addClass('error-field'):$('.pages-steps').removeClass('error-field');
                return true;
            }else {
                type.removeClass('error-field');
                deadline.removeClass('error-field');
                $.get(url, form).done(function (data) {
                    $('#order .price').text(data.text);
                    var price = $('#order_price').val(data.price)
                });
                return false;
            }
        }
    };

    //check update order's field to enable
    check_update_order = function(){
        var select = $('[name="order[discipline]"]');
        var text_field = $('[name="order[topic]"]');
        var textarea_field = $('[name="order[details]"]');
        if(select.val()=='' || text_field.val()=='' || textarea_field.val()==''){
            (select.val()=='')?select.addClass('error-field'):select.removeClass('error-field');
            (text_field.val()=='')?text_field.addClass('error-field'):text_field.removeClass('error-field');
            (textarea_field.val()=='')?textarea_field.addClass('error-field'):textarea_field.removeClass('error-field');
            return true;
        }else{
            return false;
        }
    }

    $('#update').on('submit', function(){
        if(check_update_order()){
            return false;
        }
    });

    $(document).on('submit', '#order', function(){
        if(calculate_order(false)){
            return false;
        }
    });

    //enter only integer in calculator field
    $(document).on('change keyup input click', '#order .count', function(event) {
        if (this.value.match(/[^0-9]/g)) {
            this.value = this.value.replace(/[^0-9]/g, '');
        }else{
            if(this.value.length > 0) {
                $('.pages-steps').removeClass('error-field');
            }
            if(this.value.length <= 2) {
                words = 275 * (this.value);
                $('#order .words').text(words + ' words');
            }else{
                this.value = this.value.substr(0,2);
            }
        }
    });

    $(document).on('click', '.place-order', function () {
        $('#order [type="submit"]').click();
    });

    //remove added input [type=file]
    $(document).on('click', '.file .added', function(){
        return false;
    });
    $(document).on('click', '.remove', function(){
        $(this).closest('.file').remove();
    });

    //sign-in or sign-up box-modal
    $(document).on('click', '.account', function(){
        $('#sign-in').arcticmodal();
    })

    //check fields for sign in or sign up
    check_sign_in_fields = function(){
        var email = $('.email-sign-in');
        var password = $('.password-sign-in');
        if(!isEmail(email.val()) || password.val()==''){
            (!isEmail(email.val()))?email.addClass('error-field'):email.removeClass('error-field');
            (password.val()=='')?password.addClass('error-field'):password.removeClass('error-field');
            return false;
        }else{
            return true;
        }
    }
    check_sign_up_fields = function(){
        var email = $('.email-sign-up');
        var password = $('.password-sign-up');
        if(!isEmail(email.val()) || password.val()==''){
            (!isEmail(email.val()))?email.addClass('error-field'):email.removeClass('error-field');
            (password.val()=='')?password.addClass('error-field'):password.removeClass('error-field');
            return false;
        }else{
            return true;
        }
    }

    $(document).on('submit', '#sign_up_form, #sign_in_form', function(){
        var current_action_id = ($(this).attr('id'));
        var current_form = $('#'+current_action_id);
        if(current_action_id == 'sign_up_form'){
            var valid = check_sign_up_fields();
            var action = 'sign_up';
        }else if(current_action_id == 'sign_in_form'){
            var valid = check_sign_in_fields();
            var action = 'sign_in';
        }

        if(valid){
            var _this = this;

            $.ajax({
                type: ($(this).attr('_method') != undefined) ? $(this).attr('_method') : "POST",
                url: $(this).attr('action'),
                data: $(this).serializeArray() ,
                dataType: 'json'
            }).complete(function (e) {
                if(action == 'sign_in') {
                    if (e.status == 201 || e.status == 204) {
                        if($('.after_login').length == 0) {
                            location.replace(location.pathname);
                        }else{
                            location.replace($('.after_login').attr('href'));
                        }
                    }
                    if (e.status == 401) {
                        var error = "<ul><span class=\"close-errors\">X</span><li>" + e.responseJSON.error + "</li></ul>";
                        current_form.find('.errors-form').html(error).show();
                    }

                    if (e.status == 422) {
                        var error = '';
                        for (var prop in e.responseJSON.errors) {
                            error += "<li>" + prop + ": " + e.responseJSON.errors[prop].join(', ') + " </li>";
                        }
                        if (action == 'sign_up') {
                            current_form.find('.errors-form').html("<ul><span class=\"close-errors sign-up\">X</span>" + error + "</ul>").show();
                        } else if (action == 'sign_in') {
                            current_form.find('.errors-form').html("<ul><span class=\"close-errors\">X</span>" + error + "</ul>").show();
                        }

                    }
                }else if(action == 'sign_up') {
                    console.log(e.responseJSON);
                    if (e.responseJSON.status == 204) {
                        location.replace(location.pathname);
                    }
                    if (e.responseJSON.status == 401 || e.responseJSON.status == 403) {
                        current_form.find('.errors-form').html("<ul><span class=\"close-errors sign-up\">X</span>" + e.responseJSON.errors + "</ul>").show();
                    }
                }
            });
            return false;
        }else{
            return false;
        }
    });

    function isEmail(email) {
        var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        return regex.test(email);
    }

    //clear errors div
    $(document).on('click', '.close-errors', function(){
        var form = $(this).closest('.errors-form');
        form.empty().addClass('hidden');
    });

    $(document).on('click', '#paypal-authorization', function(){
        $('#sign-up-button').click();
    });
});
