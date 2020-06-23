import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const subdomain  = window.location.host.split('.')[0];
  consumer.subscriptions.create({ channel: "LivestreamChannel", room_id: subdomain }, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log('Connected to channel')
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      let video = document.getElementById('video');
      if (data.video && video) {
        $('#no-live-stream').hide();
        video.poster = data.poster;
        let videoSrc = data.video;
        if (Hls.isSupported()) {
          var hls = new Hls();
          hls.loadSource(videoSrc);
          hls.attachMedia(video);
          hls.on(Hls.Events.MANIFEST_PARSED, function() {
            // video.play();
          });
        } else if (video.canPlayType('application/vnd.apple.mpegurl')) {
          video.src = videoSrc;
          video.addEventListener('loadedmetadata', function() {
            video.play();
          });
        }
      } else if(video) {
        $('#no-live-stream').show();
        video.removeAttribute('poster');
        video.removeAttribute('src');
      }
    }
  });
})
