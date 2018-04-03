function handle_menu(id)
{
    $('#ul_'+id).on('click', function(){

        eraseAllCookies();
        if(readCookie(id+'_menu')){
            eraseCookie(id+'_menu');
        }
        else
        {
            createCookie(id+'_menu', true, 7);
        }
    });

    if(readCookie(id+'_menu'))
    {
        $('#'+id+'_menu').addClass('display_block');
    }

}
function eraseAllCookies()
{
    eraseCookie('profile_menu');
    eraseCookie('case_menu');
    eraseCookie('medial_history_menu');
    eraseCookie('occupation_history_menu');
    eraseCookie('socio_history_menu');
    eraseCookie('military_history_menu');
}

function createCookie(name,value,days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}

function initDataTable(table_id)
{
    $('#'+table_id).DataTable({
        display: [[0, 'desc']],
        "bDestroy": true,
        "sDom": "<'dt-toolbar'" +
        "<'col-sm-5 col-xs-8'f>" + //search box
        "<'col-sm-4 col-sm-offset-2 col-xs-2 'C>"+// drop down column hide
        "<'col-sm-1 col-xs-2 'l>>"+// length
        "t"+ // the table
        "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
        "iDisplayLength": 10

    });
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name,"",-1);
}

/*
 * CHAT
 */

$.filter_input = $('#filter-chat-list');
$.chat_users_container = $('#chat-container > .chat-list-body')
$.chat_users = $('#chat-users')
$.chat_list_btn = $('#chat-container > .chat-list-open-close');
$.chat_body = $('#chat-body');

/*
 * LIST FILTER (CHAT)
 */

// custom css expression for a case-insensitive contains()
jQuery.expr[':'].Contains = function(a, i, m) {
    return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
};
var named_function = function(){
    var config = {
        toolbar:
            [
                ['Link', 'Unlink'],
                [ 'Save', '-', 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord',
                    '-', 'Undo', 'Redo' ],
                [ 'Bold', 'Italic', 'Underline',
                    '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
                '/',
                ['NumberedList', 'BulletedList', '-' , 'Outdent', 'Indent', '-', 'Blockquote'],
                ['Image', 'Table', 'HorizontalRule' , 'SpecialChar'],
                ['Styles', 'Format']
            ]
    };
    $('.ck-editor').ckeditor(config);

    $('a').attr('data-turbolinks', "false");
    // initialize persistent state
    $('.date_picker').datepicker({
        dateFormat: 'yy-mm-dd',
        "prevText":'<i class="fa fa-chevron-left"></i>',
        "nextText":'<i class="fa fa-chevron-right"></i>'
    });

    $( "select").css('width', '100%')
    $( "select").css('padding', '0')
    $( "select" ).select2({
        theme: "bootstrap"
    });
    $( "label select" ).select2("destroy");
    $( ".fb-select.form-group select" ).select2("destroy");
    $('.clockpicker').datetimepicker({format: 'LT'});
    $('.datetimepicker').datetimepicker({
        format: 'YYYY-MM-DD LT'
    });

    handle_menu('admin');
    handle_menu('case');
    handle_menu('profile');
    handle_menu('medical_history');
    handle_menu('occupation_history');
    handle_menu('military_history');
    handle_menu('socio_history');


    $(".user_autocomplete").autocomplete({
        //source: availableTags

        source: function (request, response) {
            $.ajax({
                url: "/users.json?q="+ request.term,
                dataType: "json",
                success: function (data) {
                    d = data;
                    res = [];
                    for (i = 0; i < d.length; i++) {
                        value = d[i]['login'];
                        res.push({label: value, value: value, id: d[i]['id']})
                    }
                    response(res)
                }
            });
        },
        minLength: 2,
        select: function (event, ui) {
            $(this).next().val(ui.item.id)
            $(this).next().next().val('User')
        }
    });
    console.log("It works on each visit!")
};

$( document ).on('turbolinks:load', named_function);