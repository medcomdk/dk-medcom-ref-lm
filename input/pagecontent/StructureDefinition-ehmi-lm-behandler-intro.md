# Entitet: Behandler

**FSH LogicalModel:** `EhmiLmBehandler`
**Primær FHIR-ressource:** `Practitioner` + `PractitionerRole`
**User stories:** Alle (opretter, afsender, triagerer, afgør)

---

## Beskrivelse

`Behandler` repræsenterer en sundhedsprofessionel i flowet — enten som
**henviser** (opretter og afsender en henvisning) eller som **visitator**
(modtager, triagerer og afgør). FHIR adskiller person-identiteten
(`Practitioner`) fra rollen og organisationstilknytningen (`PractitionerRole`).

---

## Attributter

| Attribut | Kardinalitet | Type | Beskrivelse |
|---|---|---|---|
| `autorisationsId` | 1..1 | Identifier | Autorisations-ID (Sundhedsstyrelsen) |
| `navn` | 1..1 | HumanName | Fulde navn |
| `speciale` | 0..1 | CodeableConcept | Fagligt speciale (SKS-klassifikation) |
| `rolle` | 1..1 | CodeableConcept | `henviser` · `visitator` |
| `organisation` | 1..1 | Reference(Organisation) | Tilknyttet organisation |
| `direkteKontakt` | 0..1 | ContactPoint | Telefon eller sikker mail |

---

## FHIR-mapping

| Logisk attribut | FHIR-element | Kommentar |
|---|---|---|
| `autorisationsId` | `Practitioner.identifier` | System: Autorisationsregisterets OID |
| `navn` | `Practitioner.name` | |
| `speciale` | `PractitionerRole.specialty` | SKS-specialekodning |
| `rolle` | `PractitionerRole.code` | Lokalt eller nationalt rollekode-VS |
| `organisation` | `PractitionerRole.organization` | Reference til DkCoreOrganization |
| `direkteKontakt` | `Practitioner.telecom` | |

---

## Relaterede entiteter

- **[Organisation](04-organisation.html)** — behandlerens tilknytning
- **[Henvisning](01-henvisning.html)** — som afsender (`requester`)
- **[Visitationsafgoerelse](06-visitationsafgoerelse.html)** — som afgørende visitator
- **[Kommunikationsbesked](08-kommunikationsbesked.html)** — som afsender/modtager


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


### User story 2.2 Triagere og prioritere en henvisning

> **User story:** Som visitator ønsker jeg at kunne foretage en struktureret triage af en modtaget henvisning og dokumentere mit udfald, <br/>når en ny eller opdateret henvisning er klar til klinisk vurdering, <br/>så prioriteringen er sporbar og ensartet på tværs af alle indkomne sager.

<p style="display: block;">
<img src="UC-2-2-Triagere-prioritere.svg" alt="UC-2-2" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren vurderer henvisningens faglige indhold, klassificerer hastegrad og prioriterer i forhold til øvrige indkomne henvisninger. Triage-udfaldet dokumenteres i en `Task`-ressource med udfald og begrundelse.

|---|---|
| **Primær FHIR-ressource:** | `Task` (triage-outcome, priority) |
| **Triggerhændelse:** | Ny eller opdateret henvisning klar til klinisk vurdering |
| **Forrige trin:** | ← [2.1 Modtage og kvittere](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(efter kvittering påbegyndes triage)* · <br/>← [1.3 Ændre en afsendt henvisning](#user-story-13-ændre-en-afsendt-henvisning) *(ændringsnotifikation modtaget)* · <br/>← [3.2 Besvare anmodning om supplement](#user-story-32-besvare-anmodning-om-supplement) *(supplement modtaget, triage genoptages)* · <br/>← [3.6 Korrektionsaftale](#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning) *(triage genoptages efter korrektion)* |
| **Næste trin:** | → [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forløb) *(positiv afgørelse)* · <br/>→ [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(negativ afgørelse)* · <br/>→ [3.1 Anmode om supplerende oplysninger](#user-story-31-anmode-om-supplerende-oplysninger) *(grundlaget er utilstrækkeligt)* · <br/>→ [2.6 Ændre prioritet](#user-story-26-ændre-prioritet-på-en-modtaget-henvisning) *(prioriteten justeres)* |
{: .grid}


### User story 2.3 Acceptere en henvisning og booke forløb

> **User story:** Som visitator ønsker jeg at kunne acceptere en henvisning og oprette en booking, <br/>når min visitationsafgørelse er positiv, <br/>så patienten får en tid og henviseren automatisk modtager bekræftelsen.

<p style="display: block;">
<img src="UC-2-3-Acceptere-booke.svg" alt="UC-2-3" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren accepterer henvisningen og opretter et forløb. Der bookes en tid, og `ServiceRequest`-status opdateres til `active`. En `Appointment`-ressource oprettes og linkes til henvisningen.

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` (active), `Appointment` (booked) |
| **Triggerhændelse:** | Positiv visitationsafgørelse |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#22-triagere-og-prioritere-en-henvisning) *(positiv afgørelse)* · <br/>← [3.5 Alternativ visitation](#user-story-35-aftale-om-alternativ-visitation) *(alternativt tilbud accepteres)* · <br/>← [3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog) *(afklaring munder ud i accept)* |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(henviser notificeres om accept og booking)* |
{: .grid}


### User story 2.4 Afvise en henvisning

> **User story:** Som visitator ønsker jeg at kunne afvise en henvisning med en dokumenteret begrundelse, <br/>når indikationen ikke er opfyldt eller kapaciteten er nået, <br/>så henviseren forstår årsagen og kan tage stilling til næste skridt for patienten.

<p style="display: block;">
<img src="UC-2-4-Afvise-henvisning.svg" alt="UC-2-4" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren afviser henvisningen med en faglig eller kapacitetsmæssig begrundelse. `ServiceRequest`-status sættes til `revoked` eller `completed` med en `Task`-ressource der angiver årsag til afvisning.

|---|---|
| **Primær FHIR-ressource:** | `Task` (declined + reason), `ServiceRequest` |
| **Triggerhændelse:** | Indikation ikke opfyldt, forkert visitationsspor, eller kapacitetsloft nået |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#22-triagere-og-prioritere-en-henvisning) *(negativ afgørelse)* · <br/>← [3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog) *(afklaring munder ud i afvisning)* |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(henviser notificeres om afvisning)* · <br/>→ [3.5 Aftale om alternativ visitation](#user-story-35-aftale-om-alternativ-visitation) *(hvis alternativ løsning bør afsøges)* |
{: .grid}
