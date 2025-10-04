// Minimal fetch helpers
export async function putJson(url, data) {
    const res = await fetch(url, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });
    return res.json();
}

export async function getJson(url) {
    const res = await fetch(url);
    return res.json();
}
