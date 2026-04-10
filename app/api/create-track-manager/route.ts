import { NextRequest, NextResponse } from "next/server";
import { runCreateTrackManager } from "@/lib/create-track-manager-handler";

export async function POST(request: NextRequest) {
  let body: { email?: string; password?: string } = {};
  try {
    body = await request.json();
  } catch {
    body = {};
  }

  const result = await runCreateTrackManager(
    "POST",
    request.headers.get("authorization"),
    body
  );

  const headers = new Headers();
  if (result.headers) {
    for (const [k, v] of Object.entries(result.headers)) {
      headers.set(k, v);
    }
  }

  return NextResponse.json(result.body, { status: result.status, headers });
}

export async function GET() {
  return NextResponse.json(
    { ok: true, route: "create-track-manager", hint: "Use POST with Bearer token and JSON { email, password }." },
    { status: 200 }
  );
}
