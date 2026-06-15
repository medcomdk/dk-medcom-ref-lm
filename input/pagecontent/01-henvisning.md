# Entitet: Henvisning

**FSH LogicalModel:** `EhmiLmHenvisning`
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

- **[Patient](StructureDefinition-ehmi-lm-patient.html)** — subjektet for henvisningen
- **[Behandler](StructureDefinition-ehmi-lm-behandler.html)** — den der opretter og afsender
- **[Organisation](StructureDefinition-ehmi-lm-organisation.html)** — afsender og modtager
- **[KliniskDokumentation](StructureDefinition-ehmi-lm-klinisk-dokumentation.html)** — vedlagt materiale
- **[Visitationsafgoerelse](StructureDefinition-ehmi-lm-visitationsafgoerelse.html)** — udfaldet af visitationen
- **[Booking](StructureDefinition-ehmi-lm-booking.html)** — den aftalte tid ved accept
- **[Kommunikationsbesked](StructureDefinition-ehmi-lm-kommunikationsbesked.html)** — dialog om henvisningen
- **[Statusnotifikation](StructureDefinition-ehmi-lm-statusnotifikation.html)** — notifikationer ved statusskift
