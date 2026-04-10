import type { VercelRequest, VercelResponse } from "@vercel/node";
import { runCreateTrackManager } from "../lib/create-track-manager-handler";

function parseBody(req: VercelRequest): { email?: string; password?: string } {
  const raw = req.body;
  if (raw == null) return {};
  if (typeof raw === "object" && !Buffer.isBuffer(raw)) return raw as { email?: string; password?: string };
  if (typeof raw === "string") {
    try {
      return JSON.parse(raw || "{}");
    } catch {
      return {};
    }
  }
  return {};
}

export default async function handler(req: VercelRequest, res: VercelResponse) {
  if (req.method === "GET") {
    return res.status(200).json({
      ok: true,
      route: "create-track-manager",
      hint: "Use POST with Authorization: Bearer <session> and JSON { email, password }.",
    });
  }

  const body = parseBody(req);
  const result = await runCreateTrackManager(
    req.method || "GET",
    typeof req.headers.authorization === "string" ? req.headers.authorization : null,
    body
  );

  if (result.headers) {
    for (const [k, v] of Object.entries(result.headers)) {
      res.setHeader(k, v);
    }
  }

  return res.status(result.status).json(result.body);
}
