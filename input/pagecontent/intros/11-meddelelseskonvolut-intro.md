# Entitet: Meddelelseskonvolut

**FSH LogicalModel:** `EhmiLmMeddelelseskonvolut`
**Primær FHIR-ressource:** `Bundle` (type=message) + `MessageHeader`
**User stories:** 1.1, 2.1

---

## Beskrivelse

`Meddelelseskonvolut` repræsenterer den tekniske ompakning der transporterer
kliniske FHIR-ressourcer (Henvisning, Visitationsafgørelse mv.) fra afsender
til modtager via EHMI og eDelivery (AS4-protokollen).

Bundle-strukturen garanterer atomicitet: alle ressourcer i en meddelelse
sendes og behandles samlet. `MessageHeader` er altid første entry og
indeholder routing-information (afsender, modtager, EHMI-endpoint) og
hændelsestype.

---

## Attributter

| Attribut | Kardinalitet | Type | Beskrivelse |
|---|---|---|---|
| `meddelelsesId` | 1..1 | id | Unik UUID for denne meddelelse |
| `haendelsestype` | 1..1 | Coding | `ny-henvisning` · `annuller` · `opdater` · `kvittering` |
| `afsendelsestidspunkt` | 1..1 | dateTime | Tidspunkt for afsendelse |
| `afsender` | 1..1 | Reference(Organisation) | Afsendende organisation |
| `modtager` | 1..* | Reference(Organisation) | Modtagende organisation(er) |
| `fokus` | 1..* | Reference | Primær klinisk ressource (Henvisning, Afgørelse mv.) |
| `kildesystem` | 1..1 | string | Afsendende systems tekniske endpoint |

---

## FHIR-mapping

| Logisk attribut | FHIR-element | Kommentar |
|---|---|---|
| `meddelelsesId` | `Bundle.id` / `MessageHeader.id` | UUID v4 |
| `haendelsestype` | `MessageHeader.eventCoding` | Fra `EHMIMessageEventCS` |
| `afsendelsestidspunkt` | `Bundle.timestamp` | |
| `afsender` | `MessageHeader.sender` | Reference til DkCoreOrganization |
| `modtager` | `MessageHeader.destination.receiver` | Reference til DkCoreOrganization |
| `fokus` | `MessageHeader.focus` | Reference til ServiceRequest el. Task |
| `kildesystem` | `MessageHeader.source.endpoint` | Teknisk endpoint URL |

---

## Bundle-struktur

```
Bundle (type: message)
 ├── [0] MessageHeader        ← Altid første entry
 ├── [1] ServiceRequest       ← Primær klinisk payload (Henvisning)
 ├── [2] Patient              ← Den patient der henvises
 ├── [3] Practitioner         ← Henvisende behandler
 ├── [4] PractitionerRole     ← Rolle og organisation
 ├── [5] Organization (afs.)  ← Afsendende organisation
 ├── [6] Organization (mod.)  ← Modtagende organisation
 └── [n] DiagnosticReport/    ← Evt. supplerende dokumentation
         DocumentReference
```

---

## Relaterede entiteter

- **[Organisation](04-organisation.html)** — afsender og modtager
- **[Henvisning](01-henvisning.html)** — den primære kliniske payload
- **[Visitationsafgoerelse](06-visitationsafgoerelse.html)** — kan transporteres som fokus


---

## User stories


### Henviserens user stories


### User story 1.1 Oprette en ny henvisning

> **User story:** Som henviser ønsker jeg at kunne oprette og afsende en struktureret henvisning via FHIR, <br/>når jeg har truffet en klinisk beslutning om at viderehenvise en patient, <br/>så visitatoren modtager alle nødvendige oplysninger på et standardiseret format.

<p style="display: block;">
<img src="UC-1-1-Oprette-henvisning.svg" alt="UC-1-1" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

|---|
| Henviseren udfærdiger og afsender en ny henvisning til et modtagende tilbud. Henvisningen repræsenteres som en `ServiceRequest`-ressource med status `proposed` og sendes i en FHIR-`Bundle`. Henvisningen indeholder patientoplysninger, indikation, hastegrad og ønsket ydelse. |

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` |
| **Triggerhændelse:** | Klinisk beslutning om at henvise patient |
| **Næste trin:** |→ [1.2 Tilknytte klinisk dokumentation](#user-story-12-tilknytte-klinisk-dokumentation) *(hvis supplerende materiale er relevant)* · <br/>→ [2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(visitatorsiden modtager)* |
{: .grid}


### Visitatorens user stories


### User story 2.1 Modtage og kvittere for ny henvisning

> **User story:** Som visitator ønsker jeg automatisk at modtage og kvittere for indkomne henvisninger via FHIR, <br/>når en ny `ServiceRequest` ankommer i mit endpoint, <br/>så afsenderen hurtigt får bekræftet at henvisningen er modtaget korrekt.

<p style="display: block;">
<img src="UC-2-1-Modtage-kvittere.svg" alt="UC-2-1" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren modtager en indkommende FHIR-`Bundle` med en ny `ServiceRequest` og sender en teknisk kvittering (ACK) tilbage til afsendersystemet. Henvisningen registreres i visitationssystemet med status `active` eller `on-hold` afhængigt af triagekapacitet.

|---|---|
| **Primær FHIR-ressource:** | `Bundle`, `MessageHeader`, `ServiceRequest` |
| **Triggerhændelse:** | Indkommende henvisning i FHIR-endpoint |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(afsendelse af ny henvisning)* · <br/>← [1.2 Tilknytte klinisk dokumentation](#user-story-12-tilknytte-klinisk-dokumentation) *(beriget henvisning modtages)* · <br/>← [2.5 Videresende](#user-story-25-videresende-til-anden-modtager) *(ny modtager starter modtagelsesflow)* |
| **Næste trin:** | → [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) |
{: .grid}
