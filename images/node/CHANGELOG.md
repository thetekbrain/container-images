# Changelog node

## 24.22.1 – 2026-11-25 (Debian 13.8)

- Eltern-Image `base:13.8` (Debian-Point-Release 13.8): `libc6` 2.41-12+deb13u5, `libssl3t64` 3.5.9-1~deb13u1, `tzdata` 2026f-0+deb13u1 und `libzstd1` 1.5.7+dfsg-1+deb13u1 (behebt CVE-2026-124851, HIGH, Offenlegung eines internen Puffers beim Dekomprimieren, DSA-6657-1).
- Builder `debian:13.8-slim@sha256:8aa5a7bf5a1955bddbe7d74fcdd0b91ab30e74362a8b73af672b0481b35b44a0`, Snapshot `20261123T000000Z` (aus dem Builder).
- Neues Tag `24.22.1-13.8`.
- [vex.json](vex.json): Die Bewertungen von CVE-2026-107494 und CVE-2026-124709 (QUIC-DoS in libssl) gelten jetzt für `libssl3t64` 3.5.9-1~deb13u1; laut Debian-Tracker ist auch diese Version betroffen, einen Fix gibt es noch nicht.
- `libstdc++6` `14.2.0-19` unverändert.
- Beispiel-App: Der Build-Stage `node:24.22.1-trixie-slim` bleibt auf Debian 13.7, weil das Tag nicht mehr neu gebaut wird; glibc dort 2.41-12+deb13u4, im Image 2.41-12+deb13u5 (gleiche Version 2.41). `node:24.22.3-trixie-slim` beruht auf 13.8 und kommt mit dem Wechsel auf Node 24.22.3.

## 24.22.1 – 2026-11-25 (Sicherheitsupdate über base)

- `zlib1g` aus base jetzt `1:1.3.dfsg+really1.3.1-1+deb13u1` (CVE-2026-85091, HIGH, Heap-Überlauf in `gz_vacate()`).
- Neu bewertet in [vex.json](vex.json), „akzeptiert, bis es einen Fix gibt“: CVE-2026-107494 und CVE-2026-124709 (HIGH, DoS in der QUIC-Verarbeitung von `libssl3t64` 3.5.7-1~deb13u3). Betrifft nur Programme, die QUIC über libssl sprechen; Debian hat noch keinen Fix.

## 24.22.1 – 2026-10-26 (Nachtrag, Build-Korrektur)

- Behoben: Die CI hat dieses Image bisher auf dem Eltern-Image aus der Registry gebaut statt auf dem im selben Lauf frisch gebauten, weil BuildKit `FROM <name>:<tag>` aus der Registry auflöst, sobald es dort existiert. Betroffen waren die Veröffentlichungen der Commits `d485d40`, `6141d4f` und `58c2f24`: Ihr Eltern-Image war jeweils das des vorigen Laufs. Es unterschied sich vom frischen nur in Zeitstempeln und Labels, nicht im Inhalt. Das Eltern-Image wird jetzt per Digest des lokal gebauten Images übergeben.
- Neu: Label `org.opencontainers.image.base.digest`; `org.opencontainers.image.base.name` enthält nur noch Name und Tag.

## 24.22.1 – 2026-10-26

Erste Version, mit `-debug`-Variante.

| Baustein | Wert | ermittelt mit |
|---|---|---|
| Eltern-Image | `ghcr.io/thetekbrain/images/base:13.7` | Stammbaum |
| Node.js | `v24.22.1` (LTS Krypton, Maintenance seit 2026-10-20) | `https://nodejs.org/dist/index.json`, neueste Version mit `lts != false` |
| `node-v24.22.1-linux-x64.tar.gz` | `sha256:eb6728e77c576a35162c122c45ccadf224d89ff00abc8dae46cc2897c6002d7c` | `SHASUMS256.txt` von nodejs.org |
| `node-v24.22.1-linux-arm64.tar.gz` | `sha256:33c37be234ba8bee041961047b19160f4d7d0f164e8e246f78bdd10feff148b3` | dto. |
| Signatur von `SHASUMS256.txt` | gültig, Schlüssel `5BE8A3F6C8A5C01D106C0AD820B1A390B168D356` (Antoine du Hamel) | `gpg --verify SHASUMS256.txt.sig SHASUMS256.txt` mit `nodejs/release-keys` (`gpg-only-active-keys`) |
| `libstdc++6` | `14.2.0-19` | `ldd /usr/local/bin/node` im Builder, minus Pakete aus base |
| Builder | `debian:13.7-slim@sha256:62bd423aeee912639ca8ee681c2b762cb3e25137e0a92b20be455898a9f034ad` | wie static |
| Build-Stage der Beispiel-App | `node:24.22.1-trixie-slim@sha256:43b9ba1142b8dcf33fa8f922ca1be85714adc444e0586c7cf7726daaeabc1bea` (Debian 13.7, npm 11.19.1) | `crane digest`, `/etc/debian_version` |

Hinweis: Node 26 wird laut Release-Plan am 2026-10-28 LTS.
