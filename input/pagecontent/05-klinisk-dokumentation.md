# Entitet: KliniskDokumentation

**FSH LogicalModel:** `EhmiLmKliniskDokumentation`
**Primær FHIR-ressource:** `DocumentReference`, `DiagnosticReport`, `Observation`
**User stories:** 1.2

---

## Beskrivelse

`KliniskDokumentation` repræsenterer supplerende klinisk materiale der
knyttes til en Henvisning for at styrke visitators beslutningsgrundlag.
Det kan være laboratoriesvar, billeddiagnostik, epikriser, medicinlister
eller andre relevante dokumenter.

Valget af FHIR-ressource afhænger af dokumenttypen:
- **`DocumentReference`** — epikriser, PDF-dokumenter, medicinliste, samtykke
- **`DiagnosticReport`** — laboratoriesvar, billeddiagnostik med strukturerede fund
- **`Observation`** — enkeltmålinger (BMI, blodtryk, blodsukker mv.)

---

## Attributter

| Attribut | Kardinalitet | Type | Beskrivelse |
|---|---|---|---|
| `dokumentId` | 1..1 | Identifier | Unik identifikator for dokumentet |
| `type` | 1..1 | CodeableConcept | `labsvar` · `billeddiagnostik` · `epikrise` · `medicin` · `andet` |
| `titel` | 0..1 | string | Dokumentets titel eller emne |
| `dato` | 1..1 | dateTime | Dato/tidspunkt for dokumentet |
| `indhold` | 0..1 | Attachment | Dokumentindholdet (base64 eller ekstern URL) |
| `forfatter` | 0..1 | Reference(Behandler) | Den der har udstedt/registreret dokumentet |
| `relatertHenvisning` | 1..1 | Reference(Henvisning) | Den henvisning dokumentet er knyttet til |

---

## FHIR-mapping

| Logisk attribut | FHIR-element | Kommentar |
|---|---|---|
| `dokumentId` | `DocumentReference.identifier` / `DiagnosticReport.identifier` | |
| `type` | `DocumentReference.type` / `DiagnosticReport.code` | |
| `titel` | `DocumentReference.description` | |
| `dato` | `DocumentReference.date` / `DiagnosticReport.effectiveDateTime` | |
| `indhold` | `DocumentReference.content.attachment` | MIME-type + base64 eller URL |
| `forfatter` | `DocumentReference.author` / `DiagnosticReport.performer` | |
| `relatertHenvisning` | `ServiceRequest.supportingInfo` | Referencen sættes på ServiceRequest |

---

## Relaterede entiteter

- **[Henvisning](StructureDefinition-ehmi-lm-henvisning.html)** — dokumentationen er knyttet til en henvisning
- **[Behandler](StructureDefinition-ehmi-lm-behandler.html)** — forfatter til dokumentet
- **[Kommunikationsbesked](StructureDefinition-ehmi-lm-kommunikationsbesked.html)** — kan vedhæftes en besked som bilag
