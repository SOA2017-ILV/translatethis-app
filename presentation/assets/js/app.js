$(document).ready(function() {
    $(".btn-upload-file").on('click',function() {
        $('.form-control-file').click()
    });

    $(".form-control-file").on('change', function(){
        showInputImage(this);
        
    });

    $("#translate-form").submit(function(e){
        e.preventDefault();
        var img_file = $('.form-control-file')[0].files[0];
        var selected_language = $("select.form-element").val();
        var form_data = new FormData();
        form_data.append('img',img_file);
        form_data.append('target_lang', selected_language);
        $.ajax({
            type: 'POST',
            url: '/translate',
            data: form_data,
            dataType: 'html',
            contentType: false,
            processData: false,
            cache: false,
            success: function(data,status){
                console.log(data);
                $(".translations").html(data);
            }
        });
    });

    function showInputImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            var fileType = input.files[0]["type"];
            var ValidImageTypes = ["image/gif", "image/jpeg", "image/png"];
            reader.onload = function(e) {
                if ($.inArray(fileType, ValidImageTypes) > 0) {
                    $('.img-thumbnail').attr('src', e.target.result);
                    $('.img-thumbnail').removeClass('hidden');
                    $("button.submit").removeClass('hidden');
                } else {
                    //TODO: Call a flash message to input File is not image maybe?
                    $('.img-thumbnail').addClass('hidden');
                    $('button.submit').addClass('hidden');
                }
              
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
});