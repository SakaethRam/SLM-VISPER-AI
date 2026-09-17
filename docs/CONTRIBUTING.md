# Contributing

## Workflow

1. Fork the repository.
2. Create a feature branch.
3. Implement your change.
4. Test it by actually running the affected notebook end to end against a sample from `VISPER Datasets/`, not just checking that cells execute without error; a transcription/translation pipeline can run cleanly and still produce wrong timestamps or bad tags.
5. Submit a pull request with a clear description of what changed.

## Where to make changes

| Area | Location |
|------|----------|
| Transcription logic, tagging | `VISPER - Transcription Model (Whisper).ipynb` |
| Translation logic | `VISPER - Translation Model (Whisper).ipynb` |
| Dependencies | `requirements.txt` |
| CPU container | `Dockerfile` |
| GPU container | `Dockerfile.gpu` |
| Local orchestration | `docker-compose.yml` |
| CI | `.github/workflows/` |

## Notes for notebook-based contributions

- Clear cell outputs before committing where practical, so diffs show logic changes rather than noisy output/execution-count churn. If output needs to stay (e.g. to document expected results), say so in the PR description.
- If a change affects timestamp handling or the `[Chorus]`/`[OST]` tagging heuristic (see `docs/TAGGING_METHODOLOGY.md`), include a before/after example on a short audio clip so reviewers can see the actual behavioral difference, not just read a diff of notebook cells.
- Changes to the translation notebook's handling of timestamps should be tested against transcription-stage output specifically, not just raw audio, since that's the documented intended workflow (see `docs/USAGE_GUIDE.md`).

## Reporting issues

Use the repository's Issues tab for bugs, mistagged audio examples, or documentation gaps. A mistagged or mistimed segment on a specific audio file is more useful as a report if you can share (or describe) what's distinctive about that audio, since the tagging heuristic's edge cases (see `docs/TAGGING_METHODOLOGY.md`) are exactly where bug reports are most valuable.
