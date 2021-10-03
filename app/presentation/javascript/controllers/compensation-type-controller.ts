import { Controller } from "@hotwired/stimulus";

const HIDDEN_CLASS = "d-none";

export default class extends Controller {
  static targets = ["minimumSalary", "maximumSalary", "hourly"];

  declare minimumSalaryTarget: HTMLElement;
  declare maximumSalaryTarget: HTMLElement;
  declare hourlyTarget: HTMLElement;

  selectSalary(_event: Event) {
    this.toggleVisibility();
  }

  selectHourly(_event: Event) {
    this.toggleVisibility();
  }

  toggleVisibility(): void {
    this.minimumSalaryTarget.classList.toggle(HIDDEN_CLASS);
    this.maximumSalaryTarget.classList.toggle(HIDDEN_CLASS);
    this.hourlyTarget.classList.toggle(HIDDEN_CLASS);
  }
}
