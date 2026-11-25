# Changelog base

## 13.7 – 2026-11-25 (Sicherheitsupdate)

- `zlib1g` `1:1.3.dfsg+really1.3.1-1+deb13u1` statt `+b1`: behebt CVE-2026-85091 (HIGH, Heap-Überlauf in `gz_vacate()`). Liegt seit `20261107T075304Z` in trixie-security, aber in keinem Builder-Image; `DEBIAN_SNAPSHOT=20261119T110923Z` (alle übrigen Pins dort unverändert vorhanden, geprüft gegen die Paketlisten von `debian` und `debian-security` für amd64 und arm64).
- Neu bewertet in [vex.json](vex.json), „akzeptiert, bis es einen Fix gibt“: CVE-2026-107494 und CVE-2026-124709 (HIGH, DoS in der QUIC-Verarbeitung von `libssl3t64` 3.5.7-1~deb13u3). Betrifft nur Programme, die QUIC über libssl sprechen; Debian hat noch keinen Fix.

## 13.7 – 2026-10-26 (Nachtrag, Build-Korrektur)

- Behoben: Die CI hat dieses Image bisher auf dem Eltern-Image aus der Registry gebaut statt auf dem im selben Lauf frisch gebauten, weil BuildKit `FROM <name>:<tag>` aus der Registry auflöst, sobald es dort existiert. Betroffen waren die Veröffentlichungen der Commits `d485d40`, `6141d4f` und `58c2f24`: Ihr Eltern-Image war jeweils das des vorigen Laufs. Es unterschied sich vom frischen nur in Zeitstempeln und Labels, nicht im Inhalt. Das Eltern-Image wird jetzt per Digest des lokal gebauten Images übergeben.
- Neu: Label `org.opencontainers.image.base.digest`; `org.opencontainers.image.base.name` enthält nur noch Name und Tag.

## 13.7 – 2026-10-26

Erste Version, mit `-debug`-Variante.

| Baustein | Wert | ermittelt mit |
|---|---|---|
| Eltern-Image | `ghcr.io/thetekbrain/images/static:13.7` | Stammbaum |
| Builder | `debian:13.7-slim@sha256:62bd423aeee912639ca8ee681c2b762cb3e25137e0a92b20be455898a9f034ad` | wie static |
| Debian-Snapshot | `20261020T213255Z` | aus dem Builder |
| `libc6` | `2.41-12+deb13u4` | `apt-cache policy` gegen den Snapshot |
| `libgcc-s1`, `gcc-14-base` | `14.2.0-19` | dto.; `gcc-14-base` nur für den Lizenztext |
| `libssl3t64` | `3.5.7-1~deb13u3` | dto. |
| `libzstd1` | `1.5.7+dfsg-1` | dto.; Abhängigkeit von `libssl3t64` |
| `zlib1g` | `1:1.3.dfsg+really1.3.1-1+b1` | dto.; Abhängigkeit von `libssl3t64` |
| `tzdata` | `2026c-0+deb13u1` | dto. |
| `busybox-static` (nur -debug) | `1:1.37.0-6+b9` | dto. |

Bewusst weggelassen, obwohl `libssl3t64` es als Abhängigkeit nennt: `openssl-provider-legacy`.
