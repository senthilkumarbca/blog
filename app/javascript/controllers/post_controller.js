import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post"
export default class extends Controller {
  connect() {
    console.log("connected senthil");
  }
  initialize(){
    this.element.setAttribute("data-action", "click->post#showPost");
  }
  showPost(event){
    event.preventDefault()
    this.url = this.element.getAttribute("href")
    console.log(this.url)
    fetch(this.url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
        .then(response => response.text())
        .then(html => Turbo.renderStreamMessage(html))
  }
}
