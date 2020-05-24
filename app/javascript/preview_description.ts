import marked from "marked";

// classes
const HIDDEN_CLASS = "d-none";
const ACTIVE_CLASS = "active";

// tabs
const PREVIEW_TAB_ID = "preview-description-tab";
const WRITE_TAB_ID = "write-description-tab";

// content
const WRITE_TEXTAREA_ID = "write-description";
const PREVIEW_DIV_ID = "preview-description";

export function setupClickHandlers(): void {
  document.addEventListener("click", (event) => {
    const target = event.target;

    if (!(target instanceof HTMLElement)) {
      return;
    }

    if (target.id == PREVIEW_TAB_ID) {
      showPreview();
      event.preventDefault();
    } else if (target.id == WRITE_TAB_ID) {
      showWrite();
      event.preventDefault();
    }
  });
}

function showPreview(): void {
  const previewTab = getPreviewTab();
  if (previewTab.classList.contains(ACTIVE_CLASS)) {
    return;
  }

  toggleTabs();
  togglePreview();
}

function showWrite(): void {
  const writeTab = getWriteTab();
  if (writeTab.classList.contains(ACTIVE_CLASS)) {
    return;
  }

  toggleTabs();
  togglePreview();
}

function toggleTabs(): void {
  const previewTab = getPreviewTab();
  const writeTab = getWriteTab();
  if (writeTab.classList.contains(ACTIVE_CLASS)) {
    writeTab.classList.remove(ACTIVE_CLASS);
    previewTab.classList.add(ACTIVE_CLASS);
  } else {
    writeTab.classList.add(ACTIVE_CLASS);
    previewTab.classList.remove(ACTIVE_CLASS);
  }
}

function togglePreview(): void {
  const descriptionTextarea = getWriteTextArea();
  const previewPane = getPreviewPane();

  if (descriptionTextarea.classList.contains(HIDDEN_CLASS)) {
    previewPane.classList.add(HIDDEN_CLASS);
    descriptionTextarea.classList.remove(HIDDEN_CLASS);
  } else {
    descriptionTextarea.classList.add(HIDDEN_CLASS);
    previewPane.classList.remove(HIDDEN_CLASS);
    setPreviewPaneContents();
  }
}

function setPreviewPaneContents(): void {
  const previewPane = getPreviewPane();
  const descriptionTextarea = getWriteTextArea();
  const description = descriptionTextarea.value;
  const html =
    description.trim() == ""
      ? "Nothing to preview"
      : marked(descriptionTextarea.value);

  previewPane.innerHTML = html;
}

function getWriteTextArea(): HTMLTextAreaElement {
  const textarea = document.getElementById(WRITE_TEXTAREA_ID);
  if (!(textarea instanceof HTMLTextAreaElement)) {
    throw "Could not find description text area";
  }

  return textarea;
}

function getPreviewPane(): HTMLElement {
  const previewPane = document.getElementById(PREVIEW_DIV_ID);
  if (!previewPane) {
    throw "Could not find preview pane element";
  }

  return previewPane;
}

function getWriteTab(): HTMLElement {
  const writeTab = document.getElementById(WRITE_TAB_ID);
  if (!writeTab) {
    throw "Could not find write tab element";
  }

  return writeTab;
}

function getPreviewTab(): HTMLElement {
  const previewTab = document.getElementById(PREVIEW_TAB_ID);
  if (!previewTab) {
    throw "Could not find preview tab element";
  }

  return previewTab;
}
