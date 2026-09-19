# CP-4 Browser Audio Audit

Date: 2026-09-18

## Initial finding

The app currently has no dedicated lecture-audio dependency or service. CP-4 therefore starts with a platform-neutral artifact model, lifecycle interface, and UI controls before selecting the smallest browser implementation.

## Security/privacy boundary

Microphone access must be user initiated. Audio remains local during CP-4. Media tracks must be released on Stop/dispose. No backend endpoint or credential belongs in this checkpoint.

## Implementation gate

Do not claim CP-4 complete until a real browser implementation produces a non-empty artifact and permission-denial behavior is tested.
