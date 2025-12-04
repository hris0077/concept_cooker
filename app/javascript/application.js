// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import "@rails/request.js"


Turbo.StreamActions.close_frame_dialog = function() {
  console.log('Application listen for closing window')
  const modalElement = this.targetElements[0].closest(".modal")
  if (modalElement) {
    const modal = bootstrap.Modal.getInstance(modalElement)
    if (modal) {
      modal.hide()
      modalElement.remove()
    }
  }
}
