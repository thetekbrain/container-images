# Changelog java

## 21.0.13.1 – 2026-11-25 (Debian 13.8)

- Eltern-Image `base:13.8` (Debian-Point-Release 13.8): `libc6` 2.41-12+deb13u5, `libssl3t64` 3.5.9-1~deb13u1, `tzdata` 2026f-0+deb13u1 und `libzstd1` 1.5.7+dfsg-1+deb13u1 (behebt CVE-2026-124851, HIGH, Offenlegung eines internen Puffers beim Dekomprimieren, DSA-6657-1).
- Builder `debian:13.8-slim@sha256:8aa5a7bf5a1955bddbe7d74fcdd0b91ab30e74362a8b73af672b0481b35b44a0`, Snapshot `20261123T000000Z` (aus dem Builder).
- Neues Tag `21.0.13.1-13.8`.
- [vex.json](vex.json): Die Bewertungen von CVE-2026-107494 und CVE-2026-124709 (QUIC-DoS in libssl) gelten jetzt für `libssl3t64` 3.5.9-1~deb13u1; laut Debian-Tracker ist auch diese Version betroffen, einen Fix gibt es noch nicht.
- `openjdk-21-jre-headless` `21.0.13.1+2-1~deb13u1` unverändert; es liegt jetzt im Snapshot des Builders, `DEBIAN_SNAPSHOT` entfällt (auch in der Beispiel-App). `libc-bin` `2.41-12+deb13u5` (gleiche Version wie `libc6` in base).

## 21.0.13.1 – 2026-11-25

Sicherheitsupdate außer der Reihe (Debian trixie-security, 2026-11-19).

- `openjdk-21-jre-headless` `21.0.13.1+2-1~deb13u1` (trixie-security), Snapshot `20261119T110923Z` (`DEBIAN_SNAPSHOT`, auch für die Beispiel-App mit `openjdk-21-jdk-headless` derselben Version). Behebt CVE-2026-114938 (CRITICAL), CVE-2026-114939, CVE-2026-114940, CVE-2026-114941, CVE-2026-114942 (HIGH) und CVE-2026-114820 (CRITICAL, eMudhra-Misstrauen); dessen Eintrag „akzeptiert, bis es einen Fix gibt“ ist aus [vex.json](vex.json) entfernt.
- `zlib1g` aus base jetzt `1:1.3.dfsg+really1.3.1-1+deb13u1` (CVE-2026-85091, HIGH, Heap-Überlauf in `gz_vacate()`).
- Neu bewertet in [vex.json](vex.json), „akzeptiert, bis es einen Fix gibt“: CVE-2026-107494 und CVE-2026-124709 (HIGH, DoS in der QUIC-Verarbeitung von `libssl3t64` 3.5.7-1~deb13u3). Betrifft nur Programme, die QUIC über libssl sprechen; Debian hat noch keinen Fix.

## 21.0.13 – 2026-10-30

Erste Version, mit `-debug`-Variante. Erster Nutzer: GraphHopper 11.1 für Sangkhaya.

| Baustein | Wert | ermittelt mit |
|---|---|---|
| Eltern-Image | `ghcr.io/thetekbrain/images/base:13.7` | Stammbaum |
| Builder | `debian:13.7-slim@sha256:62bd423aeee912639ca8ee681c2b762cb3e25137e0a92b20be455898a9f034ad` | wie static |
| Debian-Snapshot | `20261027T195512Z` (`DEBIAN_SNAPSHOT`), statt `20261020T213255Z` aus dem Builder | `snapshot.debian.org/mr/binary/openjdk-21-jre-headless/21.0.13+9-1~deb13u2/binfiles?fileinfo=1`: `first_seen` in `debian-security` |
| `openjdk-21-jre-headless` | `21.0.13+9-1~deb13u2` (trixie-security) | Paketliste von `trixie-security`; stable hat `21.0.12.1+1-1~deb13u1` |
| `libstdc++6` | `14.2.0-19` | `ldd lib/server/libjvm.so` im Builder, minus Pakete aus base (`copy-ldd-deps.sh`) |
| `libc-bin` | `2.41-12+deb13u4`, nur `/usr/lib/locale/C.utf8` | gleiche Version wie `libc6` in base |
| Build-Stage der Beispiel-App | `openjdk-21-jdk-headless=21.0.13+9-1~deb13u2` auf demselben Builder und Snapshot | `apt-cache policy` gegen den Snapshot |

Warum 21.0.13 und nicht 21.0.12.1 aus dem Snapshot des Builders: Trivy meldet für `21.0.12.1+1-1~deb13u1` CVE-2026-91403 (CRITICAL) und CVE-2026-91415 (HIGH), beide in `21.0.13+9-1~deb13u2` behoben. Auch der neueste `debian:13.7-slim` (`sha256:f6b08b09…`, Snapshot `20261027T000000Z`) enthält das Update noch nicht. `DEBIAN_SNAPSHOT` kann weg, sobald der Builder-Digest einen späteren Snapshot hat; `extract-debs.sh` ignoriert ihn dann und meldet das im Build-Log.

Welche nativen Bibliotheken was brauchen, ergab `ldd` auf `bin/java`, `lib/*.so` und `lib/server/*.so`. Weggelassen, weil ihre Abhängigkeiten base nicht hat (Debian nennt sie als Depends bzw. Recommends): `libfontmanager.so` (freetype, harfbuzz), `libjsound.so` (ALSA), `libj2pcsc.so` (pcsclite), `libjavajpeg.so` (libjpeg62-turbo), `liblcms.so` (liblcms2-2). Ebenfalls nicht übernommen: `keytool`, `rmiregistry`, `jpackage`, `jexec`, `jar.binfmt`, `classlist` (nur für `-Xshare:dump`), `jvm.cfg-default`, die Handbuchseiten und die Konfiguration für PostScript-Fonts und Sound. `ca-certificates-java` und `java-common` werden nicht gebraucht: Den Truststore erzeugt [cacerts/CaCerts.java](cacerts/CaCerts.java) beim Build aus dem CA-Bundle des Images.

Bewertet in [vex.json](vex.json): CVE-2026-114820 (CRITICAL, Misstrauen gegen eMudhra-Zwischenzertifikate), „akzeptiert, bis es einen Fix gibt“. Laut Debian-Security-Tracker ist trixie-security `21.0.13+9-1~deb13u2` betroffen; behoben nur in sid (`21.0.13.0.3+1-1`). Das CA-Bundle enthält die drei emSign-Wurzeln von eMudhra.

Geprüft:

- `lib/tzdb.dat` hat die Zeitzonendaten 2026e (base: tzdata 2026c).

- `java -Xshare:on -XX:+PrintSharedArchiveAndExit` meldet `archive is valid` (CDS trotz normalisierter Zeitstempel).
- Ohne Locale meldete die JVM `native.encoding`, `sun.jnu.encoding` = `ANSI_X3.4-1968`; mit `C.utf8` UTF-8.
- `-m 512m` → `MaxHeapSize` 128 MiB, `-m 2g` → 512 MiB (Container-Speicherlimit erkannt).
- Memory-Mapping (`FileChannel.map`, `READ_ONLY`) einer Datei auf einem `:ro`-Volume im read-only Container.
- Standard-JVM bei `docker stop`: Exit 143.
