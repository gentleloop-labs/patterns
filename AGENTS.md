# Project instructions

## Instagram publishing with Goggles

This repository publishes to **@patternsocd**. Its Goggles destination alias is **`patternsocd`**.
Always pass `--destination patternsocd` explicitly. Do not substitute another account or use a multi-account profile unless the user specifically requests it.

Use the installed CLI at `/Users/batman/go/bin/goggles` from any working directory. The source repository is `/Users/batman/maskedsyntax/goggles`; consult its README and current CLI help when needed. If the executable is missing, run `go install ./cmd/goggles` from that source repository.

### Authorization and content

A user request to publish specified content to this project's Instagram authorizes that publication; do not ask for redundant confirmation. Requests to draft, design, preview, or prepare assets do not authorize publication. If the media, caption, or intended account is missing or ambiguous, prepare what you can and ask for the missing information before publishing.

Look for existing project assets in `/Users/batman/gentleloop-labs/patterns/social/instagram`. Use the exact files selected for the requested post; a folder containing assets is not itself authorization to publish them.

Preserve the requested caption, line breaks, emoji, hashtags, and media order. Review the actual assets before publishing. Do not add claims, change the post format, or publish to Threads or other platforms without a corresponding request.

### Shared configuration

The five projects share the installed CLI, `/Users/batman/.config/goggles/config.toml`, the database under `/Users/batman/.local/share/goggles`, and credentials in macOS Keychain. Instagram authorization and R2 hosting are already configured on this Mac. Do not set `GOGGLES_HOME`, create a separate config, replace credentials, or change shared storage settings as part of routine publishing. Never print tokens, retrieve secrets into chat, or commit credentials to this repository.

### Publishing workflow

1. Read `/Users/batman/go/bin/goggles publish --help` to confirm current support and flags.
2. Check the destination and storage:

   ```sh
   /Users/batman/go/bin/goggles account test patternsocd --json
   /Users/batman/go/bin/goggles storage status --json
   ```

3. Choose the supported command for the selected media. These are templates; replace paths and caption before use:

   ```sh
   # Reel
   /Users/batman/go/bin/goggles publish /absolute/path/reel.mp4 \
     --destination patternsocd --caption 'Approved caption' --json

   # Carousel: 2–10 images/videos in explicit order
   /Users/batman/go/bin/goggles publish /absolute/path/01.png /absolute/path/02.png \
     --destination patternsocd --caption 'Approved caption' --json
   ```

   Run the chosen command with `--dry-run` first, inspect the result, then run it without `--dry-run` for an authorized publication. A dry run is not proof that Meta will accept the live post. PNG carousel images are converted to JPEG by Goggles. For arbitrary captions, pass a structured subprocess argument array or safely quoted text; never interpolate untrusted caption text into shell code. `--at` is a YouTube option, not Instagram scheduling.

4. Inspect the JSON result for success and retain the job/media identifiers. On a timeout, partial result, or uncertain failure, inspect existing state before retrying:

   ```sh
   /Users/batman/go/bin/goggles job list --destination patternsocd --json
   /Users/batman/go/bin/goggles history list --destination patternsocd --json
   ```

   Confirm whether Instagram already published the post before creating another job. Do not use `--allow-duplicate` unless a repeat publication is explicitly requested.
5. Report the verified outcome and actual post permalink when available. Never invent a URL or claim a post is live based only on an upload/container creation.

### Current single-image limitation

As verified on 2026-09-13, Goggles supports Reels and 2–10-item carousels but does not yet implement standalone image posts. Check current help/source in case support has since been added. If it remains unsupported, explain the limitation and arrange proper single-image CLI support; do not pass a still image as a Reel, duplicate it into a carousel, or assume a temporary direct-API helper is part of the CLI. The earlier Patterns single-image test used a one-off helper and is not in normal CLI history.
