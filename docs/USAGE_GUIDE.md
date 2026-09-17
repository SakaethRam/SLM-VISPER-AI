# Usage Guide

## 1. Transcription Model

**Notebook:** `VISPER - Transcription Model (Whisper).ipynb`

1. Upload an audio file (or point the notebook at a path under `VISPER Datasets/`).
2. Run the notebook. VISPER transcribes the audio with Whisper.
3. In parallel, Librosa analyzes the same audio for energy and beat information.
4. Non-verbal segments (music, chorus, OST-style background audio) are automatically tagged as `[Chorus]` or `[OST]` rather than transcribed as garbled speech or silently dropped.
5. Output: a well-formatted, timestamped transcription file.

**When to use this alone:** you need a transcript in the original spoken language, with accurate timing and tagging of non-verbal segments; e.g. preparing source material for captioning, or archiving a recording with structure intact.

## 2. Translation Model

**Notebook:** `VISPER - Translation Model (Whisper).ipynb`

1. Upload an audio file, or use the Transcription Model's output as the source material.
2. Optionally choose a source language manually; automatic detection is also supported.
3. Whisper translates the audio content to English.
4. Output: a clean English transcription, with the original timestamps and formatting preserved.

**When to use this after Stage 1, not on raw audio directly:** if you already have a tagged, timestamped transcription from the Transcription Model, feeding that through preserves the `[Chorus]`/`[OST]` tags and precise timing in the translated output. Running the Translation Model directly on raw audio skips that enrichment and produces a plainer translated transcript, timestamps included, but without the non-verbal tagging layer.

## Typical end-to-end workflow

```
1. Run the Transcription Model notebook on your source audio
   → timestamped, tagged transcription in the original language

2. Feed that output into the Translation Model notebook
   → timestamped English transcription, tags and timing preserved
```

## Working with the `VISPER Datasets` folder

Use it as a source of example audio while getting familiar with both notebooks before pointing them at your own material. Once you're working with real audio, keep your own files out of version control (see `.gitignore` in this delivery) rather than committing them alongside the sample dataset.

## Expected runtime notes

- Whisper's runtime scales with both audio length and model size (VISPER's notebooks should specify which Whisper model size they load; larger models are slower but more accurate).
- Librosa's energy/beat analysis is comparatively fast and CPU-bound; it is not the bottleneck in the transcription stage.
- If you're processing long-form audio (an hour or more), expect the transcription stage to dominate total runtime, and see `SETUP_AND_DEPLOYMENT.md` for GPU acceleration options.
