import { svgEl, axes, tooltipLayer } from './svg.js';
import { COLORS } from './colors.js';
import { mount } from './dom.js';

const DEFAULTS = { width: 840, height: 260, margin: 32 };

export function lineChart(container, data, yAccessor, opts = {}) {
    const { width, height, margin } = { ...DEFAULTS, ...opts };
    if (!container || !data?.length) return;

    const vals = data.map(yAccessor).filter(v => v != null && !Number.isNaN(+v)).map(Number);
    if (!vals.length) return;

    const min = Math.min(...vals);
    const max = Math.max(...vals);

    const svg = svgEl('svg', { width, height, 'aria-label': opts.title || 'Line chart' });
    axes(svg, { width, height, margin, gridColor: COLORS.grid });

    let d = '';
    data.forEach((row, i) => {
        const v = Number(yAccessor(row));
        const x = margin + (i / (data.length - 1)) * (width - 2 * margin);
        const y = height - margin - ((v - min) / (max - min || 1)) * (height - 2 * margin);
        d += (i ? ` L${x},${y}` : `M${x},${y}`);
    });

    svg.appendChild(svgEl('path', { d, fill: 'none', stroke: COLORS.line, 'stroke-width': 2 }));

    const tip = tooltipLayer(svg);

    data.forEach((row, i) => {
        const v = Number(yAccessor(row));
        const x = margin + (i / (data.length - 1)) * (width - 2 * margin);
        const y = height - margin - ((v - min) / (max - min || 1)) * (height - 2 * margin);
        const dot = svgEl('circle', { cx: x, cy: y, r: 4, fill: COLORS.dot });
        dot.addEventListener('mouseenter', () => tip.show(x, y, String(v)));
        dot.addEventListener('mouseleave', () => tip.hide());
        svg.appendChild(dot);
    });

    mount(container, svg);
}

export function barChart(container, data, yAccessor, opts = {}) {
    const { width, height, margin } = { ...DEFAULTS, ...opts };
    if (!container || !data?.length) return;

    const vals = data.map(yAccessor).filter(v => v != null && !Number.isNaN(+v)).map(Number);
    if (!vals.length) return;

    const max = Math.max(...vals);
    const svg = svgEl('svg', { width, height, 'aria-label': opts.title || 'Bar chart' });
    axes(svg, { width, height, margin, gridColor: COLORS.grid });

    const innerW = width - 2 * margin;
    const innerH = height - 2 * margin;
    const barW = innerW / data.length;

    data.forEach((row, i) => {
        const v = Number(yAccessor(row));
        const h = (v / (max || 1)) * innerH;
        const x = margin + i * barW;
        const y = height - margin - h;
        svg.appendChild(svgEl('rect', {
            x, y, width: barW * 0.8, height: h, fill: COLORS.bar
        }));
    });

    mount(container, svg);
}
