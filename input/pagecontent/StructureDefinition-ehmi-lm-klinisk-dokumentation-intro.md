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

- **[Henvisning](01-henvisning.html)** — dokumentationen er knyttet til en henvisning
- **[Behandler](03-behandler.html)** — forfatter til dokumentet
- **[Kommunikationsbesked](08-kommunikationsbesked.html)** — kan vedhæftes en besked som bilag


---

## User stories


### Henviserens user stories


### User story 1.2 Tilknytte klinisk dokumentation

> **User story:** Som henviser ønsker jeg at kunne vedhæfte relevant klinisk dokumentation til en eksisterende henvisning, <br/>når jeg vurderer at visitatoren har brug for supplerende materiale for at træffe en god afgørelse, <br/>så beslutningsgrundlaget er samlet ét sted.

<p style="display: block;">
<img src="UC-1-2-Tilknytte-dokumentation.svg" alt="UC-1-2" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

|---|
| Henviseren vedhæfter supplerende klinisk materiale til en eksisterende henvisning — fx laboratoriesvar, billeddiagnostik eller tidligere epikriser. Materialet knyttes til `ServiceRequest`-ressourcen via referencer til `DiagnosticReport`, `Media` eller `DocumentReference`. |

|---|---|
| **Primær FHIR-ressource:** | `DiagnosticReport`, `Media`, `DocumentReference` |
| **Triggerhændelse:** | Behov for at understøtte klinisk beslutningsgrundlag |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(hvis supplerende materiale er relevant)* |
| **Næste trin:** | → [2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(visitatoren modtager den berigede henvisning)* |
{: .grid}


### Udvekslingsdialog


### User story 3.2 Besvare anmodning om supplement

> **User story:** Som henviser ønsker jeg at kunne besvare en supplement-anmodning med de efterspurgte kliniske oplysninger, <br/>når visitatoren har bedt om yderligere data, <br/>så visitatoren hurtigt kan genoptage og afslutte triage-processen.

<p style="display: block;">
<img src="UC-3-2-Besvare-supplement.svg" alt="UC-3-2" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviseren modtager en supplement-anmodning og besvarer denne ved at sende de efterspurgte oplysninger. Svaret sendes som en `Communication`-ressource med reference til den oprindelige `CommunicationRequest` og til `ServiceRequest`.

|---|---|
| **Primær FHIR-ressource:** | `Communication` (reply, in-response-to) |
| **Triggerhændelse:** | Modtagelse af CommunicationRequest fra visitatoren |
| **Forrige trin:** | ← [3.1 Anmode om supplerende oplysninger](#user-story-31-anmode-om-supplerende-oplysninger) *(supplement anmodet)* |
| **Næste trin:** | → [2.2 Triagere og prioritere en henvisning](StructureDefinition-ehmi-lm-visitationsafgoerelse.html#user-story-22-triagere-og-prioritere-en-henvisning) *(visitatoren genoptager triage med det modtagne supplement)* · <br/>→ [3.3 Faglig afklaring i dialog](#user-story-33-faglig-afklaring-i-dialog) *(hvis svaret afføder yderligere spørgsmål)* |
{: .grid}
