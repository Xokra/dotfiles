-- ==========================================
-- PHASE 2: CSS COMPONENT LIBRARY SYSTEM
-- ==========================================
-- File: ~/.config/nvim/lua/css-components.lua

local M = {}

-- Helper function for keybindings (matching your existing style)
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- ==========================================
-- COLOR PALETTE SYSTEM
-- ==========================================
local color_palettes = {
  primary = {
    ["primary-50"] = "#eff6ff",
    ["primary-100"] = "#dbeafe", 
    ["primary-200"] = "#bfdbfe",
    ["primary-300"] = "#93c5fd",
    ["primary-400"] = "#60a5fa",
    ["primary-500"] = "#3b82f6",
    ["primary-600"] = "#2563eb",
    ["primary-700"] = "#1d4ed8",
    ["primary-800"] = "#1e40af",
    ["primary-900"] = "#1e3a8a"
  },
  
  neutral = {
    ["neutral-50"] = "#f9fafb",
    ["neutral-100"] = "#f3f4f6",
    ["neutral-200"] = "#e5e7eb",
    ["neutral-300"] = "#d1d5db",
    ["neutral-400"] = "#9ca3af",
    ["neutral-500"] = "#6b7280",
    ["neutral-600"] = "#4b5563",
    ["neutral-700"] = "#374151",
    ["neutral-800"] = "#1f2937",
    ["neutral-900"] = "#111827"
  },
  
  success = {

    ["success-50"] = "#ecfdf5",
    ["success-500"] = "#10b981",
    ["success-600"] = "#059669",
    ["success-700"] = "#047857"
  },
  
  warning = {
    ["warning-50"] = "#fffbeb",
    ["warning-500"] = "#f59e0b",
    ["warning-600"] = "#d97706",
    ["warning-700"] = "#b45309"
  },
  
  error = {
    ["error-50"] = "#fef2f2",
    ["error-500"] = "#ef4444",
    ["error-600"] = "#dc2626",
    ["error-700"] = "#b91c1c"
  }
}


-- ==========================================
-- CSS RESET & BASE STYLES
-- ==========================================
local css_reset = [[
/* CSS Reset & Base Styles */
*,
*::before,
*::after {
  box-sizing: border-box;

  margin: 0;

  padding: 0;
}

:root {
  /* Primary Colors */
  --primary-50: #eff6ff;
  --primary-100: #dbeafe;
  --primary-200: #bfdbfe;
  --primary-300: #93c5fd;
  --primary-400: #60a5fa;
  --primary-500: #3b82f6;
  --primary-600: #2563eb;
  --primary-700: #1d4ed8;
  --primary-800: #1e40af;
  --primary-900: #1e3a8a;


  /* Neutral Colors */
  --neutral-50: #f9fafb;
  --neutral-100: #f3f4f6;

  --neutral-200: #e5e7eb;
  --neutral-300: #d1d5db;
  --neutral-400: #9ca3af;
  --neutral-500: #6b7280;

  --neutral-600: #4b5563;
  --neutral-700: #374151;
  --neutral-800: #1f2937;
  --neutral-900: #111827;


  /* Semantic Colors */
  --success-50: #ecfdf5;
  --success-500: #10b981;
  --success-600: #059669;
  --success-700: #047857;


  --warning-50: #fffbeb;

  --warning-500: #f59e0b;
  --warning-600: #d97706;
  --warning-700: #b45309;

  --error-50: #fef2f2;

  --error-500: #ef4444;
  --error-600: #dc2626;

  --error-700: #b91c1c;

  /* Spacing Scale */
  --space-xs: 0.25rem;
  --space-sm: 0.5rem;
  --space-md: 1rem;
  --space-lg: 1.5rem;
  --space-xl: 2rem;
  --space-2xl: 3rem;
  --space-3xl: 4rem;

  /* Typography */
  --font-family-sans: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;

  --font-family-mono: 'SF Mono', Monaco, Inconsolata, 'Roboto Mono', monospace;

  /* Shadows */
  --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);

  /* Border Radius */
  --radius-sm: 0.25rem;
  --radius-md: 0.375rem;
  --radius-lg: 0.5rem;
  --radius-xl: 0.75rem;
  --radius-2xl: 1rem;


  /* Transitions */
  --transition-fast: 150ms ease-in-out;
  --transition-normal: 250ms ease-in-out;
  --transition-slow: 350ms ease-in-out;
}

html {
  line-height: 1.5;

  -webkit-text-size-adjust: 100%;
  font-family: var(--font-family-sans);
}


body {
  margin: 0;
  line-height: inherit;

  color: var(--neutral-800);
  background-color: var(--neutral-50);
}

img, picture, video, canvas, svg {
  display: block;
  max-width: 100%;

}


input, button, textarea, select {
  font: inherit;
}

p, h1, h2, h3, h4, h5, h6 {

  overflow-wrap: break-word;

}


/* Utility Classes */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);

  white-space: nowrap;
  border: 0;
}
]]

-- ==========================================
-- BUTTON COMPONENTS
-- ==========================================
local button_components = {
  primary = [[
/* Primary Button */
.btn-primary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.75rem 1.5rem;
  font-size: 0.875rem;
  font-weight: 600;
  line-height: 1.25rem;
  text-decoration: none;
  color: white;

  background-color: var(--primary-600);
  border: 1px solid var(--primary-600);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
  cursor: pointer;
  transition: all var(--transition-fast);
  user-select: none;
  white-space: nowrap;
}

.btn-primary:hover {
  background-color: var(--primary-700);
  border-color: var(--primary-700);
  box-shadow: var(--shadow-md);
}

.btn-primary:active {
  transform: translateY(1px);

  box-shadow: var(--shadow-sm);
}

.btn-primary:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  transform: none;
}
]],

  secondary = [[
/* Secondary Button */
.btn-secondary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.75rem 1.5rem;
  font-size: 0.875rem;
  font-weight: 600;

  line-height: 1.25rem;
  text-decoration: none;
  color: var(--neutral-700);
  background-color: var(--neutral-50);
  border: 1px solid var(--neutral-300);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
  cursor: pointer;
  transition: all var(--transition-fast);
  user-select: none;
  white-space: nowrap;
}

.btn-secondary:hover {
  background-color: var(--neutral-100);
  border-color: var(--neutral-400);
  box-shadow: var(--shadow-md);
}

.btn-secondary:active {

  transform: translateY(1px);
  box-shadow: var(--shadow-sm);
}
]],

  outline = [[

/* Outline Button */
.btn-outline {
  display: inline-flex;

  align-items: center;
  justify-content: center;

  padding: 0.75rem 1.5rem;
  font-size: 0.875rem;

  font-weight: 600;
  line-height: 1.25rem;
  text-decoration: none;
  color: var(--primary-600);
  background-color: transparent;
  border: 2px solid var(--primary-600);
  border-radius: var(--radius-md);
  cursor: pointer;
  transition: all var(--transition-fast);
  user-select: none;
  white-space: nowrap;

}


.btn-outline:hover {
  color: white;
  background-color: var(--primary-600);
}

.btn-outline:active {
  transform: translateY(1px);
}
]],

  ghost = [[
/* Ghost Button */
.btn-ghost {
  display: inline-flex;

  align-items: center;
  justify-content: center;
  padding: 0.75rem 1.5rem;
  font-size: 0.875rem;

  font-weight: 600;
  line-height: 1.25rem;
  text-decoration: none;
  color: var(--neutral-600);

  background-color: transparent;
  border: none;
  border-radius: var(--radius-md);
  cursor: pointer;
  transition: all var(--transition-fast);
  user-select: none;
  white-space: nowrap;
}

.btn-ghost:hover {
  color: var(--neutral-800);
  background-color: var(--neutral-100);
}

.btn-ghost:active {
  transform: translateY(1px);

}
]],

  sizes = [[
/* Button Sizes */
.btn-xs {
  padding: 0.25rem 0.75rem;
  font-size: 0.75rem;
  line-height: 1rem;
}


.btn-sm {
  padding: 0.5rem 1rem;
  font-size: 0.875rem;
  line-height: 1.25rem;

}


.btn-lg {
  padding: 1rem 2rem;
  font-size: 1rem;
  line-height: 1.5rem;
}

.btn-xl {
  padding: 1.25rem 2.5rem;
  font-size: 1.125rem;
  line-height: 1.75rem;
}

.btn-full {
  width: 100%;

  justify-content: center;
}
]]
}


-- ==========================================

-- FORM COMPONENTS
-- ==========================================
local form_components = {
  input = [[

/* Input Fields */
.form-input {
  display: block;
  width: 100%;
  padding: 0.75rem 1rem;
  font-size: 0.875rem;

  line-height: 1.25rem;
  color: var(--neutral-800);
  background-color: var(--neutral-50);
  border: 1px solid var(--neutral-300);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
  transition: all var(--transition-fast);
}

.form-input:focus {
  outline: none;
  border-color: var(--primary-500);
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.form-input:disabled {

  opacity: 0.5;
  cursor: not-allowed;
  background-color: var(--neutral-100);
}

.form-input.error {
  border-color: var(--error-500);

}


.form-input.error:focus {
  border-color: var(--error-500);
  box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
}
]],


  textarea = [[
/* Textarea */
.form-textarea {
  display: block;
  width: 100%;
  padding: 0.75rem 1rem;
  font-size: 0.875rem;

  line-height: 1.25rem;
  color: var(--neutral-800);
  background-color: var(--neutral-50);
  border: 1px solid var(--neutral-300);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
  transition: all var(--transition-fast);
  resize: vertical;
  min-height: 6rem;

}


.form-textarea:focus {
  outline: none;
  border-color: var(--primary-500);

  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}
]],

  select = [[
/* Select Dropdown */

.form-select {
  display: block;
  width: 100%;
  padding: 0.75rem 2.5rem 0.75rem 1rem;
  font-size: 0.875rem;
  line-height: 1.25rem;
  color: var(--neutral-800);
  background-color: var(--neutral-50);

  background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
  background-position: right 0.75rem center;
  background-repeat: no-repeat;
  background-size: 1rem;
  border: 1px solid var(--neutral-300);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
  cursor: pointer;
  transition: all var(--transition-fast);

}


.form-select:focus {
  outline: none;
  border-color: var(--primary-500);
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}
]],

  checkbox = [[
/* Checkbox */

.form-checkbox {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
  user-select: none;
}

.form-checkbox input[type="checkbox"] {
  appearance: none;
  width: 1.25rem;
  height: 1.25rem;

  border: 2px solid var(--neutral-300);
  border-radius: var(--radius-sm);
  background-color: var(--neutral-50);
  cursor: pointer;
  transition: all var(--transition-fast);
  position: relative;
}

.form-checkbox input[type="checkbox"]:checked {
  background-color: var(--primary-600);
  border-color: var(--primary-600);
}


.form-checkbox input[type="checkbox"]:checked::before {
  content: "";
  position: absolute;

  top: 50%;

  left: 50%;
  width: 0.375rem;
  height: 0.75rem;
  border: 2px solid white;
  border-top: none;
  border-left: none;
  transform: translate(-50%, -60%) rotate(45deg);
}

.form-checkbox input[type="checkbox"]:focus {
  outline: none;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

]],

  radio = [[

/* Radio Button */
.form-radio {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
  user-select: none;
}

.form-radio input[type="radio"] {
  appearance: none;
  width: 1.25rem;
  height: 1.25rem;

  border: 2px solid var(--neutral-300);
  border-radius: 50%;
  background-color: var(--neutral-50);
  cursor: pointer;
  transition: all var(--transition-fast);

  position: relative;
}

.form-radio input[type="radio"]:checked {
  background-color: var(--primary-600);
  border-color: var(--primary-600);
}

.form-radio input[type="radio"]:checked::before {
  content: "";
  position: absolute;
  top: 50%;
  left: 50%;
  width: 0.5rem;
  height: 0.5rem;

  background-color: white;
  border-radius: 50%;

  transform: translate(-50%, -50%);
}


.form-radio input[type="radio"]:focus {
  outline: none;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

]],

  group = [[

/* Form Group */
.form-group {

  margin-bottom: 1.5rem;
}

.form-label {
  display: block;
  margin-bottom: 0.5rem;
  font-size: 0.875rem;

  font-weight: 600;
  color: var(--neutral-700);
}

.form-help {
  margin-top: 0.25rem;
  font-size: 0.75rem;
  color: var(--neutral-500);
}

.form-error {
  margin-top: 0.25rem;
  font-size: 0.75rem;
  color: var(--error-600);
}

.form-required {
  color: var(--error-500);
}
]]

}


-- ==========================================

-- MODAL COMPONENTS
-- ==========================================
local modal_components = {
  overlay = [[
/* Modal Overlay */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);

  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;

  opacity: 0;
  visibility: hidden;
  transition: all var(--transition-normal);
}


.modal-overlay.active {
  opacity: 1;
  visibility: visible;
}

.modal-overlay.active .modal {
  transform: scale(1);
  opacity: 1;

}
]],

  modal = [[
/* Modal */
.modal {
  background-color: white;

  border-radius: var(--radius-xl);

  box-shadow: var(--shadow-xl);
  max-width: 28rem;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
  transform: scale(0.9);
  opacity: 0;
  transition: all var(--transition-normal);
}

.modal-header {
  padding: 1.5rem 1.5rem 1rem;
  border-bottom: 1px solid var(--neutral-200);
}

.modal-title {
  font-size: 1.125rem;
  font-weight: 600;

  color: var(--neutral-800);
  margin: 0;
}

.modal-close {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  color: var(--neutral-400);
  transition: color var(--transition-fast);
}

.modal-close:hover {
  color: var(--neutral-600);
}

.modal-body {
  padding: 1rem 1.5rem;
}

.modal-footer {
  padding: 1rem 1.5rem 1.5rem;
  border-top: 1px solid var(--neutral-200);
  display: flex;
  gap: 0.75rem;
  justify-content: flex-end;
}
]],

  sizes = [[
/* Modal Sizes */
.modal-sm {
  max-width: 20rem;
}

.modal-lg {

  max-width: 42rem;
}

.modal-xl {
  max-width: 56rem;
}

.modal-full {
  max-width: 90%;
  max-height: 90%;
}

]]
}

-- ==========================================
-- CARD COMPONENTS

-- ==========================================

local card_components = {
  base = [[
/* Card Component */
.card {
  background-color: white;

  border-radius: var(--radius-xl);

  box-shadow: var(--shadow-sm);
  border: 1px solid var(--neutral-200);
  overflow: hidden;
  transition: all var(--transition-fast);

}


.card:hover {
  box-shadow: var(--shadow-md);
}

.card-header {
  padding: 1.5rem 1.5rem 1rem;
  border-bottom: 1px solid var(--neutral-200);
}

.card-title {

  font-size: 1.125rem;
  font-weight: 600;
  color: var(--neutral-800);
  margin: 0 0 0.5rem 0;
}

.card-subtitle {
  font-size: 0.875rem;
  color: var(--neutral-600);
  margin: 0;
}

.card-body {
  padding: 1.5rem;
}

.card-footer {
  padding: 1rem 1.5rem 1.5rem;

  border-top: 1px solid var(--neutral-200);
  background-color: var(--neutral-50);
}

.card-image {
  width: 100%;
  height: 200px;
  object-fit: cover;
}
]],


  variants = [[
/* Card Variants */
.card-elevated {
  box-shadow: var(--shadow-lg);

  border: none;
}


.card-outlined {
  border: 2px solid var(--neutral-200);
  box-shadow: none;
}


.card-ghost {
  background-color: transparent;

  border: none;
  box-shadow: none;
}

.card-interactive {
  cursor: pointer;
  transition: all var(--transition-fast);
}

.card-interactive:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-lg);
}
]]

}


-- ==========================================

-- GRID & LAYOUT UTILITIES
-- ==========================================
local layout_utilities = {

  grid = [[
/* CSS Grid Utilities */

.grid {
  display: grid;
}

.grid-cols-1 { grid-template-columns: repeat(1, minmax(0, 1fr)); }
.grid-cols-2 { grid-template-columns: repeat(2, minmax(0, 1fr)); }
.grid-cols-3 { grid-template-columns: repeat(3, minmax(0, 1fr)); }
.grid-cols-4 { grid-template-columns: repeat(4, minmax(0, 1fr)); }
.grid-cols-5 { grid-template-columns: repeat(5, minmax(0, 1fr)); }
.grid-cols-6 { grid-template-columns: repeat(6, minmax(0, 1fr)); }
.grid-cols-12 { grid-template-columns: repeat(12, minmax(0, 1fr)); }

.col-span-1 { grid-column: span 1 / span 1; }
.col-span-2 { grid-column: span 2 / span 2; }
.col-span-3 { grid-column: span 3 / span 3; }
.col-span-4 { grid-column: span 4 / span 4; }
.col-span-5 { grid-column: span 5 / span 5; }
.col-span-6 { grid-column: span 6 / span 6; }
.col-span-full { grid-column: 1 / -1; }

.gap-1 { gap: 0.25rem; }

.gap-2 { gap: 0.5rem; }
.gap-3 { gap: 0.75rem; }
.gap-4 { gap: 1rem; }
.gap-6 { gap: 1.5rem; }
.gap-8 { gap: 2rem; }
.gap-12 { gap: 3rem; }

.gap-x-1 { column-gap: 0.25rem; }
.gap-x-2 { column-gap: 0.5rem; }
.gap-x-4 { column-gap: 1rem; }
.gap-x-6 { column-gap: 1.5rem; }

.gap-y-1 { row-gap: 0.25rem; }
.gap-y-2 { row-gap: 0.5rem; }
.gap-y-4 { row-gap: 1rem; }
.gap-y-6 { row-gap: 1.5rem; }
]],


  flexbox = [[
/* Flexbox Utilities */
.flex { display: flex; }

.inline-flex { display: inline-flex; }

.flex-row { flex-direction: row; }
.flex-col { flex-direction: column; }
.flex-row-reverse { flex-direction: row-reverse; }
.flex-col-reverse { flex-direction: column-reverse; }


.flex-wrap { flex-wrap: wrap; }
.flex-nowrap { flex-wrap: nowrap; }
.flex-wrap-reverse { flex-wrap: wrap-reverse; }

.items-start { align-items: flex-start; }
.items-end { align-items: flex-end; }

.items-center { align-items: center; }
.items-baseline { align-items: baseline; }
.items-stretch { align-items: stretch; }

.justify-start { justify-content: flex-start; }
.justify-end { justify-content: flex-end; }
.justify-center { justify-content: center; }
.justify-between { justify-content: space-between; }
.justify-around { justify-content: space-around; }
.justify-evenly { justify-content: space-evenly; }

.flex-1 { flex: 1 1 0%; }
.flex-auto { flex: 1 1 auto; }
.flex-initial { flex: 0 1 auto; }
.flex-none { flex: none; }


.flex-shrink-0 { flex-shrink: 0; }

.flex-shrink { flex-shrink: 1; }

.flex-grow-0 { flex-grow: 0; }
.flex-grow { flex-grow: 1; }
]],


  container = [[
/* Container System */

.container {

  width: 100%;
  margin-left: auto;
  margin-right: auto;
  padding-left: 1rem;
  padding-right: 1rem;
}

@media (min-width: 640px) {
  .container { max-width: 640px; }
}

@media (min-width: 768px) {
  .container { max-width: 768px; }
}

@media (min-width: 1024px) {
  .container { max-width: 1024px; }
}

@media (min-width: 1280px) {
  .container { max-width: 1280px; }
}

@media (min-width: 1536px) {
  .container { max-width: 1536px; }
}
]],

  spacing = [[
/* Spacing Utilities */
.m-0 { margin: 0; }
.m-1 { margin: 0.25rem; }
.m-2 { margin: 0.5rem; }
.m-3 { margin: 0.75rem; }
.m-4 { margin: 1rem; }
.m-6 { margin: 1.5rem; }

.m-8 { margin: 2rem; }
.m-12 { margin: 3rem; }
.m-auto { margin: auto; }


.mx-0 { margin-left: 0; margin-right: 0; }
.mx-1 { margin-left: 0.25rem; margin-right: 0.25rem; }
.mx-2 { margin-left: 0.5rem; margin-right: 0.5rem; }
.mx-4 { margin-left: 1rem; margin-right: 1rem; }
.mx-6 { margin-left: 1.5rem; margin-right: 1.5rem; }
.mx-8 { margin-left: 2rem; margin-right: 2rem; }
.mx-auto { margin-left: auto; margin-right: auto; }

.my-0 { margin-top: 0; margin-bottom: 0; }
.my-1 { margin-top: 0.25rem; margin-bottom: 0.25rem; }

.my-2
