Configuration and secrets
=========================

- Do NOT store real secrets (API tokens, DB passwords, personal access tokens) in the repository.
- This project now reads configuration from two places:
  - `src/main/resources/config.properties` (classpath) — useful for local testing (placeholders only).
  - `src/main/webapp/WEB-INF/config.properties` (webapp) — used by JSP includes at runtime.

- For production, prefer environment variables or your container/CI secret store. `permisos.Config` will check environment variables and system properties as fallbacks.

- If you accidentally committed a personal access token (for example `ghp_...`) rotate it immediately and remove it from history.

How to set a real value for local testing
- Edit `src/main/resources/config.properties` and fill the placeholders, or set environment variables with the same keys (for example `DB_URL`, `DB_USER`, `DB_PASSWORD`).
