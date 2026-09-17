# Non-Verbal Tagging Methodology

This page covers what the `[Chorus]` / `[OST]` tagging in the transcription stage is actually doing, and where its limits are.

## What triggers a tag

Per the README's stated features, Librosa's audio energy analysis and beat tracking identify segments with sustained musical or rhythmic characteristics that don't align with detected speech. Those segments are tagged `[Chorus]` or `[OST]` rather than passed through as untagged or mistranscribed text.

## Why this is a heuristic, not a classifier

The README describes this as energy analysis and beat tracking, not a trained audio-event classification model. That means the distinction it draws is fundamentally "does this section look rhythmically/energetically like music rather than speech," not "what specific type of music is this." Two practical implications:

- **`[Chorus]` vs. `[OST]` is likely a judgment call in the underlying notebook**, not two outputs of a classifier that was trained to tell the two apart. Check the actual tagging logic in the transcription notebook to see whether there's a distinguishing rule (e.g. repetition-based detection for `[Chorus]` vs. sustained-background detection for `[OST]`) or whether the choice between the two labels is manual/contextual.
- **Ambiguous cases exist by construction.** Speech over quiet background music, or a cappella vocal performance, sit closer to the boundary between "speech" and "music" than the beat-tracking heuristic is built to resolve perfectly. Expect occasional mistagging on audio where speech and music genuinely overlap, and treat the tags as a strong first pass rather than a guaranteed-correct classification, particularly for content like song lyrics, spoken-word-over-music, or heavily produced audio.

## Practical guidance

- For audio with a clean separation between spoken segments and instrumental/musical segments (e.g. a podcast with a musical intro/outro), expect the tagging to work well.
- For audio with substantial overlap (dialogue over a musical score, sung lyrics), review the tagged output rather than trusting it uncritically, especially if the output feeds directly into a translation or subtitling pipeline where a mistagged segment would either lose dialogue or add a spurious tag.
- If you need finer-grained control, the beat-tracking and energy-analysis parameters live in the transcription notebook itself; tuning them (e.g. energy threshold, beat-tracking sensitivity) is the lever available if the default tagging is too aggressive or too conservative for your specific audio.
