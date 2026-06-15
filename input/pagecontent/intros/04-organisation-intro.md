# Entitet: Organisation

**FSH LogicalModel:** `EhmiLmOrganisation`
**Primær FHIR-ressource:** `Organization` (DkCoreOrganization)
**User stories:** 1.1, 2.1, 2.5

---

## Beskrivelse

`Organisation` repræsenterer en sundhedsorganisation der enten afsender
eller modtager henvisninger via EHMI. SOR-koden er den primære nationale
identifikator, og EHMI-endpointet er den tekniske adresse i eDelivery-infrastrukturen.

---

## Attributter

| Attribut | Kardinalitet | Type | Beskrivelse |
|---|---|---|---|
| `sorKode` | 1..1 | Identifier | SOR-kode (Sundhedsorganisationsregisteret) |
| `glnNummer` | 0..1 | Identifier | GLN-nummer (Global Location Number) |
| `ydernummer` | 0..1 | Identifier | Ydernummer (praksis-identifikator) |
| `navn` | 1..1 | string | Organisationens navn |
| `type` | 1..1 | CodeableConcept | `hospital` · `praksis` · `speciallaegepraksis` · `kommunal` |
| `adresse` | 0..1 | Address | Organisationens adresse |
| `ehmiEndpoint` | 1..1 | url | EHMI/eDelivery endpoint (AP-adresse) |
| `overordnetOrganisation` | 0..1 | Reference(Organisation) | Fx region eller hospital |

---

## FHIR-mapping

| Logisk attribut | FHIR-element | Kommentar |
|---|---|---|
| `sorKode` | `Organization.identifier` | System: `https://www.esundhed.dk/NamingSystem/SOR` |
| `glnNummer` | `Organization.identifier` | System: GLN OID |
| `ydernummer` | `Organization.identifier` | System: Ydernummer-OID |
| `navn` | `Organization.name` | |
| `type` | `Organization.type` | |
| `adresse` | `Organization.address` | |
| `ehmiEndpoint` | `Organization.endpoint` | Reference til FHIR Endpoint-ressource med EHMI URL |
| `overordnetOrganisation` | `Organization.partOf` | |

---

## Relaterede entiteter

- **[Behandler](03-behandler.html)** — behandlere er tilknyttet en organisation
- **[Henvisning](01-henvisning.html)** — afsender og modtager-organisation
- **[Abonnement](10-abonnement.html)** — organisationen er abonnent
- **[Meddelelseskonvolut](11-meddelelseskonvolut.html)** — routing via SOR/EHMI


---

## User stories


### Relevante user stories


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


### User story 2.5 Videresende til anden modtager

> **User story:** Som visitator ønsker jeg at kunne videresende en fejlplaceret henvisning til rette modtager, <br/>når jeg vurderer at et andet tilbud er bedre egnet, <br/>så patienten ikke unødigt forsinkes og henviseren holdes orienteret om omdirigeringen.

<p style="display: block;">
<img src="UC-2-5-Videresende.svg" alt="UC-2-5" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren vurderer at henvisningen hører hjemme et andet sted og videresender. Der oprettes en ny `ServiceRequest` med reference til den originale via `replaces`-attributten, og der sendes notifikation til den oprindelige henviser.

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` (replaces), `Task`, `Communication` |
| **Triggerhændelse:** | Forkert modtager eller bedre egnet tilbud identificeret |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning) *(forkert modtager identificeret)* |
| **Næste trin:** | → [2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(ny modtager starter sit eget modtagelsesflow)* · <br/>→ [3.4 Statusnotifikation til henviser](#34-statusnotifikation-til-henviser) *(den oprindelige henviser orienteres)* |
{: .grid}
