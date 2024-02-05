import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    console.log("Star Rating Controller connected");
    this.highlightStars();
  }

  highlightStars() {
    const rating = this.inputTarget.value;
    console.log("Current Rating:", rating);

    this.element.querySelectorAll(".star").forEach((star, index) => {
      star.classList.toggle("text-yellow-500", index < rating);
    });
  }

  setRating(event) {
    const rating = event.currentTarget.dataset.starRatingValue;
    console.log("Setting Rating:", rating);

    this.inputTarget.value = rating;
    this.highlightStars();
  }
}
