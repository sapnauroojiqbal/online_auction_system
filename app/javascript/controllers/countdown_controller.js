// app/javascript/controllers/countdown_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["countdown"];

  connect() {
    console.log("Connected to countdown controller");

  //   const now = new Date().getTime();
  //   const startTime = this.countdownTarget.dataset.auctionEndTime;
  //   const endTime = this.countdownTarget.dataset.auctionEndTime;

  //   console.log("startTime:", startTime);
  //   console.log("endTime:", endTime);

  //   if (now < startTime) {
  //     // Auction not started yet
  //     this.secondsUntilEnd = Math.floor((startTime - now) / 1000);
  //     this.countdownTarget.innerHTML = `Auction not started yet! Will start in ${this.formatTime(this.secondsUntilEnd)}.`;
  //   } else if (now > endTime) {
  //     console.log(now, startTime, endTime);
  //     // Auction ended
  //     this.countdownTarget.innerHTML = "Auction ended!";
  //   } else {
  //     // Auction ongoing
  //     this.secondsUntilEnd = Math.floor((endTime - now) / 1000);
  //     this.countdown = setInterval(this.countdown.bind(this), 250);
  //   }
  // }

  // countdown() {
  //   const now = new Date();
  //   const secondsRemaining = (now.getTime() + this.secondsUntilEnd * 1000 - now.getTime()) / 1000;

  //   if (secondsRemaining <= 0) {
  //     clearInterval(this.countdown);
  //     this.countdownTarget.innerHTML = "Countdown is over!";
  //     return;
  //   }

  //   const secondsPerDay = 86400;
  //   const secondsPerHour = 3600;
  //   const secondsPerMinute = 60;

  //   const days = Math.floor(secondsRemaining / secondsPerDay);
  //   const hours = Math.floor((secondsRemaining % secondsPerDay) / secondsPerHour);
  //   const minutes = Math.floor((secondsRemaining % secondsPerHour) / secondsPerMinute);
  //   const seconds = Math.floor(secondsRemaining % secondsPerMinute);

  //   this.countdownTarget.innerHTML = `${days} days, ${hours} hours, ${minutes} minutes, ${seconds} seconds`;
  // }

  // formatTime(seconds) {
  //   const secondsPerHour = 3600;
  //   const secondsPerMinute = 60;

  //   const hours = Math.floor(seconds / secondsPerHour);
  //   const remainingMinutes = Math.floor((seconds % secondsPerHour) / secondsPerMinute);
  //   const remainingSeconds = Math.floor(seconds % secondsPerMinute);

  //   return `${hours} hours, ${remainingMinutes} minutes, ${remainingSeconds} seconds`;
  // }
  console.log("Connected to countdown controller");

    this.secondsUntilEnd = this.countdownTarget.dataset.auctionEndTime;

    const now = new Date().getTime();
    this.endTime = new Date(now + this.secondsUntilEnd * 1000);

    this.countdown = setInterval(this.countdown.bind(this), 250);
  }

  countdown() {
    const now = new Date();
    const secondsRemaining = (this.endTime - now) / 1000;

    if (secondsRemaining <= 0) {
      clearInterval(this.countdown);
      this.countdownTarget.innerHTML = "Auction is over!";
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
  }
}
