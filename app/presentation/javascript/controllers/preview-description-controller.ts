import { Controller } from "@hotwired/stimulus";
import marked from "marked";
import { textChangeRangeIsUnchanged } from "typescript";

const HIDDEN_CLASS = "d-none";
const ACTIVE_CLASS = "active";

// tabs
const PREVIEW_TAB_ID = "preview-description-tab";
const WRITE_TAB_ID = "write-description-tab";

// content
const WRITE_TEXTAREA_ID = "write-description";
const PREVIEW_DIV_ID = "preview-description";

export default class extends Controller {
  static targets = ["writeTextArea", "preview", "writeTab", "previewTab"];

  // Tabs
  declare writeTabTarget: HTMLElement;
  declare previewTabTarget: HTMLElement;

  // Text area where you write the description
  declare writeTextAreaTarget: HTMLElement;

  // Preview of the description markdown
  declare previewTarget: HTMLElement;

  selectWrite(_event: Event) {
    this.showWrite();
    _event.preventDefault();
  }

  selectPreview(_event: Event) {
    this.showPreview();
    _event.preventDefault();
  }

  showPreview(): void {
    if (this.previewTabTarget.classList.contains(ACTIVE_CLASS)) {
      return;
    }

    this.toggleTabs();
    this.togglePreview();
  }

  showWrite(): void {
    if (this.writeTabTarget.classList.contains(ACTIVE_CLASS)) {
      return;
    }

    this.toggleTabs();
    this.togglePreview();
  }

  toggleTabs(): void {
    if (this.writeTabTarget.classList.contains(ACTIVE_CLASS)) {
      this.writeTabTarget.classList.remove(ACTIVE_CLASS);
      this.previewTabTarget.classList.add(ACTIVE_CLASS);
    } else {
      this.writeTabTarget.classList.add(ACTIVE_CLASS);
      this.previewTabTarget.classList.remove(ACTIVE_CLASS);
    }
  }

  toggleVisibility(): void {
    this.writeTextAreaTarget.classList.toggle(HIDDEN_CLASS);
    this.writeTextAreaTarget.classList.toggle(ACTIVE_CLASS);

    this.previewTarget.classList.toggle(HIDDEN_CLASS);
    this.previewTarget.classList.toggle(ACTIVE_CLASS);
  }

  togglePreview(): void {
    if (this.writeTextAreaTarget.classList.contains(HIDDEN_CLASS)) {
      this.previewTarget.classList.add(HIDDEN_CLASS);
      this.writeTextAreaTarget.classList.remove(HIDDEN_CLASS);
    } else {
      this.writeTextAreaTarget.classList.add(HIDDEN_CLASS);
      this.previewTarget.classList.remove(HIDDEN_CLASS);
      this.setPreviewPaneContents();
    }
  }

  setPreviewPaneContents(): void {
    if (!(this.writeTextAreaTarget instanceof HTMLTextAreaElement)) {
      throw new Error("Could not find the text area for the description");
    }

    const description = this.writeTextAreaTarget.value;
    const html =
      description.trim() == ""
        ? "Nothing to preview"
        : marked(this.writeTextAreaTarget.value);

    this.previewTarget.innerHTML = html;
  }
}
