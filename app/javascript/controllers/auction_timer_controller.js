import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["countdown"];

  connect() {
    console.log("Connected to countdown controller");
    console.log("Seconds Until End:", this.secondsUntilEnd);

    this.secondsUntilEnd = this.auctionTimerTarget.dataset.secondsUntilEndValue;

    const now = new Date().getTime();
    this.endTime = new Date(now + this.secondsUntilEnd * 1000);

    this.countdown = setInterval(this.countdown.bind(this), 250);
  }

  countdown() {
    const now = new Date();
    const secondsRemaining = (this.endTime - now) / 1000;

    if (secondsRemaining <= 0) {
      clearInterval(this.countdown);
      this.auctionTimerTarget.innerHTML = "Countdown is over!";
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

    this.auctionTimerTarget.innerHTML = `${days} days, ${hours} hours, ${minutes} minutes, ${seconds} seconds`;
  }
  // connect() {
  //   this.endTime = new Date(this.data.get("end-time")).getTime();
  //   this.updateTimer();
  //   this.timerInterval = setInterval(() => this.updateTimer(), 1000);
  // }

  // disconnect() {
  //   clearInterval(this.timerInterval);
  // }

  // updateTimer() {
  //   const now = new Date().getTime();
  //   const timeDifference = this.endTime - now;

  //   if (timeDifference > 0) {
  //     const days = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
  //     const hours = Math.floor(
  //       (timeDifference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
  //     );
  //     const minutes = Math.floor(
  //       (timeDifference % (1000 * 60 * 60)) / (1000 * 60)
  //     );
  //     const seconds = Math.floor((timeDifference % (1000 * 60)) / 1000);

  //     this.element.innerHTML = `${days}d ${hours}h ${minutes}m ${seconds}s`;
  //   } else {
  //     this.element.innerHTML = "Auction Ended";
  //     clearInterval(this.timerInterval);
  //   }
  // }
}
