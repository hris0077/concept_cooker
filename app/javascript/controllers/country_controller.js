import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"



class CountryController extends Controller {
  static targets = ['stateSelect']

  change(event) {
    
    let country = event.target.selectedOptions[0].value
    let target = this.stateSelectTarget.id

    get(`/addresses/states?country=${country}&target=${target}`, {
      responseKind: "turbo-stream"
    })
  }
}

export default CountryController