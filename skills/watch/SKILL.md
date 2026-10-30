---
name: watch
description: Turn a video, talk, article, or pasted transcript into updates to the Paprika skills. Use when the user types /watch, shares a YouTube link or transcript to learn from, or asks to pull the rules, tips, or checklist out of a video into the skill set.
---

# Watch

Take a source the owner points at, pull out the rules it teaches, and file
them into the right skills with attribution. The owner feeds videos; this
skill turns them into durable guidance.

## Rules

### MUST
- Get the full text before extracting anything. Never work from the title, description, or the first few minutes.
- Write a notes file at `intake/videos/YYYY-MM-DD-<slug>.md` with title, channel or author, URL, date watched, a short summary, and a candidate-rules table (rule, strength, timestamp, proposed home). Notes only.
- Restate every candidate rule in one line before filing it, so the owner can correct it in the reply.
- File rules through the `skill-authoring` process: existing skill if one covers the topic, otherwise a new skill from `templates/SKILL.md`, then the catalog row, then `scripts/validate.sh`.
- Tag video-derived rules SHOULD or MAY by default. A rule becomes MUST or NEVER only when the owner says so, or when it matches a rule the owner already holds at that strength.
- Add a source line to the touched skill's Rationale: title, author, and URL.
- When a source contradicts an existing MUST or NEVER, do not change the rule. Record the conflict in the notes file and raise it in the reply. The owner decides.
- Add a row to `intake/README.md` listing the source and the skills touched.
- Commit with a message naming the source and the skills: "watch: <title> -> copywriting, seo-launch-checklist".

### SHOULD
- Skip anything that is a product pitch, an anecdote without a transferable rule, or already covered word for word. Say what was skipped and why in the notes.
- Prefer the speaker's concrete, testable advice over their framing. "Put the CTA above the fold" files; "think like your customer" does not, unless it comes with a how.
- Quote at most a phrase or two per rule. Paraphrase the rest.
- Note the timestamp of each rule so the owner can check the source.

### NEVER
- Store a full transcript in the repository. The link is the source.
- Edit an imported third-party skill (one with `UPSTREAM.md`) because of a video. File the rule in a Paprika skill or the Planned table instead.
- Invent a rule the source did not state to fill a gap.

## How to apply

### 1. Get the text

Work through these in order and stop at the first that succeeds.

1. **Pasted text or a file.** If the owner pasted a transcript or named a file, use it.
2. **Firecrawl connector, YouTube.** If a `firecrawl_scrape` tool is available, call it with:

   ```json
   {"alexandria": {"provider": "youtube-com", "capability": "videos/video_transcript",
                   "options": {"url": "<video url>", "language": "en"}}}
   ```

   The result carries `title`, `full_text`, and `segments` with `start_ms`. Use `segments` for timestamps. A 502 from the provider usually means the video has no captions. Try `video_details` to confirm, then fall back.
3. **Firecrawl connector, any other page.** Call `firecrawl_scrape` with the URL and `formats: ["markdown"]`.
4. **Local script.** On a machine that can reach youtube.com, run `scripts/transcript.py <url> --out <scratch file>` from this skill's folder. It uses `youtube-transcript-api` or `yt-dlp`, whichever is installed.
5. **Ask.** Tell the owner none of the above worked and ask them to paste the transcript. YouTube shows one under the "Show transcript" button below the description.

### 2. Extract

1. Read the whole text once for the argument, then again for rules.
2. List every candidate rule as one testable sentence, with its timestamp and a strength tag.
3. For each, name the home: an existing Paprika skill, a new skill, or Planned.
4. Mark conflicts with existing rules.

### 3. File

1. Write the notes file.
2. Apply the rules to the skills. Keep each addition in the skill's own voice and format.
3. Add the source line to each touched Rationale.
4. Add the catalog row for any new skill. Add the intake log row.
5. Run `scripts/validate.sh` and `claude plugin validate .`.
6. Commit and push.

### 4. Report

Reply with: the source, the rules filed (one line each with strength and home), the rules skipped and why, and any conflicts waiting on the owner.

## Examples

Good candidate-rules row:

```text
| Write the CTA as a verb plus the outcome | SHOULD | 04:12 | copywriting (already MUST, no change) |
```

Bad:

```text
| Great tips on CTAs | | | |
```

## Rationale

The owner learns from talks and videos and wants that learning to compound across projects rather than stay in one session's memory. Filing through the normal intake process keeps video-derived advice at the same quality as the owner's own rules, and the default SHOULD strength keeps a stranger's opinion from outranking the owner's until the owner agrees.

## Related skills

- `skill-authoring` - the filing process this skill feeds.
- `copywriting`, `seo-launch-checklist` - frequent destinations for marketing videos.
