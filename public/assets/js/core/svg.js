// Tiny SVG helper layer
export function svgEl(name, attrs = {}) {
    const el = document.createElementNS('http://www.w3.org/2000/svg', name);
    for (const [k, v] of Object.entries(attrs)) el.setAttribute(k, v);
    return el;
}

export function axes(svg, { width, height, margin, gridY = 4, gridColor }) {
    const g = svgEl('g');
    g.appendChild(svgEl('line', {
        x1: margin, y1: height - margin, x2: width - margin, y2: height - margin,
        stroke: gridColor, 'stroke-width': 1
    }));
    g.appendChild(svgEl('line', {
        x1: margin, y1: margin, x2: margin, y2: height - margin,
        stroke: gridColor, 'stroke-width': 1
    }));
    for (let i = 1; i <= gridY; i++) {
        const y = margin + i * ((height - 2 * margin) / gridY);
        g.appendChild(svgEl('line', {
            x1: margin, y1: y, x2: width - margin, y2: y,
            stroke: gridColor, 'stroke-width': 1
        }));
    }
    svg.appendChild(g);
}

export function tooltipLayer(svg) {
    const bg = svgEl('rect', { rx: 4, ry: 4, fill: 'white', stroke: 'rgba(0,0,0,.08)', visibility: 'hidden' });
    const txt = svgEl('text', { fill: '#333', 'font-size': 12, visibility: 'hidden' });
    svg.appendChild(bg);
    svg.appendChild(txt);
    return {
        show(x, y, text) {
            txt.textContent = text;
            txt.setAttribute('x', x + 8);
            txt.setAttribute('y', y - 8);
            txt.setAttribute('visibility', 'visible');
            const b = txt.getBBox();
            bg.setAttribute('x', b.x - 4);
            bg.setAttribute('y', b.y - 2);
            bg.setAttribute('width', b.width + 8);
            bg.setAttribute('height', b.height + 4);
            bg.setAttribute('visibility', 'visible');
        },
        hide() {
            txt.setAttribute('visibility', 'hidden');
            bg.setAttribute('visibility', 'hidden');
        }
    };
}

