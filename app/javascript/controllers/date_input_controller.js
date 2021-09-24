import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form" ]

  handleChange() {
    this.formTarget.submit();
  }
}
