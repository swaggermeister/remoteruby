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
  static targets = [
    "writeTextArea",
    "preview",
    "emptyPreview",
    "writeTab",
    "previewTab",
  ];

  // Tabs
  declare writeTabTarget: HTMLElement;
  declare previewTabTarget: HTMLElement;

  // Text area where you write the description
  declare writeTextAreaTarget: HTMLElement;

  // Preview of the description markdown
  declare previewTarget: HTMLElement;
  declare emptyPreviewTarget: HTMLElement;

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

  togglePreview(): void {
    if (this.writeTextAreaTarget.classList.contains(HIDDEN_CLASS)) {
      // Hide the preview
      this.emptyPreviewTarget.classList.add(HIDDEN_CLASS);
      this.previewTarget.classList.add(HIDDEN_CLASS);

      // Show the text area
      this.writeTextAreaTarget.classList.remove(HIDDEN_CLASS);
    } else {
      this.writeTextAreaTarget.classList.add(HIDDEN_CLASS);

      if (this.descriptionIsBlank()) {
        // No description text so show the empty hero
        this.emptyPreviewTarget.classList.remove(HIDDEN_CLASS);
        this.previewTarget.classList.add(HIDDEN_CLASS);
      } else {
        // Has description text so show the preview
        this.setPreviewPaneContents();
        this.emptyPreviewTarget.classList.add(HIDDEN_CLASS);
        this.previewTarget.classList.remove(HIDDEN_CLASS);
      }
    }
  }

  setPreviewPaneContents(): void {
    const html = marked(this.descriptionText());

    this.previewTarget.innerHTML = html;
  }

  descriptionIsBlank(): boolean {
    return this.descriptionText() == "";
  }

  descriptionText(): string {
    if (!(this.writeTextAreaTarget instanceof HTMLTextAreaElement)) {
      throw new Error("Could not find the text area for the description");
    }

    return this.writeTextAreaTarget.value.trim();
  }
}
