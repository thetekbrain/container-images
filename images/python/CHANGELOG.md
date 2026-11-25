# Changelog python

## 3.13.5 – 2026-11-25 (Debian 13.8)

- Eltern-Image `base:13.8` (Debian-Point-Release 13.8): `libc6` 2.41-12+deb13u5, `libssl3t64` 3.5.9-1~deb13u1, `tzdata` 2026f-0+deb13u1 und `libzstd1` 1.5.7+dfsg-1+deb13u1 (behebt CVE-2026-124851, HIGH, Offenlegung eines internen Puffers beim Dekomprimieren, DSA-6657-1).
- Builder `debian:13.8-slim@sha256:8aa5a7bf5a1955bddbe7d74fcdd0b91ab30e74362a8b73af672b0481b35b44a0`, Snapshot `20261123T000000Z` (aus dem Builder).
- Neues Tag `3.13.5-13.8`.
- [vex.json](vex.json): Die Bewertungen von CVE-2026-107494 und CVE-2026-124709 (QUIC-DoS in libssl) gelten jetzt für `libssl3t64` 3.5.9-1~deb13u1; laut Debian-Tracker ist auch diese Version betroffen, einen Fix gibt es noch nicht.
- Python-Pakete und Bibliotheken unverändert (`3.13.5-2+deb13u5` usw., gleiche Versionen im 13.8-Snapshot). Die Beispiel-App baut ihr venv auf demselben Builder.

## 3.13.5 – 2026-11-25 (Sicherheitsupdate über base)

- `zlib1g` aus base jetzt `1:1.3.dfsg+really1.3.1-1+deb13u1` (CVE-2026-85091, HIGH, Heap-Überlauf in `gz_vacate()`).
- Neu bewertet in [vex.json](vex.json), „akzeptiert, bis es einen Fix gibt“: CVE-2026-107494 und CVE-2026-124709 (HIGH, DoS in der QUIC-Verarbeitung von `libssl3t64` 3.5.7-1~deb13u3). Betrifft nur Programme, die QUIC über libssl sprechen; Debian hat noch keinen Fix.
- Ebenfalls „akzeptiert, bis es einen Fix gibt“: CVE-2026-119373, CVE-2026-119374, CVE-2026-119379 (HIGH, `libsqlite3-0` 3.46.1-7+deb13u2: FTS5 und Session-Changesets) und CVE-2026-113351, CVE-2026-115506, CVE-2026-117610, CVE-2026-118370 (HIGH, DoS in `libexpat1` 2.9.0-1~deb13u1). Betroffen sind Apps, die nicht vertrauenswürdige Datenbankdateien öffnen bzw. nicht vertrauenswürdiges XML parsen; Debian hat noch keinen Fix.

## 3.13.5 – 2026-10-26

Erste Version, mit `-debug`-Variante.

| Baustein | Wert | ermittelt mit |
|---|---|---|
| Eltern-Image | `ghcr.io/thetekbrain/images/base:13.7` | Stammbaum |
| Builder | `debian:13.7-slim@sha256:62bd423aeee912639ca8ee681c2b762cb3e25137e0a92b20be455898a9f034ad` | wie static |
| Debian-Snapshot | `20261020T213255Z` | aus dem Builder |
| `python3.13-minimal`, `libpython3.13-minimal`, `libpython3.13-stdlib` | `3.13.5-2+deb13u5` | `apt-cache policy` gegen den Snapshot |
| `libbz2-1.0` | `1.0.8-6` | dto. |
| `libexpat1` | `2.9.0-1~deb13u1` | dto. |
| `libffi8` | `3.4.8-2` | dto. |
| `liblzma5` | `5.8.1-1+deb13u2` | dto. |
| `libsqlite3-0` | `3.46.1-7+deb13u2` | dto. |
| `libuuid1` | `2.41.5-0+deb13u1` | dto. |
| `libstdc++6`, `gcc-14-base` | `14.2.0-19` | dto.; `gcc-14-base` nur für den Lizenztext |
| Build-Stage der Beispiel-App: uv | `ghcr.io/astral-sh/uv:0.13.5@sha256:32a7bb39b496babbd997b0a39a4d66c126bdaf5661b302bf6f06abda8deca6ff` | `crane digest`; GitHub-Attestierung geprüft mit `gh attestation verify --owner astral-sh` |

Welche Bibliotheken die Standardbibliothek braucht, ergab `ldd` auf `/usr/lib/python3.13/lib-dynload/*.so`. Bewusst weggelassen, obwohl `libpython3.13-stdlib` sie als Abhängigkeit nennt: `libreadline8t64`, `libncursesw6`, `libtinfo6`, `libdb5.3t64` (und damit die Module `readline`, `_curses`, `_dbm`), `netbase`, `media-types`.
