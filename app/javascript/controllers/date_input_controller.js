import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    var dateField = this.element;

    dateField.addEventListener('change', (event) => {
      document.querySelector('#date-form').submit();
    });
  }
}
