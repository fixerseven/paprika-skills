#!/usr/bin/env python3
"""Fetch a YouTube transcript as plain text with timestamps.

Usage: transcript.py <youtube-url-or-id> [--lang en] [--out FILE]

Tries, in order: youtube-transcript-api, then yt-dlp subtitles. Both need
network access to youtube.com, so run this on a machine that has it. Prints
one line per caption: "[mm:ss] text". Exits 2 when no method is available,
3 when the video has no captions.
"""
import argparse, json, re, subprocess, sys, tempfile, pathlib

def video_id(s):
    m = re.search(r'(?:v=|youtu\.be/|shorts/|embed/|live/)([A-Za-z0-9_-]{11})', s)
    return m.group(1) if m else (s if re.fullmatch(r'[A-Za-z0-9_-]{11}', s) else None)

def stamp(sec):
    sec = int(sec); return f"[{sec//60:02d}:{sec%60:02d}]"

def via_api(vid, lang):
    try:
        from youtube_transcript_api import YouTubeTranscriptApi
    except ImportError:
        return None
    try:
        api = YouTubeTranscriptApi()
        tr = api.fetch(vid, languages=[lang, "en"])
        return [(e.start, e.text) for e in tr]
    except Exception as e:
        sys.stderr.write(f"youtube-transcript-api: {e}\n"); return None

def via_ytdlp(vid, lang):
    if subprocess.run(["which", "yt-dlp"], capture_output=True).returncode != 0:
        return None
    with tempfile.TemporaryDirectory() as d:
        r = subprocess.run(["yt-dlp", "--skip-download", "--write-auto-sub", "--write-sub",
                            "--sub-lang", lang, "--sub-format", "json3", "-o", f"{d}/%(id)s",
                            f"https://www.youtube.com/watch?v={vid}"], capture_output=True, text=True)
        files = list(pathlib.Path(d).glob("*.json3"))
        if not files:
            sys.stderr.write(r.stderr[-500:] + "\n"); return None
        data = json.loads(files[0].read_text())
        out = []
        for ev in data.get("events", []):
            text = "".join(s.get("utf8", "") for s in ev.get("segs", [])).strip()
            if text and "tStartMs" in ev:
                out.append((ev["tStartMs"] / 1000, text))
        return out

def main():
    p = argparse.ArgumentParser(); p.add_argument("video"); p.add_argument("--lang", default="en"); p.add_argument("--out")
    a = p.parse_args()
    vid = video_id(a.video)
    if not vid: sys.exit("not a YouTube URL or id")
    tried = 0
    for fn in (via_api, via_ytdlp):
        res = fn(vid, a.lang)
        if res is None: continue
        tried += 1
        if res:
            lines = [f"{stamp(s)} {t.replace(chr(10), ' ')}" for s, t in res]
            text = "\n".join(lines) + "\n"
            if a.out: pathlib.Path(a.out).write_text(text); print(f"wrote {len(lines)} lines to {a.out}")
            else: sys.stdout.write(text)
            return
    sys.exit(3 if tried else 2)

if __name__ == "__main__":
    main()
