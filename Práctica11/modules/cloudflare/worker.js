export default {
  async fetch(request, env) {
    if (request.method !== "GET") {
      return new Response("Método no permitido", {
        status: 405,
        headers: { Allow: "GET" },
      });
    }

    await env.DB.prepare(
      "CREATE TABLE IF NOT EXISTS visits (id INTEGER PRIMARY KEY AUTOINCREMENT, created_at TEXT DEFAULT CURRENT_TIMESTAMP)"
    ).run();
    await env.DB.prepare("INSERT INTO visits DEFAULT VALUES").run();
    const result = await env.DB.prepare("SELECT COUNT(*) AS total FROM visits").first();

    return Response.json({
      ok: true,
      mensaje: "Worker funcionando con D1",
      visitas: result.total,
      url: request.url,
    });
  },
};
