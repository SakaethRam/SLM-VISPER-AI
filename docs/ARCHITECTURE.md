# Architecture

VISPER is a two-stage, notebook-driven audio pipeline: a transcription stage that turns raw audio into a richly annotated, timestamped transcript, and a translation stage that consumes that transcript's output and produces an English translation while preserving the original timing and formatting.

## Why two stages, not one

Whisper alone can do transcription-with-translation in a single pass, but VISPER deliberately splits the work:

1. **Transcription Model** — Whisper for speech-to-text, plus Librosa for signal analysis on top. This stage's job is to produce a transcript that's rich in metadata, not just plain text: timestamps, and contextual tags for non-verbal audio segments.
2. **Translation Model** — takes the transcription stage's precisely-timed output as its input and translates it, preserving those timestamps and formatting rather than re-deriving timing from scratch.

Splitting them means the translation stage never has to re-solve the segmentation and tagging problem the transcription stage already solved. It trusts the first stage's timing and structure completely, the same way a subtitling pipeline separates "figure out where the lines are" from "translate the lines."

## Stage 1: Transcription

**Inputs:** a raw audio file.

**Processing:**

- Whisper performs speech-to-text.
- Librosa performs audio energy analysis and beat tracking on the same audio, independent of what Whisper hears.
- The two signals are combined: segments where Librosa detects sustained musical/rhythmic energy without corresponding speech get tagged as `[Chorus]` or `[OST]` rather than left as silent gaps or mistranscribed as speech.

**Output:** a timestamped, tagged transcription: dialogue segments with accurate timing, non-verbal segments explicitly marked.

## Stage 2: Translation

**Inputs:** the transcription stage's output file (not raw audio).

**Processing:** Whisper translates the transcribed content to English, per-segment, using the existing timestamps rather than generating new ones.

**Output:** a clean English transcription with the original timing and formatting intact, ready to drop into a subtitling or dubbing workflow without a re-alignment step.

## Why Librosa matters here specifically

Whisper's speech recognition has no native concept of "this is background music, not speech" versus "this is silence." Without Librosa's energy analysis, an OST swell or a chorus section would either get force-transcribed as garbled speech-like text, or dropped as a silent gap with no indication anything was there. The energy/beat-tracking layer is what lets VISPER distinguish those cases and tag them explicitly, which is the difference between a transcript that's readable as a real document and one that's a literal but confusing speech-to-text dump.

## Data flow

```
Raw audio
    │
    ├──▶ Whisper (speech-to-text)
    │
    └──▶ Librosa (energy analysis, beat tracking)
              │
              ▼
   Combined: timestamped transcript with
   [Chorus] / [OST] tags on non-verbal segments
              │
              ▼
   Whisper (translation, using existing timestamps)
              │
              ▼
   Timestamped English transcript
```

## Datasets

The `VISPER Datasets` directory holds sample or reference audio material for exercising both notebooks. Treat it as example input material for the two pipelines above rather than as a component of the pipeline itself; see `USAGE_GUIDE.md` for how to point the notebooks at your own audio instead.
