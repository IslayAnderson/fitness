import { getJson } from '../core/api.js';
import { $, mount } from '../core/dom.js';
import { lineChart, barChart } from '../core/charts.js';

export async function initDataPage() {
    const mEl = $('#measurementsChart');
    const eEl = $('#exerciseChart');
    const dEl = $('#diaryChart');

    if (!mEl && !eEl && !dEl) return;

    // Measurements line (first body_part series)
    if (mEl) {
        try {
            const rows = await getJson('/api/measurments');
            if (Array.isArray(rows) && rows.length) {
                const firstPart = rows[0].body_part;
                const series = rows
                    .filter(r => r.body_part == firstPart)
                    .sort((a, b) => new Date(a.datetime) - new Date(b.datetime));
                lineChart(mEl, series, r => Number(r.measurement), { title: 'Measurements Over Time' });
            }
        } catch {}
    }

    // Exercise weights (recent 20)
    if (eEl) {
        try {
            const rows = await getJson('/api/log');
            if (Array.isArray(rows) && rows.length) {
                const recent = rows.slice(0, 20).reverse();
                barChart(eEl, recent, r => Number(r.weight) || 0, { title: 'Exercise Weights' });
            }
        } catch {}
    }

    // Diary frequency per day
    if (dEl) {
        try {
            const rows = await getJson('/api/diary');
            if (Array.isArray(rows) && rows.length) {
                const counts = {};
                rows.forEach(r => {
                    const day = (r.datetime || '').slice(0, 10);
                    if (!day) return;
                    counts[day] = (counts[day] || 0) + 1;
                });
                const arr = Object.entries(counts)
                    .sort((a, b) => a[0].localeCompare(b[0]))
                    .map(([day, count]) => ({ day, count }));

                barChart(dEl, arr, r => Number(r.count), { title: 'Diary Entries per Day' });
            }
        } catch {}
    }
}
