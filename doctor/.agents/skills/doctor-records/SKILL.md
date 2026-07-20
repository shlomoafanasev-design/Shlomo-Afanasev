---
name: doctor-records
description: Use whenever Shlomo shares lab results, imaging reports, visit summaries, medication changes, or symptoms in the doctor/ project. Extracts exact values from lab/medical documents into doctor/records/labs.md, and maintains a running log of medications and symptoms in doctor/records/medications.md and doctor/records/symptoms.md. Trigger on pasted or uploaded lab reports, mentions of a new prescription or dosage change, and descriptions of symptoms or how Shlomo is feeling, even without an explicit "log this" instruction.
---

# Doctor Records

Keep a structured, accurate running record of lab results, medications, and symptoms for the
doctor project. This skill is about faithful record-keeping, not interpretation — see the
"What this skill does not do" section below.

## Why exactness matters here

A lab value transcribed as "5.1" instead of "5.4", or a medication logged with the wrong dose,
isn't a cosmetic error — it can mislead a real medical decision later. Every rule below exists to
prevent silently losing precision or inventing information that wasn't actually given.

## Files

- `doctor/records/labs.md` — one row per lab result
- `doctor/records/medications.md` — one row per medication (or per dosage change)
- `doctor/records/symptoms.md` — one row per symptom entry

Create a file from the templates below if it doesn't exist yet. Never delete existing rows —
this is an append-and-correct log, not a replaceable snapshot. If a past entry needs correcting,
edit that row in place and note the correction rather than silently overwriting it.

### labs.md format

```markdown
| Date | Test | Value | Unit | Reference Range | Flag | Source |
|------|------|-------|------|------------------|------|--------|
```

- **Date**: the date the sample was taken/reported, not the date it was transcribed. Ask if the
  source document doesn't make this clear.
- **Value / Unit / Reference Range**: copy exactly as printed in the source. Do not convert
  units, round, or normalize formatting.
- **Flag**: `High` / `Low` / `Normal` / `—` — determine this from the reference range printed in
  the *same source document*, never from general medical knowledge of what's "normal." If the
  source doesn't include a reference range, leave this `—` rather than guessing one.
- **Source**: filename or short description of where this came from (e.g. "Quest Diagnostics
  2026-06-02.pdf").

### medications.md format

```markdown
| Medication | Dose | Frequency | Start Date | End Date | Prescribing Doctor | Notes |
|------------|------|-----------|------------|----------|---------------------|-------|
```

- On a dosage change, add a **new row** for the new dose and set the old row's End Date — don't
  edit the old row's dose in place. The history of changes is itself clinically relevant.
- Leave End Date blank for medications still being taken.

### symptoms.md format

```markdown
| Date | Symptom | Severity (1-5) | Duration | Notes |
|------|---------|-----------------|----------|-------|
```

- Severity is Shlomo's own self-reported number — ask if he mentions a symptom without rating it
  rather than estimating a severity yourself.
- Use Notes for anything that seems related: timing relative to a medication dose, food, activity,
  or a prior entry. Cross-referencing this way is often more clinically useful than the entry
  itself.

## Workflow

1. When a lab report, imaging result, or visit summary is shared (pasted text, PDF, or image),
   use the `pdf` skill if needed to extract it, then transcribe every value into `labs.md`
   following the format above. If several values are on one report, add one row per value.
2. When Shlomo mentions starting, stopping, or changing a medication, update `medications.md`
   per the rules above.
3. When Shlomo describes how he's feeling or a symptom, log it to `symptoms.md`. This includes
   casual mentions ("my knee's been bothering me since Tuesday") — capture these even when he
   isn't explicitly asking for a log entry.
4. After updating a file, briefly confirm what was logged so Shlomo can catch a transcription
   error immediately rather than downstream.
5. If any field is genuinely ambiguous or missing from the source (unclear date, cut-off value,
   illegible scan), ask rather than filling it in with a plausible-looking guess.

## What this skill does not do

- It does not diagnose, interpret whether a trend is concerning, or suggest treatment — that's a
  doctor's job. If a value is flagged `High`/`Low` per its own reference range, say so plainly,
  but don't editorialize about what it might mean.
- It does not calculate reference ranges, drug interactions, or dosing guidance from general
  knowledge. Only use what's explicitly in the source document or what Shlomo tells you directly.
- See `doctor/CLAUDE.md` for how this data should be handled more broadly (don't summarize or
  repeat it outside direct responses to Shlomo).
