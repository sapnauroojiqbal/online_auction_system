import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["countdown"];

  connect() {
    console.log("Connected to countdown controller");

    this.timeToStartAuction = this.countdownTarget.dataset.auctionStartTime;
    this.secondsUntilEnd = this.countdownTarget.dataset.auctionEndTime;

    const now = new Date().getTime();
    this.endTime = new Date(now + this.secondsUntilEnd * 1000);
    this.startTime = new Date(this.timeToStartAuction * 1000);

    this.countdown = setInterval(this.countdown.bind(this), 250);
    this.checkAndUpdateAuctionStatus();
  }

  countdown() {
    const now = new Date();
    const secondsRemaining = (this.endTime - now) / 1000;

    if (secondsRemaining <= 0) {
      clearInterval(this.countdown);
      this.countdownTarget.innerHTML = "Auction Ended!";
      this.updateAuctionStatus("ended");
      return;
    }

    const secondsPerDay = 86400;
    const secondsPerHour = 3600;
    const secondsPerMinute = 60;

    const days = Math.floor(secondsRemaining / secondsPerDay);
    const hours = Math.floor(
      (secondsRemaining % secondsPerDay) / secondsPerHour
    );
    const minutes = Math.floor(
      (secondsRemaining % secondsPerHour) / secondsPerMinute
    );
    const seconds = Math.floor(secondsRemaining % secondsPerMinute);

    this.countdownTarget.innerHTML = `${days} days, ${hours} hours, ${minutes} minutes, ${seconds} seconds`;

    if (now >= this.startTime && now < this.endTime) {
      this.updateAuctionStatus("live");
    }
  }

  async updateAuctionStatus(status) {
    const auctionId = this.countdownTarget.dataset.auctionId;

    try {
      const response = await fetch(`/auctions/${auctionId}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        },
        body: JSON.stringify({ status }),
      });

      if (!response.ok) {
        console.log(response)
        throw new Error("Failed to update auction status");
      }
    } catch (error) {
      console.error(error.message);
    }
  }

  async checkAndUpdateAuctionStatus() {
    const now = new Date().getTime();
    const auctionId = this.countdownTarget.dataset.auctionId;

    if (now >= this.startTime && now < this.endTime) {
      await this.updateAuctionStatus("live");
    } else if (now >= this.endTime) {
      await this.updateAuctionStatus("ended");
    }
  }
}
