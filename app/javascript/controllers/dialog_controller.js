import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    this.modalTarget.addEventListener("close", this.enableBodyScroll.bind(this))
    this.modalTarget.addEventListener("closeReview", this.enableBodyScroll.bind(this))
  }

  disconnect() {
    this.modalTarget.removeEventListener("close", this.enableBodyScroll.bind(this))
    this.modalTarget.removeEventListener("closeReview", this.enableBodyScroll.bind(this))
  }

  open() {
    this.modalTarget.showModal()
    document.body.classList.add('overflow-hidden')
  }

  close() {
    this.modalTarget.close()
  }

  openReview() {
    this.modalTarget.showModal()
    document.body.classList.add('overflow-hidden')
  }

  closeReview() {
    this.modalTarget.close()
  }

  enableBodyScroll() {
    document.body.classList.remove('overflow-hidden')
  }

  clickOutside(event) {
    if (event.target === this.modalTarget) {
      this.close()
    }
  }
}
