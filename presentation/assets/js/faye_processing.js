var channel = "#{processing.ws_channel_id}";
var ws_host = // TODO  "processing.ws_host"
var client = new Faye.Client(ws_host + "/faye");
var bar = document.getElementsByClassName("progress-bar")[0];
var reg = /\:(\d+)%/
client.subscribe('/' + channel, function(message) {
  // Collect progressbar element and percentage
    var progress = bar.getAttribute("style")
    var currentProgress = reg.exec(progress)[1]
    if (isNaN(message)) {
        bar.setAttribute("style", "width:100%")
        bar.setAttribute("class", "progress-bar progress-bar-danger progress-bar-striped")
        bar.innerHTML = message
    } else {
        if (parseInt(message) > parseInt(currentProgress)) {
            // Set the progress bar and percentage
            bar.setAttribute("aria-valuenow", message)
            bar.setAttribute("style", "width:"+message+"%")
            bar.innerHTML = message+"%"

            // Reoad page at 100%
            if (message == "100") {
                setTimeout(function () {
                    window.location = window.location.href.split('?')[0]
                }, 1000);
            }
        }
    }
    });