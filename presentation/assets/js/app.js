$(document).ready(function() {

    $(".btn-upload-file").on('click',function() {
        $('.form-control-file').click()
    });

    $('.btn-camera').on('click', function(){
        
    });

    $('#camera').on('change',function(e){
        var file = e.target.  files[0]; 
        // Do something with the image file.
        $('#frame').src(URL.createObjectURL(file));
    });

    $('#cameraInput').on('change', function(e){
        $data = e.originalEvent.target.files[0];
         $reader = new FileReader();
         reader.onload = function(evt){
         $('#your_img_id').attr('src',evt.target.result);
         reader.readAsDataUrl($data);
    }});

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
                $(".translations").html(data);
                labels = $('.translations .translation-label').map(function() {
                    return $(this).text();
                }).get();
                getAdditionalImages(labels)
            },
            error: function(data, status, errorThrown){
                console.log("Request");
                console.log(data);
                console.log("Status");
                console.log(status);
                console.log("Error Thrown: ");
                console.log(errorThrown);
            }
        });
    });

    function fayeProcessing(wshost, wschannelid) {
        var channel = wschannelid;
        var ws_host = wshost;
        var run_script = ws_host + "/faye.js"
        $.getScript(run_script).done(function(){
            var client = new Faye.Client(ws_host + "/faye");
            var bar = $(".progress-bar");
            var reg = /\:(\d+)%/
            client.subscribe('/' + channel, function(message) {
            // Collect progressbar element and percentage
                var currentProgress = $(".progress-bar").first().attr("aria-valuenow");
                if (isNaN(message)) {
                    alert("Received something different from a number check console;");
                    console.log(message)
                    bar.attr("aria-valuenow", 100);
                    bar.css("width","100%");
                    bar.text("100%");
                } else {
                    if (parseInt(message) > parseInt(currentProgress)) {
                        // Set the progress bar and percentage
                        bar.attr("aria-valuenow", message);
                        bar.css("width",message+"%");
                        bar.text(message+"%");
                        // Reoad page at 100%
                        if (message == "100") {
                            setTimeout(function () {
                                alert("Reached a 100%");
                                //window.location = window.location.href.split('?')[0]
                            }, 1000);
                        }
                    }
                }
                });
        });
        
    }

    function getAdditionalImages(labels) {
        $.ajax({
            type: 'GET',
            url: '/additional_images',
            data: { labels: labels },
            dataType: 'html',
            cache: false,
            success: function(data, status) {
                console.log("Received DATA");
                console.log(data);
                $(".additional-images").html(data);
                if( $(data).find(".progress")) {
                    wshost = $(data).data("wshost");
                    wschannelid = $(data).data("wschannelid")
                    fayeProcessing(wshost, wschannelid);
                }
                console.log("Status");
                console.log(status);
            },
            error: function(data, status, errorThrown){
                console.log("Request");
                console.log(data);
                console.log("Status");
                console.log(status);
                console.log("Error Thrown");
                console.log(errorThrown);
            }
        });
    }

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