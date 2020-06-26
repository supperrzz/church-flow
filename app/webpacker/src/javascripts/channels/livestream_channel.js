import consumer from "./consumer"

window.addEventListener('load', () => {
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
      console.log('Data', data);
      // Called when there's incoming data on the websocket for this channel
      let video = document.getElementById('video');
      let heading = document.getElementById('no-live-stream');
      let embedContainer = document.getElementById('embed-code-container');
      if (data.video && video) {
        heading.hidden = true;
        if(embedContainer) {
          embedContainer.innerHTML = data.html_embed;
        }
        let playerInstance = jwplayer('video');
        playerInstance.setup({
          file: data.video,
          image: data.poster,
          controls: true
        })
      } else if(video) {
        heading.hidden = false;
        let playerInstance = jwplayer('video');
        playerInstance.remove();
        if(embedContainer) {
          embedContainer.innerHTML = '';
        }
      }
    }
  });
})
