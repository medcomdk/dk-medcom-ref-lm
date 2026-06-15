# Entitet: Visitationsafgoerelse

**FSH LogicalModel:** `EhmiLmVisitationsafgoerelse`
**Primær FHIR-ressource:** `Task`
**User stories:** 1.6, 2.2, 2.3, 2.4, 2.5, 2.6

---

## Beskrivelse

`Visitationsafgoerelse` repræsenterer visitatorens formelle beslutning om
en indkommende henvisning. Den dokumenterer udfaldet af triage-processen
— accept, afvisning, videresendelse eller prioritetsændring — og udgør
den primære mekanisme for at kommunikere afgørelsen tilbage til henviseren.

FHIR `Task` er valgt fordi den understøtter workflow-orienterede opgaver
med status, prioritet, udfald og begrundelse.

---

## Attributter

| Attribut | Kardinalitet | Type | Beskrivelse |
|---|---|---|---|
| `afgoerelseId` | 1..1 | Identifier | Unik identifikator for afgørelsen |
| `type` | 1..1 | code | `accept` · `afvisning` · `videresendelse` · `prioritetsaendring` |
| `status` | 1..1 | code | `requested` · `received` · `accepted` · `rejected` · `completed` |
| `prioritet` | 0..1 | code | `routine` · `urgent` · `asap` · `stat` |
| `begrundelse` | 0..1 | string | Faglig begrundelse for afgørelsen (fri tekst) |
| `aarsagskode` | 0..1 | CodeableConcept | Struktureret årsag (kapacitet, indikation, forkert spor) |
| `truffetDato` | 1..1 | dateTime | Tidspunkt for afgørelsen |
| `truffetAf` | 1..1 | Reference(Behandler) | Visitatoren der har truffet afgørelsen |
| `vedroererHenvisning` | 1..1 | Reference(Henvisning) | Den henvisning afgørelsen vedrører |
| `alternativtTilbud` | 0..1 | Reference(Henvisning) | Alternativt tilbud (ved videresendelse/3.5) |

---

## FHIR-mapping

| Logisk attribut | FHIR-element | Kommentar |
|---|---|---|
| `afgoerelseId` | `Task.identifier` | |
| `type` | `Task.code` | Lokalt eller nationalt kodeset |
| `status` | `Task.status` | Bundet til `task-status` (required) |
| `prioritet` | `Task.priority` | |
| `begrundelse` | `Task.note.text` | |
| `aarsagskode` | `Task.statusReason` | |
| `truffetDato` | `Task.executionPeriod.end` | |
| `truffetAf` | `Task.owner` | Reference til Practitioner/PractitionerRole |
| `vedroererHenvisning` | `Task.focus` | Reference til ServiceRequest |
| `alternativtTilbud` | `Task.output` | Reference til ny/alternativ ServiceRequest |

---

## Relaterede entiteter

- **[Henvisning](01-henvisning.html)** — den afgørelse vedrører
- **[Behandler](03-behandler.html)** — visitatoren der afgør
- **[Statusnotifikation](09-statusnotifikation.html)** — afgørelsen udløser notifikation
- **[Booking](07-booking.html)** — oprettes ved accept


---

## User stories


### Visitatorens user stories


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
| **Forrige trin:** | ← [2.2 Triagere og prioritere](StructureDefinition-ehmi-lm-visitationsafgoerelse.html#user-story-22-triagere-og-prioritere-en-henvisning) *(positiv afgørelse)* · <br/>← [3.5 Alternativ visitation](#user-story-35-aftale-om-alternativ-visitation) *(alternativt tilbud accepteres)* · <br/>← [3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog) *(afklaring munder ud i accept)* |
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
| **Forrige trin:** | ← [2.2 Triagere og prioritere](StructureDefinition-ehmi-lm-visitationsafgoerelse.html#user-story-22-triagere-og-prioritere-en-henvisning) *(negativ afgørelse)* · <br/>← [3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog) *(afklaring munder ud i afvisning)* |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(henviser notificeres om afvisning)* · <br/>→ [3.5 Aftale om alternativ visitation](#user-story-35-aftale-om-alternativ-visitation) *(hvis alternativ løsning bør afsøges)* |
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
| **Forrige trin:** | ← [2.2 Triagere og prioritere](StructureDefinition-ehmi-lm-visitationsafgoerelse.html#user-story-22-triagere-og-prioritere-en-henvisning) *(forkert modtager identificeret)* |
| **Næste trin:** | → [2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(ny modtager starter sit eget modtagelsesflow)* · <br/>→ [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(den oprindelige henviser orienteres)* |
{: .grid}


### User story 2.6 Ændre prioritet på en modtaget henvisning

> **User story:** Som visitator ønsker jeg at kunne justere prioriteten på en allerede modtaget henvisning, <br/>når ny klinisk information eller ændret kapacitetssituation tilsiger det, <br/>så den kliniske hastegrad afspejles korrekt og henviseren notificeres om ændringen.

<p style="display: block;">
<img src="UC-2-6-Aendre-prioritet.svg" alt="UC-2-6" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren revurderer hastegraden for en allerede modtaget henvisning — fx på baggrund af ny klinisk information eller ændret kapacitetssituation. Prioriteten opdateres på `ServiceRequest` og der sendes notifikation til henviseren.

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` (priority update), `SubscriptionNotification` |
| **Triggerhændelse:** | Ny information ændrer klinisk hastegrad |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](StructureDefinition-ehmi-lm-visitationsafgoerelse.html#user-story-22-triagere-og-prioritere-en-henvisninger) *(prioritetsjustering under triage)* |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(henviser notificeres om den ændrede prioritet)* |
{: .grid}

## Udvekslingsdialog (fælles user stories)

Disse user stories forudsætter aktiv kommunikation frem og tilbage mellem henviser og visitator via FHIR-beskeder.


### Henviserens user stories


### User story 1.6 Modtage afgørelse fra visitatoren

> **User story:** Som henviser ønsker jeg automatisk at modtage visitatorens afgørelse i mit journalsystem, <br/>når visitatoren har truffet beslutning om accept, afvisning eller alternativt tilbud, <br/>så jeg hurtigt kan handle og orientere patienten.

<p style="display: block;">
<img src="UC-1-6-Modtage-afgoerelse.svg" alt="UC-1-6" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviseren modtager visitatorens endelige afgørelse — accept, afvisning eller alternativt tilbud — og integrerer denne i eget journalsystem. Afgørelsen leveres som en `Task`-ressource eller notifikation med reference til den oprindelige `ServiceRequest`.

|---|---|
| **Primær FHIR-ressource:** | `Task`, `SubscriptionNotification` |
| **Triggerhændelse:** | Visitatoren har truffet afgørelse om henvisningen |
| **Forrige trin:** | ← [1.5 Monitorere status](#user-story-12-monitorere-status-på-afsendte-henvisninger) *(statusoverblikket leder hertil)* · <br/>← [3.4 Statusnotifikation](#user-story-34-statusnotifikation-til-henviser) *(notifikation udløser håndtering)* |
| **Næste trin:** | → [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(hvis afgørelsen er en afvisning og patienten skal viderehenvisies)* · *(Flowet afsluttes ved accept)* |
{: .grid}

## Visitatorens user stories

Disse user stories udføres selvstændigt af visitatoren som led i modtagelse og behandling af indkomne henvisninger.
