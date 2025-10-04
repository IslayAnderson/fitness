// public/assets/js/pages/forms.js
import { putJson } from '../core/api.js';
import { $, on } from '../core/dom.js';
import { initDateTimePickers } from '../components/datetime.js';

export function initForms() {
    // wire datetime pickers first
    initDateTimePickers();

    // Measurements
    const measurementForm = $('#measurementForm');
    if (measurementForm) {
        on(measurementForm, 'submit', async (e) => {
            e.preventDefault();
            const body_part = measurementForm.body_part.value;
            const measurement = measurementForm.measurement.value;
            const res = await putJson('/api/measurments', { body_part, measurement });
            const out = $('#measurementResult');
            out.textContent = res?.id ? `Saved measurement #${res.id}` : JSON.stringify(res);
            measurementForm.reset();
        });
    }

    // Exercise log
    const logForm = $('#logForm');
    if (logForm) {
        on(logForm, 'submit', async (e) => {
            e.preventDefault();
            const data = Object.fromEntries(new FormData(logForm).entries());
            ['weight','reps','sets','distance','tension_level','effort'].forEach(k => {
                if (data[k] !== undefined && data[k] !== '') data[k] = Number(data[k]);
            });
            const res = await putJson('/api/log', data);
            const out = $('#logResult');
            out.textContent = res?.id ? `Saved log #${res.id}` : JSON.stringify(res);
            logForm.reset();
            // reinitialize date-time to "now" for the next entry
            initDateTimePickers(logForm);
        });
    }

    // Diary
    const diaryForm = $('#diaryForm');
    if (diaryForm) {
        on(diaryForm, 'submit', async (e) => {
            e.preventDefault();
            const diary = diaryForm.diary.value;
            const res = await putJson('/api/diary', { diary });
            const out = $('#diaryResult');
            out.textContent = res?.id ? `Saved diary #${res.id}` : JSON.stringify(res);
            diaryForm.reset();
        });
    }
}
