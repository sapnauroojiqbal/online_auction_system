
import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    this.form = this.element.querySelector('form');
  }

  handleSuccess(event) {
    const [_, xhr] = event.detail;
    const productsContainer = document.getElementById('products');

    Turbo.renderStreamMessage(xhr.response, productsContainer);
    this.form.reset();
  }
}
