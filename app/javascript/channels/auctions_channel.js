import consumer from "channels/consumer"

consumer.subscriptions.create("AuctionsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const auctionElement = document.getElementById(`auction_${data.auction_id}`);
    if (auctionElement) {
      auctionElement.innerText = `Auction Status: ${data.status}`;
    }
  }
});
