const HIDDEN_CLASS = "d-none";

//content divs
const CONTACT_METHOD_EMAIL_ID = "job_listing_contact_email";
const CONTACT_METHOD_URL_ID = "job_listing_contact_url";

//radio buttons
const CONTACT_METHOD_URL_RADIO_ID = "contact_method_url";
const CONTACT_METHOD_EMAIL_RADIO_ID = "contact_method_email";

export function setupContactInfoClickHandlers(): void {
  document.addEventListener("change", (event) => {
    const target = event.target;
    if (!(target instanceof HTMLElement)) {
      return;
    }

    if (target.id == CONTACT_METHOD_EMAIL_RADIO_ID) {
      showEmailInput();
    } else if (target.id == CONTACT_METHOD_URL_RADIO_ID) {
      showUrlInput();
    }
  });
}

export function initContactMethodVisibility(): void {
  const emailInput = getEmailInput();

  emailInput.checked ? showEmailInput() : showUrlInput();
}

function showEmailInput(): void {
  const emailInput = getEmailInput();
  const urlInput = getUrlInput();

  emailInput.classList.remove(HIDDEN_CLASS);
  urlInput.classList.add(HIDDEN_CLASS);
}

function showUrlInput(): void {
  const emailInput = getEmailInput();
  const urlInput = getUrlInput();

  emailInput.classList.add(HIDDEN_CLASS);
  urlInput.classList.remove(HIDDEN_CLASS);
}

function getEmailInput(): HTMLInputElement {
  const input = document.getElementById(CONTACT_METHOD_EMAIL_ID);
  if (!(input instanceof HTMLInputElement)) {
    throw "Could not find contact email input";
  }

  return input;
}

function getUrlInput(): HTMLInputElement {
  const input = document.getElementById(CONTACT_METHOD_URL_ID);
  if (!(input instanceof HTMLInputElement)) {
    throw "Could not find contact url text area";
  }

  return input;
}
