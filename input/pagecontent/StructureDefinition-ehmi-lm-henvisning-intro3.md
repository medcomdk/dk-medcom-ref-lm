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

### User story 1.1 Oprette en ny henvisning
[user-story-11-oprette-en-ny-henvisning](fhir-henvisning-user-stories-v2-claude.html#user-story-11-oprette-en-ny-henvisning)

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


### User story 1.3 Ændre en afsendt henvisning

> **User story:** Som henviser ønsker jeg at kunne rette indholdet i en allerede afsendt henvisning, <br/>når jeg opdager en fejl eller patientens kliniske situation ændrer sig, <br/>så visitatoren altid arbejder ud fra korrekte og aktuelle oplysninger.

<p style="display: block;">
<img src="UC-1-3-Aendre-henvisning.svg" alt="UC-1-3" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviseren opdaterer indholdet af en allerede afsendt henvisning — fx korrigerer indikation, hastegrad eller kontaktoplysninger. Opdateringen sker via en opdatering på den eksisterende `ServiceRequest`, og der sættes et revisionsflag så visitatoren notificeres om ændringen.

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` (revision) |
| **Triggerhændelse:** | Fejl opdaget eller klinisk situation ændret efter afsendelse |
| **Forrige trin:** | ← [3.6 Korrektionsaftale](#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning) *(visitatoren anmoder om korrektion)* |
| **Næste trin:** | → [2.2 Triagere og prioritere en henvisning](StructureDefinition-ehmi-lm-visitationsafgoerelse.html#user-story-22-triagere-og-prioritere-en-henvisning) *(visitatoren modtager ændringsnotifikation og reviagerer)* |
{: .grid}


### User story 1.4 Tilbagekalde en henvisning

> **User story:** Som henviser ønsker jeg at kunne tilbagekalde en afsendt henvisning, <br/>når patienten ikke længere ønsker forløbet eller det kliniske grundlag er bortfaldet, <br/>så visitatoren ikke bruger ressourcer på en henvisning der ikke skal ekspederes.

<p style="display: block;">
<img src="UC-1-4-Tilbagekalde-henvisning.svg" alt="UC-1-4" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviseren annullerer en afsendt henvisning, der endnu ikke er ekspederet. `ServiceRequest`-status sættes til `revoked` og en notifikation sendes til visitatoren.

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` (status = revoked) |
| **Triggerhændelse:** | Patienten ønsker ikke forløbet, eller klinisk grundlag er bortfaldet |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(afsender ønsker at tilbagekalde)* |
| **Næste trin:** | *(Flowet afsluttes — ingen yderligere behandling påkrævet)* | |
{: .grid}


### Visitatorens user stories


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


### Udvekslingsdialog


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

