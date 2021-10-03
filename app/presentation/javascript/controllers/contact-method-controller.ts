import { Controller } from "@hotwired/stimulus";

const HIDDEN_CLASS = "d-none";

export default class extends Controller {
  static targets = ["email", "url"];

  declare emailTarget: HTMLElement;
  declare urlTarget: HTMLElement;

  selectEmail(_event: Event) {
    this.toggleVisibility();
  }

  selectUrl(_event: Event) {
    this.toggleVisibility();
  }

  toggleVisibility(): void {
    this.urlTarget.classList.toggle(HIDDEN_CLASS);
    this.emailTarget.classList.toggle(HIDDEN_CLASS);
  }
}
