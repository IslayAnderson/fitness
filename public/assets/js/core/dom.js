// DOM helpers
export const $  = (sel, parent = document) => parent.querySelector(sel);
export const $$ = (sel, parent = document) => [...parent.querySelectorAll(sel)];

export function on(el, event, handler) {
    el.addEventListener(event, handler);
    return () => el.removeEventListener(event, handler);
}

export function mount(container, node) {
    container.innerHTML = '';
    container.appendChild(node);
}
