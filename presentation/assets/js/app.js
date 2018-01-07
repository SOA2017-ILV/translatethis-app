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
                    if(message['additional_images']){
                        console.log(message);
                        message['additional_images'].forEach(function(element){
                            console.log(element);
                            var label = element["label"];
                            var image_1 = element["links"][0];
                            var image_2 = element["links"][1];
                            var image_3 = element["links"][2];
                            var panel = $(".translations .panel[data-label='"+label+"']");
                            $(panel).find(".img-group .first").attr("src",image_1);
                            $(panel).find(".img-group .second").attr("src",image_2);
                            $(panel).find(".img-group .third").attr("src",image_3);
                            $(panel).find("h4").removeClass("hidden");
                            $(panel).find(".img-group").removeClass("hidden");
                            $(panel).find(".additional-images .progress").addClass("hidden");
                            alert("FINISHED");
                        });
                    }
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
                            bar.text("Getting Additional Images Now");
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
                console.log(data);
                $(".additional-images").append(data);
                if( $(data).find(".progress")) {
                    wshost = $(data).data("wshost");
                    wschannelid = $(data).data("wschannelid")
                    fayeProcessing(wshost, wschannelid);
                }
            },
            error: function(data, status, errorThrown){
                console.log("Request");
                console.log(data);
                console.log("Status");
                console.log(status);
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