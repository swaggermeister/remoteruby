const HIDDEN_CLASS = "d-none";

//content divs
const COMPENSATION_TYPE_MINIMUM_SALARY_ID = "job_listing_minimum_salary";
const COMPENSATION_TYPE_MAXIMUM_SALARY_ID = "job_listing_maximum_salary";
const COMPENSATION_TYPE_HOURLY_ID = "job_listing_salary";

//radio buttons
const COMPENSATION_TYPE_SALARY_RADIO_ID = "compensation_type_salary";
const COMPENSATION_TYPE_HOURLY_RADIO_ID = "compensation_type_hourly";

export function setupCompensationTypeClickHandlers(): void {
  document.addEventListener("change", (event) => {
    const target = event.target;
    if (!(target instanceof HTMLElement)) {
      return;
    }

    if (target.id == COMPENSATION_TYPE_SALARY_RADIO_ID) {
      showSalaryRangeInput();
    } else if (target.id == COMPENSATION_TYPE_HOURLY_RADIO_ID) {
      showHourlyAmountInput();
    }
  });
}

export function initCompensationTypeVisibility(): void {
  const hourlyAmountInput = getHourlyAmountInput();

  hourlyAmountInput.value != ""
    ? showHourlyAmountInput()
    : showSalaryRangeInput();
}

function showSalaryRangeInput(): void {
  const minimumSalaryRangeInput = getMinimumSalaryRangeInput();
  const maximumSalaryRangeInput = getMaximumSalaryRangeInput();
  const hourlyAmountInput = getHourlyAmountInput();

  minimumSalaryRangeInput.classList.remove(HIDDEN_CLASS);
  maximumSalaryRangeInput.classList.remove(HIDDEN_CLASS);
  hourlyAmountInput.classList.add(HIDDEN_CLASS);
  hourlyAmountInput.value = "";
}

function showHourlyAmountInput(): void {
  const minimumSalaryRangeInput = getMinimumSalaryRangeInput();
  const maximumSalaryRangeInput = getMaximumSalaryRangeInput();
  const hourlyAmountInput = getHourlyAmountInput();

  minimumSalaryRangeInput.classList.add(HIDDEN_CLASS);
  maximumSalaryRangeInput.classList.add(HIDDEN_CLASS);
  hourlyAmountInput.classList.remove(HIDDEN_CLASS);
  minimumSalaryRangeInput.value = "";
  maximumSalaryRangeInput.value = "";
}

function getMinimumSalaryRangeInput(): HTMLInputElement {
  const input = document.getElementById(COMPENSATION_TYPE_MINIMUM_SALARY_ID);
  if (!(input instanceof HTMLInputElement)) {
    throw "Could not find minimum salary range input";
  }

  return input;
}

function getMaximumSalaryRangeInput(): HTMLInputElement {
  const input = document.getElementById(COMPENSATION_TYPE_MAXIMUM_SALARY_ID);
  if (!(input instanceof HTMLInputElement)) {
    throw "Could not find maximum salary range input";
  }

  return input;
}

function getHourlyAmountInput(): HTMLInputElement {
  const input = document.getElementById(COMPENSATION_TYPE_HOURLY_ID);
  if (!(input instanceof HTMLInputElement)) {
    throw "Could not find hourly amount text area";
  }

  return input;
}
