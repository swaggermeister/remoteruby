// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// CSS
import "../../styles/application";

// JS polyfills
import "core-js/stable";
import "regenerator-runtime/runtime";

// Rails
require("@rails/ujs").start();
// Turbolinks
require("turbolinks").start();

// Stimulus
import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers";

declare global {
  interface Window {
    Stimulus: Application;
  }
}

window.Stimulus = Application.start();
const context = require.context("../controllers", true, /\.ts$/);
window.Stimulus.load(definitionsFromContext(context));

// Assets
require.context("../../images", true, /\.png$/);
require.context("../../images", true, /\.jpg$/);
require.context("../../images", true, /\.svg$/);
