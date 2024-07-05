import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static  targets= ["modal", "notice", "link"]

  open() {
    this.modalTarget.showModal()
    if(Window.scroll){
    Window.scroll = false;
    }
 } 
closeModal() {
    this.modalTarget.close()
  }
  copyLink(){
    navigator.clipboard.writeText(this.linkTarget.href)
  }

}
