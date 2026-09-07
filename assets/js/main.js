/* =========================================================================
   Med Spa Revenue OS — progressive enhancement
   Nothing here is required to read the page; JS only adds interaction.
   ========================================================================= */
(function () {
  "use strict";

  /* ------------------------------------------------------------------
     Mobile navigation — button controls a disclosure panel.
     Keyboard: Enter/Space toggle (native button), Escape closes and
     returns focus to the trigger. Focus is never trapped off-screen.
     ------------------------------------------------------------------ */
  var navToggle = document.querySelector("[data-nav-toggle]");
  var navPanel = document.getElementById("nav-panel");

  function setNav(open) {
    if (!navToggle || !navPanel) return;
    navToggle.setAttribute("aria-expanded", String(open));
    navPanel.hidden = !open;
    navToggle.querySelector("[data-nav-label]").textContent = open ? "Close" : "Menu";
  }

  if (navToggle && navPanel) {
    setNav(false);
    navToggle.addEventListener("click", function () {
      setNav(navToggle.getAttribute("aria-expanded") !== "true");
    });
    navPanel.addEventListener("click", function (event) {
      if (event.target.closest("a")) setNav(false);
    });
    document.addEventListener("keydown", function (event) {
      if (event.key === "Escape" && navToggle.getAttribute("aria-expanded") === "true") {
        setNav(false);
        navToggle.focus();
      }
    });
    var desktop = window.matchMedia("(min-width: 60rem)");
    desktop.addEventListener("change", function (event) {
      if (event.matches) setNav(false);
    });
  }

  /* ------------------------------------------------------------------
     FAQ accordion — independent disclosures, multiple may be open.
     Keyboard: Enter/Space toggle; Up/Down move between triggers;
     Home/End jump to first/last.
     ------------------------------------------------------------------ */
  var triggers = Array.prototype.slice.call(document.querySelectorAll("[data-faq-trigger]"));

  triggers.forEach(function (trigger, index) {
    var panel = document.getElementById(trigger.getAttribute("aria-controls"));
    if (!panel) return;

    trigger.addEventListener("click", function () {
      var open = trigger.getAttribute("aria-expanded") === "true";
      trigger.setAttribute("aria-expanded", String(!open));
      panel.hidden = open;
    });

    trigger.addEventListener("keydown", function (event) {
      var next = null;
      if (event.key === "ArrowDown") next = triggers[(index + 1) % triggers.length];
      else if (event.key === "ArrowUp") next = triggers[(index - 1 + triggers.length) % triggers.length];
      else if (event.key === "Home") next = triggers[0];
      else if (event.key === "End") next = triggers[triggers.length - 1];
      if (next) { event.preventDefault(); next.focus(); }
    });
  });

  /* ------------------------------------------------------------------
     Revenue leak calculator.

     Model (matches the published figures):
       currentPatients  = leads * booking * show * close
       improvedPatients = leads * (booking*k) * (show*k) * (close*k)
       where k = 1 + improvement
     Revenue = patients * averageFirstTreatmentValue.
     Illustrative only — the copy says so, and so does the output.
     ------------------------------------------------------------------ */
  var calc = document.querySelector("[data-calc]");
  if (!calc) return;

  var inputs = {
    leads: calc.querySelector("#calc-leads"),
    booking: calc.querySelector("#calc-booking"),
    show: calc.querySelector("#calc-show"),
    close: calc.querySelector("#calc-close"),
    value: calc.querySelector("#calc-value"),
    lift: calc.querySelector("#calc-lift")
  };

  var outputs = {
    delta: calc.querySelector("[data-out-delta]"),
    currentPatients: calc.querySelector("[data-out-current-patients]"),
    improvedPatients: calc.querySelector("[data-out-improved-patients]"),
    currentRevenue: calc.querySelector("[data-out-current-revenue]"),
    improvedRevenue: calc.querySelector("[data-out-improved-revenue]")
  };

  var money = new Intl.NumberFormat("en-US", {
    style: "currency", currency: "USD", maximumFractionDigits: 0
  });
  var count = new Intl.NumberFormat("en-US");

  function readNumber(input) {
    var value = Number(input.value);
    var field = input.closest(".field");
    var min = Number(input.min);
    var max = Number(input.max);
    var valid = Number.isFinite(value) && value >= min && value <= max;
    if (field) field.setAttribute("data-invalid", String(!valid));
    return valid ? value : Math.min(Math.max(Number.isFinite(value) ? value : min, min), max);
  }

  function render() {
    var leads = readNumber(inputs.leads);
    var booking = readNumber(inputs.booking) / 100;
    var show = readNumber(inputs.show) / 100;
    var close = readNumber(inputs.close) / 100;
    var value = readNumber(inputs.value);
    var lift = readNumber(inputs.lift) / 100;

    var k = 1 + lift;
    // Rates are proportions: a lift can never push one past 100%.
    var current = leads * booking * show * close;
    var improved = leads
      * Math.min(booking * k, 1)
      * Math.min(show * k, 1)
      * Math.min(close * k, 1);

    var currentRevenue = current * value;
    var improvedRevenue = improved * value;

    // Live text mirrors of each slider value.
    calc.querySelectorAll("[data-mirror]").forEach(function (node) {
      var source = inputs[node.getAttribute("data-mirror")];
      var suffix = node.getAttribute("data-suffix") || "";
      var prefix = node.getAttribute("data-prefix") || "";
      node.textContent = prefix + count.format(Number(source.value)) + suffix;
    });

    outputs.delta.textContent = money.format(Math.max(improvedRevenue - currentRevenue, 0));
    outputs.currentPatients.textContent = count.format(Math.round(current));
    outputs.improvedPatients.textContent = count.format(Math.round(improved));
    outputs.currentRevenue.textContent = money.format(currentRevenue);
    outputs.improvedRevenue.textContent = money.format(improvedRevenue);
  }

  Object.keys(inputs).forEach(function (key) {
    inputs[key].addEventListener("input", render);
    inputs[key].addEventListener("change", render);
  });

  render();
})();
