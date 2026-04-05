# Chat MVP

## Scope

Internal platform chat for childcare operations:

- guardian <-> center communication
- internal staff/admin operational communication

## Current backend implementation

- Models:
  - `ChatConversation` (`conversationType`, child/classroom linkage, archive flag)
  - `ChatParticipant` (membership state, `lastReadMessageId`, `lastReadAt`)
  - `ChatMessage` (`senderUserId`, `body`, soft-delete through `deletedAt`)
- Endpoints:
  - `listConversations`
  - `getConversation`
  - `createConversation` (direct conversation reuse when participants match)
  - `listMessages`
  - `sendMessage`
  - `markConversationRead`
  - `unreadCounts`

## Access and isolation behavior

- Actor identity is validated through `AccessControlService`.
- Conversations/messages are organization-scoped.
- User must be an active participant to read or send messages.
- Guardian access remains constrained by participant membership and guardian-child scope checks.

## Current Flutter implementation

- Conversation list page with unread counts.
- Direct conversation creation flow (participant user id input).
- Conversation detail page with:
  - paginated message fetch
  - text composer
  - send action
  - read marker update

## Known MVP limits

- Text-first only.
- Polling/fetch-based refresh.
- No attachment upload UI yet (schema remains ready via `FileAsset`).
- No realtime stream transport yet.
