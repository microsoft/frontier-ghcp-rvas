# Starter Architecture Notes

The app has a React Native view layer, a small reducer, local storage behind an
interface, and a client that mimics two Azure Functions operations. The fixture
selector in the app switches between a stable connection, no signal, a flaky
warehouse connection, and a version conflict.

The seams are intentional:

- `src/storage/localStore.ts` only survives for the current JavaScript session.
- `src/sync/offlineQueue.ts` has no durable queue, retries, idempotency rule, or
  conflict decision.
- `src/platform/permissions.ts` does not call Expo Camera or Expo Location.
- Several controls are missing labels, state announcements, focus behavior, and
  tested color or target-size decisions.
- The mocked Azure Functions contract is fixed and local. Azure deployment is
  not required.

Keep domain and synchronization logic runnable in Node. Native permission and
camera adapters should sit behind interfaces so their behavior can be tested
without an emulator.
