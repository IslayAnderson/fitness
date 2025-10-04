// public/assets/js/main.js
import { initForms } from './pages/forms.js';
import { initDataPage } from './pages/data.js';

document.addEventListener('DOMContentLoaded', () => {
    initForms();
    initDataPage();
});
