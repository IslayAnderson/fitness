import { getJson } from '../core/api.js';
import { $, mount } from '../core/dom.js';
//import '../chartist/dist/index.css';
import { LineChart } from '../chartist/dist/index.js';

export async function initDataPage() {
    const mEl = $('#measurementsChart');
    const eEl = $('#exerciseChart');
    const dEl = $('#diaryChart');

    if (!mEl && !eEl && !dEl) return;

    // Measurements line (first body_part series)
    if (mEl) {
        try {
            const rows = await getJson('/api/measurments');
            console.log(rows);
            if (Array.isArray(rows) && rows.length) {
                const firstPart = rows[0].body_part;
                const series = rows
                    .filter(r => r.body_part == firstPart)
                    .sort((a, b) => new Date(a.datetime) - new Date(b.datetime));
                lineChart(mEl, series, r => Number(r.measurement), { title: 'Measurements Over Time' });
            }

            new LineChart(
                '#measurementsChart',
                {
                    labels: [1, 2, 3, 4, 5, 6, 7, 8],
                    series: [[5, 9, 7, 8, 5, 3, 5, 4]]
                },
                {
                    low: 0,
                    showArea: true
                }
            );
        } catch {}
    }

    // Exercise weights (recent 20)
    if (eEl) {
        try {
            const rows = await getJson('/api/log');
            const tableCompressed = {};
            rows.forEach((row) => {
                const volume = (row.weight * row.reps)*row.sets;
                const rowDate = row.datetime.split(' ')[0];
                tableCompressed[rowDate] = tableCompressed[rowDate]?tableCompressed[rowDate]+volume:volume;
            })

            new LineChart(
                '#exerciseChart',
                {
                    labels: Object.keys(tableCompressed),
                    series: [Object.values(tableCompressed)]
                },
                {
                    low: 0,
                    showArea: true
                }
            );
        } catch {}
    }

    // Diary frequency per day
    // if (dEl) {
    //     try {
    //         const rows = await getJson('/api/diary');
    //         if (Array.isArray(rows) && rows.length) {
    //             const counts = {};
    //             rows.forEach(r => {
    //                 const day = (r.datetime || '').slice(0, 10);
    //                 if (!day) return;
    //                 counts[day] = (counts[day] || 0) + 1;
    //             });
    //             const arr = Object.entries(counts)
    //                 .sort((a, b) => a[0].localeCompare(b[0]))
    //                 .map(([day, count]) => ({ day, count }));
    //
    //             barChart(dEl, arr, r => Number(r.count), { title: 'Diary Entries per Day' });
    //         }
    //     } catch {}
    // }
}
