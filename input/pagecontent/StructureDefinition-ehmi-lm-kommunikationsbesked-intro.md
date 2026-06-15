# Entitet: Kommunikationsbesked

**FSH LogicalModel:** `EhmiLmKommunikationsbesked`
**Primær FHIR-ressource:** `Communication`, `CommunicationRequest`
**User stories:** 3.1, 3.2, 3.3, 3.5, 3.6

---

## Beskrivelse

`Kommunikationsbesked` repræsenterer enhver struktureret besked der
udveksles direkte mellem henviser og visitator som led i dialogen om
en konkret henvisning. Det dækker fem scenarier:

| Scenarie | Type | FHIR-ressource |
|---|---|---|
| Anmodning om supplement (3.1) | `anmodning` | `CommunicationRequest` |
| Svar på supplement (3.2) | `svar` | `Communication` |
| Faglig afklaringsdialog (3.3) | `afklaring` | `Communication` (tråd) |
| Aftale om alternativ visitation (3.5) | `afklaring` | `Communication` |
| Korrektionsaftale (3.6) | `korrektionsaftale` | `Communication` |

Dialogtråde (3.3) modelleres som kæder af `Communication`-ressourcer
bundet sammen via `inResponseTo`-feltet.

---

## Attributter

| Attribut | Kardinalitet | Type | Beskrivelse |
|---|---|---|---|
| `beskedId` | 1..1 | Identifier | Unik identifikator for beskeden |
| `type` | 1..1 | code | `anmodning` · `svar` · `afklaring` · `notifikation` · `korrektionsaftale` |
| `status` | 1..1 | code | `preparation` · `in-progress` · `completed` · `entered-in-error` |
| `emne` | 0..1 | string | Kort emne eller titel |
| `indhold` | 1..1 | string | Beskedens tekstindhold |
| `sendt` | 1..1 | dateTime | Afsendelsestidspunkt |
| `afsender` | 1..1 | Reference(Behandler) | Den der har afsendt beskeden |
| `modtager` | 1..* | Reference(Behandler) | Den eller de der modtager beskeden |
| `svarPaa` | 0..1 | Reference(Kommunikationsbesked) | Reference til den besked der besvares |
| `vedroererHenvisning` | 1..1 | Reference(Henvisning) | Den henvisning kommunikationen vedrører |
| `bilag` | 0..* | Reference(KliniskDokumentation) | Eventuelle vedlagte dokumenter |

---

## FHIR-mapping

| Logisk attribut | FHIR-element | Kommentar |
|---|---|---|
| `beskedId` | `Communication.identifier` | |
| `type` | `Communication.category` | Lokalt kodeset for beskedtype |
| `status` | `Communication.status` | |
| `emne` | `Communication.topic` | |
| `indhold` | `Communication.payload.contentString` | |
| `sendt` | `Communication.sent` | |
| `afsender` | `Communication.sender` | |
| `modtager` | `Communication.recipient` | |
| `svarPaa` | `Communication.inResponseTo` | Knytter tråden (3.3) |
| `vedroererHenvisning` | `Communication.basedOn` | Reference til ServiceRequest |
| `bilag` | `Communication.payload` | `contentReference` til DocumentReference |

For supplement-**anmodninger** (3.1) anvendes `CommunicationRequest` hvor
`CommunicationRequest.basedOn` refererer til `ServiceRequest`.

---

## Relaterede entiteter

- **[Henvisning](01-henvisning.html)** — alle beskeder vedrører en konkret henvisning
- **[Behandler](03-behandler.html)** — afsender og modtager
- **[KliniskDokumentation](05-klinisk-dokumentation.html)** — vedlagte bilag


---

## User stories


### Udvekslingsdialog


### User story 3.1 Anmode om supplerende oplysninger

> **User story:** Som visitator ønsker jeg at kunne sende en struktureret anmodning om supplerende oplysninger til henviseren, <br/>når grundlaget for triage er utilstrækkeligt, <br/>så jeg kan træffe en fagligt forsvarlig visitationsafgørelse uden at afvise unødigt.

<p style="display: block;">
<img src="UC-3-1-Anmode-supplement.svg" alt="UC-3-1" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren mangler oplysninger for at kunne triagere og sender en struktureret anmodning til henviseren om at supplere med konkrete kliniske data — fx blodprøveresultater, BMI, medicinliste eller tidligere forløb.

|---|---|
| **Primær FHIR-ressource:** | `CommunicationRequest` (fra visitator til henviser) |
| **Triggerhændelse:** | Utilstrækkeligt grundlag for visitationsafgørelse |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](StructureDefinition-ehmi-lm-visitationsafgoerelse.html#user-story-22-triagere-og-prioritere-en-henvisning) *(utilstrækkeligt grundlag for triage)* |
| **Næste trin:** | → [3.2 Besvare anmodning om supplement](#user-story-32-besvare-anmodning-om-supplement) |
{: .grid}


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


### User story 3.3 Faglig afklaring i dialog

> **User story:** Som henviser og visitator ønsker vi begge at kunne føre en struktureret faglig dialog om en konkret henvisning, <br/>når indikation, egnethed eller behandlingsvalg er uklart, <br/>så vi i fællesskab kan nå frem til den rigtige afgørelse for patienten uden at skulle bruge andre kommunikationskanaler.

<p style="display: block;">
<img src="UC-3-3-Faglig-afklaring.svg" alt="UC-3-3" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviser og visitator udveksler kliniske spørgsmål og svar for at afklare indikation, behandlingsegnethed eller alternativ tilgang — uden at dette nødvendigvis afklares i én besked. Dialogen føres som en kæde af `Communication`-ressourcer med indbyrdes referencer.

|---|---|
| **Primær FHIR-ressource:** | `Communication` (thread med in-response-to-kæde) |
| **Triggerhændelse:** | Faglig uklarhed der kræver mere end én udveksling |
| **Forrige trin:** | ← [3.2 Besvare anmodning om supplement](#user-story-32-besvare-anmodning-om-supplement) *(svaret afføder yderligere spørgsmål)* |
| **Næste trin:** | → [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forløb) *(afklaring munder ud i accept)* · <br/>→ [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(afklaring munder ud i afvisning)* |
{: .grid}


### User story 3.5 Aftale om alternativ visitation

> **User story:** Som visitator ønsker jeg at kunne indlede en dialog med henviseren om et alternativt tilbud, <br/>når jeg ikke kan imødekomme den primære henvisning, <br/>så patienten ikke ender i en blindgyde og vi i fællesskab finder en løsning.

<p style="display: block;">
<img src="UC-3-5-Alternativ-visitation.svg" alt="UC-3-5" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviser og visitator forhandler i fællesskab om et alternativt tilbud, <br/>når det primære visitationsspor ikke er muligt. Dialogen foregår via `Communication`, og den resulterende aftale dokumenteres i en `Task` med reference til det alternative tilbud.

|---|---|
| **Primær FHIR-ressource:** | `Communication`, `Task`, `ServiceRequest` (alternativ) |
| **Triggerhændelse:** | Afvisning kombineret med behov for at finde alternativ løsning for patienten |
| **Forrige trin:** | ← [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(afvisning kombineret med søgning efter alternativ)* |
| **Næste trin:** | → [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(nyt alternativt tilbud kræver ny henvisning)* · <br/>→ [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forløb) *(alternativt tilbud accepteres)* |
{: .grid}


### User story 3.6 Korrektionsaftale om fejl i afsendt henvisning

> **User story:** Som visitator ønsker jeg at kunne kontakte henviseren og aftale en korrektion, <br/>når jeg opdager en fejl i en modtaget henvisning, <br/>så fejlen rettes på en koordineret og sporbar måde uden at vi mister historikken.

<p style="display: block;">
<img src="UC-3-6-Korrektionsaftale.svg" alt="UC-3-6" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren opdager en fejl i en modtaget henvisning — fx forkert CPR-nummer, forkert ydelseskode eller manglende samtykkedokumentation — og indleder en dialog med henviseren om korrektion. Korrektionen aftales via `Communication`-besked og gennemføres med en efterfølgende opdatering af `ServiceRequest`.

|---|---|
| **Primær FHIR-ressource:** | `Communication`, `ServiceRequest` (korrektion) |
| **Triggerhændelse:** | Fejl opdaget under modtagelse eller triage hos visitatoren |
| **Forrige trin:** | ← [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(fejl opdaget, korrektionsdiolog indledes)* |
| **Næste trin:** | → [1.3 Ændre en afsendt henvisning](#user-story-13-ændre-en-afsendt-henvisning) *(henviser retter og sender)* · <br/>→ [2.2 Triagere og prioritere en henvisning](StructureDefinition-ehmi-lm-visitationsafgoerelse.html#user-story-22-triagere-og-prioritere-en-henvisning) *(visitatoren genoptager triage efter korrektion)* |
{: .grid}
