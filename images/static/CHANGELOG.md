# Changelog static

## 13.8 – 2026-11-25 (Debian-Point-Release)

| Baustein | Wert | ermittelt mit |
|---|---|---|
| Builder | `debian:13.8-slim@sha256:8aa5a7bf5a1955bddbe7d74fcdd0b91ab30e74362a8b73af672b0481b35b44a0` | Registry-Digest von `debian:13.8-slim` |
| Debian-Snapshot | `20261123T000000Z` | Kommentar in `/etc/apt/sources.list.d/debian.sources` des Builders |
| `base-files` | `13.8+deb13u8` | `apt-cache policy` gegen den Snapshot (amd64 und arm64) |
| `ca-certificates` | `20250419+deb13u1` | dto., unverändert |

## 13.7 – 2026-10-26 (Nachtrag)

- Label `org.opencontainers.image.licenses` nennt zusätzlich `Apache-2.0` für die eigenen Dateien (`/etc/passwd`, `/etc/group`). Inhalt unverändert.

## 13.7 – 2026-10-26

Erste Version, mit `-debug`-Variante.

| Baustein | Wert | ermittelt mit |
|---|---|---|
| Builder | `debian:13.7-slim@sha256:62bd423aeee912639ca8ee681c2b762cb3e25137e0a92b20be455898a9f034ad` | `crane digest debian:13.7-slim` |
| Debian-Snapshot | `20261020T213255Z` | Kommentar in `/etc/apt/sources.list.d/debian.sources` des Builders |
| `base-files` | `13.8+deb13u7` | `apt-cache policy base-files` gegen den Snapshot |
| `ca-certificates` | `20250419+deb13u1` | `apt-cache policy ca-certificates` gegen den Snapshot |
| `busybox-static` (nur -debug) | `1:1.37.0-6+b9` | `apt-cache policy busybox-static` gegen den Snapshot |
| Dockerfile-Frontend | `docker/dockerfile:1.28.0@sha256:bb22d9815c728170f72750f4e5b0d672e06176142e1d602c7e66c050100b7e5b` | `crane digest docker/dockerfile:1.28.0` |

`debian:13.7-slim` und `debian:trixie-20261020-slim` haben dasselbe Digest.
