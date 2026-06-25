# Entitet: Henvisning

**FSH LogicalModel:** `LmHenvisning`

**Primær FHIR-ressource:** `ServiceRequest`

**User stories:** 1.1, 1.3, 1.4, 2.3, 2.4, 2.5, 2.6, 3.6

---

## Beskrivelse

`Henvisning` er den centrale entitet i hele flowet. Den repræsenterer en
klinisk anmodning om at viderehenvise en patient til et specialtilbud,
en undersøgelse eller en behandling. Alle øvrige entiteter relaterer sig
direkte eller indirekte til Henvisningen.

En Henvisning gennemgår en veldefineret livscyklus fra oprettelse til
afslutning og kan undervejs blive rettet, tilbagekaldt, videresendt
eller resultere i en booking.

---

## Attributter

| Attribut | Kardinalitet | Type | Beskrivelse |
|---|---|---|---|
| `henvisningsId` | 1..1 | Identifier | Unik identifikator for henvisningen |
| `status` | 1..1 | code | `proposed` · `active` · `on-hold` · `revoked` · `completed` |
| `prioritet` | 1..1 | code | `routine` · `urgent` · `asap` · `stat` |
| `oprettetDato` | 1..1 | dateTime | Tidspunkt for oprettelse |
| `aendretDato` | 0..1 | dateTime | Tidspunkt for seneste rettelse |
| `ydelseskode` | 1..1 | CodeableConcept | Ønsket ydelse eller specialale (SKS/SNOMED CT) |
| `indikation` | 1..* | CodeableConcept | Klinisk indikation / diagnose |
| `kliniskNote` | 0..1 | string | Anamnese, aktuelle problemer, begrundelse (fri tekst) |
| `oensketTidspunkt` | 0..1 | dateTime | Ønsket tidspunkt for undersøgelse eller behandling |
| `erstattetAf` | 0..1 | Reference(Henvisning) | Reference til ny/revideret henvisning (`replaces`) |
| `patient` | 1..1 | Reference(Patient) | Den patient der viderehenvises |
| `henviser` | 1..1 | Reference(Behandler) | Den behandler der opretter og afsender |
| `afsenderOrganisation` | 1..1 | Reference(Organisation) | Afsendende organisation |
| `modtagerOrganisation` | 1..1 | Reference(Organisation) | Modtagende organisation (visitator) |
| `dokumentation` | 0..* | Reference(KliniskDokumentation) | Vedlagte kliniske bilag og resultater |
| `booking` | 0..1 | Reference(Booking) | Tilknyttet booking ved accept |
{: .grid}
---

## FHIR-mapping

| Logisk attribut | FHIR-element | Kommentar |
|---|---|---|
| `henvisningsId` | `ServiceRequest.identifier` | Lokalt journal-nr. + evt. SOR-baseret id |
| `status` | `ServiceRequest.status` | Bundet til `request-status` (required) |
| `prioritet` | `ServiceRequest.priority` | Bundet til `request-priority` (required) |
| `oprettetDato` | `ServiceRequest.authoredOn` | |
| `aendretDato` | `ServiceRequest.meta.lastUpdated` | |
| `ydelseskode` | `ServiceRequest.code` | SKS-procedurekode eller SNOMED CT |
| `indikation` | `ServiceRequest.reasonCode` | SKS-diagnosekode eller SNOMED CT |
| `kliniskNote` | `ServiceRequest.note.text` | |
| `oensketTidspunkt` | `ServiceRequest.occurrenceDateTime` | |
| `erstattetAf` | `ServiceRequest.replaces` | Anvendes ved videresendelse (2.5) |
| `patient` | `ServiceRequest.subject` | Reference til DkCorePatient |
| `henviser` | `ServiceRequest.requester` | Reference til Practitioner/PractitionerRole |
| `afsenderOrganisation` | `ServiceRequest.requester` (via PractitionerRole) | |
| `modtagerOrganisation` | `ServiceRequest.performer` | Reference til DkCoreOrganization |
| `dokumentation` | `ServiceRequest.supportingInfo` | References til DiagnosticReport, DocumentReference m.fl. |
| `booking` | `ServiceRequest.basedOn` (Appointment) | Oprettes ved accept (2.3) |
{: .grid}

---

## Livscyklus

```
[proposed]  →  oprettet og afsendt (1.1)
    │
    ▼
[active]    →  modtaget og under behandling hos visitator
    │
    ├── [on-hold]    →  afventer supplement (3.1)
    │       └── [active]  →  supplement modtaget (3.2)
    │
    ├── [revoked]   →  tilbagekaldt af henviser (1.4) eller afvist (2.4)
    │
    └── [completed] →  accepteret og booklet (2.3)
```

---

## Relaterede entiteter

- **[Patient](02-patient.html)** — subjektet for henvisningen
- **[Behandler](03-behandler.html)** — den der opretter og afsender
- **[Organisation](04-organisation.html)** — afsender og modtager
- **[KliniskDokumentation](05-klinisk-dokumentation.html)** — vedlagt materiale
- **[Visitationsafgoerelse](06-visitationsafgoerelse.html)** — udfaldet af visitationen
- **[Booking](07-booking.html)** — den aftalte tid ved accept
- **[Kommunikationsbesked](08-kommunikationsbesked.html)** — dialog om henvisningen
- **[Statusnotifikation](09-statusnotifikation.html)** — notifikationer ved statusskift

---

## User stories

### Henviserens user stories

#### User story 1.1 Oprette en ny henvisning

- [user-story-11-oprette-en-ny-henvisning](fhir-henvisning-user-stories-v2-claude.html#user-story-11-oprette-en-ny-henvisning)

#### User story 1.3 Ændre en afsendt henvisning

- [user-story-13-ændre-en-afsendt-henvisning](fhir-henvisning-user-stories-v2-claude.html#user-story-13-ændre-en-afsendt-henvisning)

#### User story 1.4 Tilbagekalde en henvisning

- [user-story-14-tilbagekalde-en-henvisning](fhir-henvisning-user-stories-v2-claude.html#user-story-14-tilbagekalde-en-henvisning)

### Visitatorens user stories

#### User story 2.3 Acceptere en henvisning og booke forløb

- [user-story-23-acceptere-en-henvisning-og-booke-forløb](fhir-henvisning-user-stories-v2-claude.html#user-story-23-acceptere-en-henvisning-og-booke-forløb)

#### User story 2.4 Afvise en henvisning

- [user-story-24-afvise-en-henvisning](fhir-henvisning-user-stories-v2-claude.html#user-story-24-afvise-en-henvisning)

#### User story 2.5 Videresende til anden modtager

- [user-story-25-videresende-til-anden-modtager](fhir-henvisning-user-stories-v2-claude.html#user-story-25-videresende-til-anden-modtager)

#### User story 2.6 Ændre prioritet på en modtaget henvisning

- [user-story-26-ændre-prioritet-på-en-modtaget-henvisning](fhir-henvisning-user-stories-v2-claude.html#user-story-26-ændre-prioritet-på-en-modtaget-henvisning)

## Udvekslingsdialog (fælles user stories)

Disse user stories forudsætter aktiv kommunikation frem og tilbage mellem henviser og visitator via FHIR-beskeder.

### Udvekslingsdialog

#### User story 3.6 Korrektionsaftale om fejl i afsendt henvisning

- [user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning](fhir-henvisning-user-stories-v2-claude.html#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning)

