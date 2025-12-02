import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

class DialogController extends Controller {
  connect() {
    console.log('dialog controller ' + this.element.id)
    const modal = new bootstrap.Modal(this.element)
    modal.show()
  }
}

export default DialogController