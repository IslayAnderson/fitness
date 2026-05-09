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
    // if (mEl) {
    //     try {
    //         const rows = await getJson('/api/measurments');
            // console.log(rows);
            // if (Array.isArray(rows) && rows.length) {
            //     const firstPart = rows[0].body_part;
            //     const series = rows
            //         .filter(r => r.body_part == firstPart)
            //         .sort((a, b) => new Date(a.datetime) - new Date(b.datetime));
            //     lineChart(mEl, series, r => Number(r.measurement), { title: 'Measurements Over Time' });
            // }
    //
    //         new LineChart(
    //             '#measurementsChart',
    //             {
    //                 labels: [1, 2, 3, 4, 5, 6, 7, 8],
    //                 series: [[5, 9, 7, 8, 5, 3, 5, 4]]
    //             },
    //             {
    //                 low: 0,
    //                 showArea: true
    //             }
    //         );
    //     } catch {}
    // }

    // Exercise weights (recent 20)
    if (eEl) {
        try {
            const rows = await getJson('/api/log');
            let dataLabels = [];
            let dataSeriesPre = [];
            let dataSeries = [];
            const dateFormat = {
                year: '2-digit',
                month: '2-digit',
                day: '2-digit',
            }
            rows.forEach((row) => {
                dataLabels.push(new Date(row.datetime).toLocaleString('en-GB', dateFormat));
                dataSeriesPre.push(row.exercise_name);
            })
            dataLabels = new Set(dataLabels);
            dataSeriesPre = new Set(dataSeriesPre);

            console.log(dataLabels);
            console.log(dataSeriesPre);
            dataLabels.forEach((date) => {
                const data = rows.find(row => {
                    let rowDate = new Date(row.datetime).toLocaleString('en-GB', dateFormat);
                    if (rowDate === date) {
                        let pos = dataSeriesPre.findIndex((label) => label === row.exercise_name)
                        if(typeof (dataSeries[pos]) === 'undefined') {
                            dataSeries[pos] = [];
                        }
                        dataSeries[pos].push(row.weight*row.reps*row.sets)
                    }else {
                        return false
                    }
                })
            })

            console.log(dataSeries)

            eEl.style.width = (dataLabels.length*25)+'vw';


            new LineChart(
                '#exerciseChart',
                {
                    labels: dataLabels,
                    series: dataSeries
                },
                {
                    low: 0,
                    showArea: true
                }
            );
        } catch (error) {
            console.log(error);
        }
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
