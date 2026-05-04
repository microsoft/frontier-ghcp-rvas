# Stage 4: Accessibility and Performance

[Back to Challenge 4: Frontend Track](../challenge-4-frontend-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

This stage includes a pre-built component with intentional accessibility violations.

## Tasks

1. Run an axe-core accessibility audit on the entire app and fix all violations to achieve WCAG 2.1 AA compliance.
2. **Bug hunt**: Open `src/audit/AccessibleCard.tsx`. It contains 5 intentional accessibility violations: a missing alt text, no focus management on an interactive element, color-only status indicator, a missing ARIA label on an icon button, and a keyboard trap. Find and fix all five.
3. Virtualized task list: use react-window or react-virtuoso so the task list handles 10,000 tasks without jank.
4. Code splitting with `React.lazy`: dashboard, task list, and settings should load as separate chunks.
5. Performance budget: initial bundle under 200KB gzipped, LCP under 2.5 seconds.

## Verification

- axe-core reports 0 violations
- All 5 accessibility bugs in AccessibleCard.tsx are identified and fixed
- 10,000 tasks render and scroll smoothly (no dropped frames)
- Browser DevTools Network tab shows separate chunks for lazily-loaded routes
- Lighthouse performance score > 90

## What Copilot Helps With vs. What Requires Your Judgment

Copilot generates code-splitting boilerplate and axe-core setup. But identifying the 5 accessibility violations in AccessibleCard.tsx requires understanding WCAG criteria -- the keyboard trap and color-only indicator are not things a linter catches.

---

Previous: [Stage 3: Advanced Interactions](stage-3-advanced-interactions.md) | Next: [Stage 5: Integration and Testing](stage-5-integration.md)
