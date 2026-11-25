# static

`ghcr.io/thetekbrain/images/static:13.8` · Debug: `static:13.8-debug`

Leeres Image (`scratch`) mit dem Nötigsten für statisch gelinkte Programme, auf Basis von Debian 13.8.

## Was es ist

- `/etc/passwd` und `/etc/group` mit `root` (0) und `nobody`/`nogroup` (65534)
- CA-Bundle `/etc/ssl/certs/ca-certificates.crt` aus `ca-certificates` 20250419+deb13u1.
  Es ist byteidentisch mit dem Bundle, das `update-ca-certificates` in Debian erzeugt.
- `/etc/os-release` und `/etc/debian_version` aus `base-files`, damit syft und trivy das System als Debian 13.8 erkennen
- Paket-Metadaten unter `/var/lib/dpkg/status.d/` (eine Datei pro Paket, wie bei distroless) für SBOM und CVE-Scan
- Lizenztexte der Pakete unter `/usr/share/doc/<paket>/copyright`
- Standardbenutzer `65534:65534`

Prüfen, dass das CA-Bundle mit dem von Debian übereinstimmt (gleiche Prüfsumme in beiden Zeilen):

```bash
cid=$(docker create ghcr.io/thetekbrain/images/static:13.8 none); docker cp $cid:/etc/ssl/certs/ca-certificates.crt - | tar -xOf - | shasum -a 256; docker rm $cid >/dev/null
```

```bash
docker run --rm debian:13.8-slim@sha256:8aa5a7bf5a1955bddbe7d74fcdd0b91ab30e74362a8b73af672b0481b35b44a0 sh -c 'sed -i -e "s|^# \(http://snapshot.debian.org/.*\)$|URIs: \1|" -e "/^URIs: http:\/\/deb.debian.org/d" /etc/apt/sources.list.d/debian.sources && apt-get -qq -o Acquire::Check-Valid-Until=false update && apt-get -qq install -y ca-certificates=20250419+deb13u1 >/dev/null 2>&1 && cat /etc/ssl/certs/ca-certificates.crt' | shasum -a 256
```

Der vollständige erlaubte Inhalt steht in [expected-files.txt](expected-files.txt). Abweichungen lassen `make test IMAGE=static` scheitern.

## Was es nicht ist

- **Keine Shell, kein Paketmanager, kein dpkg-Status.** Es gibt keine `/var/lib/dpkg/status` und kein apt.
- **Keine C-Bibliothek.** Dynamisch gelinkte Programme laufen hier nicht; dafür gibt es [base](../base).
- **Keine Zeitzonendaten.** Go-Programme binden sie mit `import _ "time/tzdata"` ein.
- **Kein beschreibbares `/tmp`.** Wer temporäre Dateien braucht, startet mit `--tmpfs /tmp`.

## Nutzung

```dockerfile
FROM --platform=$BUILDPLATFORM golang:1.27.3-trixie@sha256:<digest> AS build
ARG TARGETOS TARGETARCH
WORKDIR /src
COPY . .
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH \
    go build -trimpath -ldflags="-s -w -buildid=" -o /out/app .

FROM ghcr.io/thetekbrain/images/static:13.8@sha256:<digest>
COPY --from=build /out/app /app
ENTRYPOINT ["/app"]
```

Ein vollständiges Beispiel mit Healthcheck und sauberem Beenden steht in [examples/go](../../examples/go).

Empfohlener Start:

```bash
docker run --read-only --cap-drop ALL --security-opt no-new-privileges -p 8080:8080 <app-image>
```

Fehlersuche mit Shell (nie im Betrieb):

```bash
docker run --rm -it ghcr.io/thetekbrain/images/static:13.8-debug sh
```
