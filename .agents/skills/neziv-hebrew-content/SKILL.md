---
name: neziv-hebrew-content
description: Helps produce accurate, consistent Hebrew and Judaic-studies content for the Neziv project — transliterating Hebrew terms into English, formatting citations to Torah/Talmud/halachic sources (especially the Netziv's works: Ha'amek Davar, Ha'amek She'ela, Meshiv Davar, Harchev Davar), and laying out bilingual Hebrew (RTL) / English (LTR) text in documents and web pages. Use this whenever the user is writing, editing, or reviewing content that mixes Hebrew and English, cites a Torah/Talmud/halachic source, or asks about transliteration, nikud, source citation style, or RTL/LTR layout for this project.
---

# Neziv Hebrew Content

Guidance for producing Hebrew/English bilingual content — transliteration, source citations, and RTL/LTR layout — consistently across the Neziv project.

## Why consistency matters here

Judaic content readers notice inconsistency immediately: the same word transliterated two different ways in one document, or a citation missing a chapter number, reads as unpolished or even inaccurate. Because this project centers on the Netziv (Rabbi Naftali Zvi Yehuda Berlin) and his works, get his name and his works' titles right every time — these are the details a knowledgeable reader checks first.

## 1. Transliteration

Pick **one** transliteration convention for the whole project and apply it consistently. Ask the user which they prefer if it isn't already established (check existing project files for precedent before asking). The two common defaults:

- **Ashkenazi/traditional** (common in yeshiva and English-speaking Orthodox contexts): Shabbos, Bracha, Mitzvos, Toras
- **Sephardi/Modern Hebrew** (common in academic and Israeli contexts): Shabbat, Brakha, Mitzvot, Torat

Within either convention, apply these rules uniformly:

- Represent `ח` and `כ/ך` (as fricative) the same way throughout — typically `ch` or `kh`, not a mix.
- Decide once whether `א`/`ע` get an apostrophe or silent letter marker (e.g., "Ha'amek" vs "Haamek") and never switch mid-document.
- Capitalize transliterated proper nouns and book titles, lowercase common transliterated terms used as English words (e.g., "the mitzvah," but "Mitzvot Aseh" as a title).
- Keep a short glossary (a table at the top of a document or a shared `references/glossary.md` in this skill folder — create one if the project doesn't have a canonical source list yet) of terms/names the user corrects, so the same fix doesn't need to be made twice.

**The Netziv's name specifically**: "Netziv" (or "HaNetziv") is the acronym-derived title for Rabbi Naftali Zvi Yehuda Berlin. Don't silently "correct" it to "Neziv" or expand it to the full name unless the user's own usage or the surrounding content calls for the full name — match whatever the project has already established.

## 2. Source citations

Use a consistent citation format for Torah, Talmud, and halachic sources. Default pattern — confirm with the user if the project has its own house style already in use elsewhere:

```
<Work>, <Book/Tractate> <chapter>:<verse/section>
```

Examples:
- `Ha'amek Davar, Bereishit 1:1` (the Netziv's commentary on the Torah)
- `Ha'amek She'ela, She'ilta 1` (his commentary on the She'iltot)
- `Meshiv Davar, Orach Chaim 1` (his responsa collection)
- `Berachot 28b` (Talmud — tractate, page, side)
- `Shulchan Aruch, Orach Chaim 1:1` (codes)

Rules:
- Italicize (or otherwise distinguish, e.g., **bold** in Markdown contexts that render prose plain) the name of the work on first citation in a section; plain text is fine for repeat citations nearby.
- Talmud citations use the standard daf:amud format (`28b`, not `page 28 side b`).
- When quoting text directly, follow the quotation with the citation in parentheses: `"..." (Ha'amek Davar, Bereishit 1:1)`.
- If the user is citing a specific edition or translation, note it once (e.g., in a preface or footnote) rather than repeating the edition on every citation.
- Never guess a citation you're not sure of — if the user gives you a quote without a source, ask, or flag it clearly as `[citation needed]` rather than inventing one. A wrong citation is worse than a missing one.

## 3. Bilingual RTL/LTR layout

When Hebrew and English appear together in the same document or page:

- **HTML/web**: wrap Hebrew spans in `dir="rtl"` (or set `direction: rtl` in CSS) scoped to just the Hebrew text — don't flip direction for the whole page unless the page is Hebrew-primary. For a Hebrew-primary page, set `dir="rtl"` on `<html>` or the main container and instead scope `dir="ltr"` around embedded English/Latin terms.
- Use `lang="he"` on Hebrew spans and `lang="en"` on English spans — this helps browsers pick correct fonts and helps screen readers switch pronunciation rules correctly.
- For numbers and citations embedded inside RTL Hebrew text (e.g., a Talmud page reference), rely on Unicode's bidirectional algorithm — it generally gets digit runs right automatically, but wrap ambiguous mixed punctuation in an explicit `<bdi>` element if it renders out of order.
- **Word/Docx or other document tooling** (use alongside the `docx` skill if producing a .docx file): set paragraph direction per-paragraph rather than globally when Hebrew and English paragraphs alternate; set explicit right-alignment for Hebrew paragraphs and left-alignment for English ones unless the user wants justified text.
- Pick a font that has solid Hebrew glyph coverage (e.g., Frank Ruhl Libre, Noto Sans Hebrew, David) rather than assuming a Latin-only web font will render Hebrew acceptably — check visually if unsure.
- Test the actual rendering when this is for a web page — mixed-direction bugs (a Hebrew phrase suddenly rendering the wrong way when it starts with a Latin character or number) are easy to introduce and easy to miss just by reading the source.

## When you're unsure

If the user hasn't established a convention yet (transliteration style, citation format, or layout approach) and the project has no existing content to infer from, ask rather than picking silently — these are exactly the kind of decisions that are painful to unwind across a whole project later. Once they answer, apply it consistently and don't re-ask for the rest of the session.
