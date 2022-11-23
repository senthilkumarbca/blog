import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user"
export default class extends Controller {
  connect() {
    console.log("connected...");
  }
  initialize() {
    this.element.setAttribute("data-action", "click->user#editUser")
  }
  editUser(event) {
    event.preventDefault();
    this.url = this.element.href;
    console.log(this.url);

    fetch(this.url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
        .then(response => response.text())
        .then(html => Turbo.renderStreamMessage(html))
  }
}
