// public/assets/js/components/datetime.js
function pad(n) { return String(n).padStart(2, '0'); }
function toLocalISO(d) {
    return `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}:${pad(d.getSeconds())}`;
}

/**
 * Initialize all date-time pickers within a root element (default: document).
 * Looks for:
 *  - [data-datetime] wrapper
 *  - [data-dt-date]  <input type="date">
 *  - [data-dt-time]  <input type="time">
 *  - [data-dt-hidden] hidden input (holds "YYYY-MM-DD HH:MM:SS")
 */
export function initDateTimePickers(root = document) {
    root.querySelectorAll('[data-datetime]').forEach(wrapper => {
        const dateEl = wrapper.querySelector('[data-dt-date]');
        const timeEl = wrapper.querySelector('[data-dt-time]');
        const hidden = wrapper.querySelector('[data-dt-hidden]');
        const targetName = wrapper.getAttribute('data-target') || 'datetime';

        // default to "now" if no value set
        if (!hidden.value) {
            const now = new Date();
            dateEl.value ||= `${now.getFullYear()}-${pad(now.getMonth()+1)}-${pad(now.getDate())}`;
            timeEl.value ||= `${pad(now.getHours())}:${pad(now.getMinutes())}`;
            hidden.value = toLocalISO(now);
        }

        function syncHidden() {
            const date = dateEl.value;         // YYYY-MM-DD
            const time = timeEl.value || '00:00'; // HH:MM
            if (date) hidden.value = `${date} ${time}:00`;
        }

        dateEl.addEventListener('change', syncHidden);
        timeEl.addEventListener('change', syncHidden);
        hidden.setAttribute('name', targetName);
    });
}
