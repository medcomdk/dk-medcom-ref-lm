# Henvisning - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Henvisning**

## Logical Model: Henvisning 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-henvisning | *Version*:0.1.0 |
| Draft as of 2026-06-16 | *Computable Name*:Henvisning |

 
Repræsenterer en klinisk anmodning om at viderehenvise en patient til et specialtilbud eller en ydelse. Svarer til FHIR ServiceRequest. Dækker hele livscyklussen fra oprettelse til afslutning. 

# Entitet: Henvisning

**FSH LogicalModel:** `EhmiLmHenvisning` **Primær FHIR-ressource:** `ServiceRequest` **User stories:** 1.1, 1.3, 1.4, 2.3, 2.4, 2.5, 2.6, 3.6

-------

## Beskrivelse

`Henvisning` er den centrale entitet i hele flowet. Den repræsenterer en klinisk anmodning om at viderehenvise en patient til et specialtilbud, en undersøgelse eller en behandling. Alle øvrige entiteter relaterer sig direkte eller indirekte til Henvisningen.

En Henvisning gennemgår en veldefineret livscyklus fra oprettelse til afslutning og kan undervejs blive rettet, tilbagekaldt, videresendt eller resultere i en booking.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `henvisningsId` | 1..1 | Identifier | Unik identifikator for henvisningen |
| `status` | 1..1 | code | `proposed`·`active`·`on-hold`·`revoked`·`completed` |
| `prioritet` | 1..1 | code | `routine`·`urgent`·`asap`·`stat` |
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

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `henvisningsId` | `ServiceRequest.identifier` | Lokalt journal-nr. + evt. SOR-baseret id |
| `status` | `ServiceRequest.status` | Bundet til`request-status`(required) |
| `prioritet` | `ServiceRequest.priority` | Bundet til`request-priority`(required) |
| `oprettetDato` | `ServiceRequest.authoredOn` |   |
| `aendretDato` | `ServiceRequest.meta.lastUpdated` |   |
| `ydelseskode` | `ServiceRequest.code` | SKS-procedurekode eller SNOMED CT |
| `indikation` | `ServiceRequest.reasonCode` | SKS-diagnosekode eller SNOMED CT |
| `kliniskNote` | `ServiceRequest.note.text` |   |
| `oensketTidspunkt` | `ServiceRequest.occurrenceDateTime` |   |
| `erstattetAf` | `ServiceRequest.replaces` | Anvendes ved videresendelse (2.5) |
| `patient` | `ServiceRequest.subject` | Reference til DkCorePatient |
| `henviser` | `ServiceRequest.requester` | Reference til Practitioner/PractitionerRole |
| `afsenderOrganisation` | `ServiceRequest.requester`(via PractitionerRole) |   |
| `modtagerOrganisation` | `ServiceRequest.performer` | Reference til DkCoreOrganization |
| `dokumentation` | `ServiceRequest.supportingInfo` | References til DiagnosticReport, DocumentReference m.fl. |
| `booking` | `ServiceRequest.basedOn`(Appointment) | Oprettes ved accept (2.3) |

-------

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

-------

## Relaterede entiteter

* **[Patient](02-patient.md)** — subjektet for henvisningen
* **[Behandler](03-behandler.md)** — den der opretter og afsender
* **[Organisation](04-organisation.md)** — afsender og modtager
* **[KliniskDokumentation](05-klinisk-dokumentation.md)** — vedlagt materiale
* **[Visitationsafgoerelse](06-visitationsafgoerelse.md)** — udfaldet af visitationen
* **[Booking](07-booking.md)** — den aftalte tid ved accept
* **[Kommunikationsbesked](08-kommunikationsbesked.md)** — dialog om henvisningen
* **[Statusnotifikation](09-statusnotifikation.md)** — notifikationer ved statusskift

-------

## User stories

### Henviserens user stories

### User story 1.1 Oprette en ny henvisning

> **User story:** Som henviser ønsker jeg at kunne oprette og afsende en struktureret henvisning via FHIR, 
når jeg har truffet en klinisk beslutning om at viderehenvise en patient, 
så visitatoren modtager alle nødvendige oplysninger på et standardiseret format.

 ![](UC-1-1-Oprette-henvisning.svg) 

| |
| :--- |
| Henviseren udfærdiger og afsender en ny henvisning til et modtagende tilbud. Henvisningen repræsenteres som en`ServiceRequest`-ressource med status`proposed`og sendes i en FHIR-`Bundle`. Henvisningen indeholder patientoplysninger, indikation, hastegrad og ønsket ydelse. |

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `ServiceRequest` |
| **Triggerhændelse:** | Klinisk beslutning om at henvise patient |
| **Næste trin:** | →[1.2 Tilknytte klinisk dokumentation](#user-story-12-tilknytte-klinisk-dokumentation)**(hvis supplerende materiale er relevant)**·→[2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning)**(visitatorsiden modtager)** |

### User story 1.3 Ændre en afsendt henvisning

> **User story:** Som henviser ønsker jeg at kunne rette indholdet i en allerede afsendt henvisning, 
når jeg opdager en fejl eller patientens kliniske situation ændrer sig, 
så visitatoren altid arbejder ud fra korrekte og aktuelle oplysninger.

 ![](UC-1-3-Aendre-henvisning.svg) 

Henviseren opdaterer indholdet af en allerede afsendt henvisning — fx korrigerer indikation, hastegrad eller kontaktoplysninger. Opdateringen sker via en opdatering på den eksisterende `ServiceRequest`, og der sættes et revisionsflag så visitatoren notificeres om ændringen.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `ServiceRequest`(revision) |
| **Triggerhændelse:** | Fejl opdaget eller klinisk situation ændret efter afsendelse |
| **Forrige trin:** | ←[3.6 Korrektionsaftale](#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning)**(visitatoren anmoder om korrektion)** |
| **Næste trin:** | →[2.2 Triagere og prioritere en henvisning](StructureDefinition-ehmi-lm-visitationsafgoerelse.md#user-story-22-triagere-og-prioritere-en-henvisning)**(visitatoren modtager ændringsnotifikation og reviagerer)** |

### User story 1.4 Tilbagekalde en henvisning

> **User story:** Som henviser ønsker jeg at kunne tilbagekalde en afsendt henvisning, 
når patienten ikke længere ønsker forløbet eller det kliniske grundlag er bortfaldet, 
så visitatoren ikke bruger ressourcer på en henvisning der ikke skal ekspederes.

 ![](UC-1-4-Tilbagekalde-henvisning.svg) 

Henviseren annullerer en afsendt henvisning, der endnu ikke er ekspederet. `ServiceRequest`-status sættes til `revoked` og en notifikation sendes til visitatoren.

| | | |
| :--- | :--- | :--- |
| **Primær FHIR-ressource:** | `ServiceRequest`(status = revoked) |   |
| **Triggerhændelse:** | Patienten ønsker ikke forløbet, eller klinisk grundlag er bortfaldet |   |
| **Forrige trin:** | ←[1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning)**(afsender ønsker at tilbagekalde)** |   |
| **Næste trin:** | **(Flowet afsluttes — ingen yderligere behandling påkrævet)** |   |

### Visitatorens user stories

### User story 2.3 Acceptere en henvisning og booke forløb

> **User story:** Som visitator ønsker jeg at kunne acceptere en henvisning og oprette en booking, 
når min visitationsafgørelse er positiv, 
så patienten får en tid og henviseren automatisk modtager bekræftelsen.

 ![](UC-2-3-Acceptere-booke.svg) 

Visitatoren accepterer henvisningen og opretter et forløb. Der bookes en tid, og `ServiceRequest`-status opdateres til `active`. En `Appointment`-ressource oprettes og linkes til henvisningen.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `ServiceRequest`(active),`Appointment`(booked) |
| **Triggerhændelse:** | Positiv visitationsafgørelse |
| **Forrige trin:** | ←[2.2 Triagere og prioritere](StructureDefinition-ehmi-lm-visitationsafgoerelse.md#user-story-22-triagere-og-prioritere-en-henvisning)**(positiv afgørelse)**·←[3.5 Alternativ visitation](#user-story-35-aftale-om-alternativ-visitation)**(alternativt tilbud accepteres)**·←[3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog)**(afklaring munder ud i accept)** |
| **Næste trin:** | →[3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser)**(henviser notificeres om accept og booking)** |

### User story 2.4 Afvise en henvisning

> **User story:** Som visitator ønsker jeg at kunne afvise en henvisning med en dokumenteret begrundelse, 
når indikationen ikke er opfyldt eller kapaciteten er nået, 
så henviseren forstår årsagen og kan tage stilling til næste skridt for patienten.

 ![](UC-2-4-Afvise-henvisning.svg) 

Visitatoren afviser henvisningen med en faglig eller kapacitetsmæssig begrundelse. `ServiceRequest`-status sættes til `revoked` eller `completed` med en `Task`-ressource der angiver årsag til afvisning.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `Task`(declined + reason),`ServiceRequest` |
| **Triggerhændelse:** | Indikation ikke opfyldt, forkert visitationsspor, eller kapacitetsloft nået |
| **Forrige trin:** | ←[2.2 Triagere og prioritere](StructureDefinition-ehmi-lm-visitationsafgoerelse.md#user-story-22-triagere-og-prioritere-en-henvisning)**(negativ afgørelse)**·←[3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog)**(afklaring munder ud i afvisning)** |
| **Næste trin:** | →[3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser)**(henviser notificeres om afvisning)**·→[3.5 Aftale om alternativ visitation](#user-story-35-aftale-om-alternativ-visitation)**(hvis alternativ løsning bør afsøges)** |

### User story 2.5 Videresende til anden modtager

> **User story:** Som visitator ønsker jeg at kunne videresende en fejlplaceret henvisning til rette modtager, 
når jeg vurderer at et andet tilbud er bedre egnet, 
så patienten ikke unødigt forsinkes og henviseren holdes orienteret om omdirigeringen.

 ![](UC-2-5-Videresende.svg) 

Visitatoren vurderer at henvisningen hører hjemme et andet sted og videresender. Der oprettes en ny `ServiceRequest` med reference til den originale via `replaces`-attributten, og der sendes notifikation til den oprindelige henviser.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `ServiceRequest`(replaces),`Task`,`Communication` |
| **Triggerhændelse:** | Forkert modtager eller bedre egnet tilbud identificeret |
| **Forrige trin:** | ←[2.2 Triagere og prioritere](StructureDefinition-ehmi-lm-visitationsafgoerelse.md#user-story-22-triagere-og-prioritere-en-henvisning)**(forkert modtager identificeret)** |
| **Næste trin:** | →[2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning)**(ny modtager starter sit eget modtagelsesflow)**·→[3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser)**(den oprindelige henviser orienteres)** |

### User story 2.6 Ændre prioritet på en modtaget henvisning

> **User story:** Som visitator ønsker jeg at kunne justere prioriteten på en allerede modtaget henvisning, 
når ny klinisk information eller ændret kapacitetssituation tilsiger det, 
så den kliniske hastegrad afspejles korrekt og henviseren notificeres om ændringen.

 ![](UC-2-6-Aendre-prioritet.svg) 

Visitatoren revurderer hastegraden for en allerede modtaget henvisning — fx på baggrund af ny klinisk information eller ændret kapacitetssituation. Prioriteten opdateres på `ServiceRequest` og der sendes notifikation til henviseren.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `ServiceRequest`(priority update),`SubscriptionNotification` |
| **Triggerhændelse:** | Ny information ændrer klinisk hastegrad |
| **Forrige trin:** | ←[2.2 Triagere og prioritere](StructureDefinition-ehmi-lm-visitationsafgoerelse.md#user-story-22-triagere-og-prioritere-en-henvisninger)**(prioritetsjustering under triage)** |
| **Næste trin:** | →[3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser)**(henviser notificeres om den ændrede prioritet)** |

## Udvekslingsdialog (fælles user stories)

Disse user stories forudsætter aktiv kommunikation frem og tilbage mellem henviser og visitator via FHIR-beskeder.

### Udvekslingsdialog

### User story 3.6 Korrektionsaftale om fejl i afsendt henvisning

> **User story:** Som visitator ønsker jeg at kunne kontakte henviseren og aftale en korrektion, 
når jeg opdager en fejl i en modtaget henvisning, 
så fejlen rettes på en koordineret og sporbar måde uden at vi mister historikken.

 ![](UC-3-6-Korrektionsaftale.svg) 

Visitatoren opdager en fejl i en modtaget henvisning — fx forkert CPR-nummer, forkert ydelseskode eller manglende samtykkedokumentation — og indleder en dialog med henviseren om korrektion. Korrektionen aftales via `Communication`-besked og gennemføres med en efterfølgende opdatering af `ServiceRequest`.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `Communication`,`ServiceRequest`(korrektion) |
| **Triggerhændelse:** | Fejl opdaget under modtagelse eller triage hos visitatoren |
| **Forrige trin:** | ←[2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning)**(fejl opdaget, korrektionsdiolog indledes)** |
| **Næste trin:** | →[1.3 Ændre en afsendt henvisning](#user-story-13-ændre-en-afsendt-henvisning)**(henviser retter og sender)**·→[2.2 Triagere og prioritere en henvisning](StructureDefinition-ehmi-lm-visitationsafgoerelse.md#user-story-22-triagere-og-prioritere-en-henvisning)**(visitatoren genoptager triage efter korrektion)** |

**Usages:**

* Refer to this Logical Model: [Booking](StructureDefinition-ehmi-lm-booking.md), [Henvisning](StructureDefinition-ehmi-lm-henvisning.md), [KliniskDokumentation](StructureDefinition-ehmi-lm-klinisk-dokumentation.md), [Kommunikationsbesked](StructureDefinition-ehmi-lm-kommunikationsbesked.md)... Show 2 more, [Statusnotifikation](StructureDefinition-ehmi-lm-statusnotifikation.md) and [Visitationsafgoerelse](StructureDefinition-ehmi-lm-visitationsafgoerelse.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-lm-henvisning.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-lm-henvisning.csv), [Excel](StructureDefinition-ehmi-lm-henvisning.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-lm-henvisning",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-henvisning",
  "version" : "0.1.0",
  "name" : "Henvisning",
  "title" : "Henvisning",
  "status" : "draft",
  "date" : "2026-06-16T14:56:57+02:00",
  "publisher" : "MedCom",
  "contact" : [{
    "name" : "MedCom",
    "telecom" : [{
      "system" : "url",
      "value" : "http://medcom.dk"
    }]
  }],
  "description" : "Repræsenterer en klinisk anmodning om at viderehenvise en patient\ntil et specialtilbud eller en ydelse. Svarer til FHIR ServiceRequest.\nDækker hele livscyklussen fra oprettelse til afslutning.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "DK",
      "display" : "Denmark"
    }]
  }],
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "fhir-r4",
    "uri" : "http://hl7.org/fhir",
    "name" : "RIM Mapping"
  }],
  "kind" : "logical",
  "abstract" : false,
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-henvisning",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "ehmi-lm-henvisning",
      "path" : "ehmi-lm-henvisning",
      "short" : "Henvisning",
      "definition" : "Repræsenterer en klinisk anmodning om at viderehenvise en patient\ntil et specialtilbud eller en ydelse. Svarer til FHIR ServiceRequest.\nDækker hele livscyklussen fra oprettelse til afslutning."
    },
    {
      "id" : "ehmi-lm-henvisning.henvisningsId",
      "path" : "ehmi-lm-henvisning.henvisningsId",
      "short" : "Unik identifikator for henvisningen",
      "definition" : "Unik identifikator for henvisningen",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Identifier"
      }],
      "mapping" : [{
        "map" : "ServiceRequest.identifier"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.status",
      "path" : "ehmi-lm-henvisning.status",
      "short" : "proposed | active | on-hold | revoked | completed",
      "definition" : "proposed | active | on-hold | revoked | completed",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "ServiceRequest.status"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.prioritet",
      "path" : "ehmi-lm-henvisning.prioritet",
      "short" : "routine | urgent | asap | stat",
      "definition" : "routine | urgent | asap | stat",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "ServiceRequest.priority"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.oprettetDato",
      "path" : "ehmi-lm-henvisning.oprettetDato",
      "short" : "Tidspunkt for oprettelse af henvisningen",
      "definition" : "Tidspunkt for oprettelse af henvisningen",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mapping" : [{
        "map" : "ServiceRequest.authoredOn"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.aendretDato",
      "path" : "ehmi-lm-henvisning.aendretDato",
      "short" : "Tidspunkt for seneste rettelse (revision)",
      "definition" : "Tidspunkt for seneste rettelse (revision)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mapping" : [{
        "map" : "ServiceRequest.meta.lastUpdated"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.ydelseskode",
      "path" : "ehmi-lm-henvisning.ydelseskode",
      "short" : "Ønsket ydelse eller specialale (SKS/SNOMED CT)",
      "definition" : "Ønsket ydelse eller specialale (SKS/SNOMED CT)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "mapping" : [{
        "map" : "ServiceRequest.code"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.indikation",
      "path" : "ehmi-lm-henvisning.indikation",
      "short" : "Klinisk indikation / diagnose (SKS/SNOMED CT)",
      "definition" : "Klinisk indikation / diagnose (SKS/SNOMED CT)",
      "min" : 1,
      "max" : "*",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "mapping" : [{
        "map" : "ServiceRequest.reasonCode"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.kliniskNote",
      "path" : "ehmi-lm-henvisning.kliniskNote",
      "short" : "Fri tekst: anamnese, aktuelle problemer, begrundelse",
      "definition" : "Fri tekst: anamnese, aktuelle problemer, begrundelse",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }],
      "mapping" : [{
        "map" : "ServiceRequest.note.text"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.oensketTidspunkt",
      "path" : "ehmi-lm-henvisning.oensketTidspunkt",
      "short" : "Ønsket tidspunkt for undersøgelse eller behandling",
      "definition" : "Ønsket tidspunkt for undersøgelse eller behandling",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mapping" : [{
        "map" : "ServiceRequest.occurrenceDateTime"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.erstattetAf",
      "path" : "ehmi-lm-henvisning.erstattetAf",
      "short" : "Reference til ny/revideret henvisning (replaces)",
      "definition" : "Reference til ny/revideret henvisning (replaces)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-henvisning"]
      }],
      "mapping" : [{
        "map" : "ServiceRequest.replaces"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.patient",
      "path" : "ehmi-lm-henvisning.patient",
      "short" : "Den patient der henvises",
      "definition" : "Den patient der henvises",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-patient"]
      }],
      "mapping" : [{
        "map" : "ServiceRequest.subject"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.henviser",
      "path" : "ehmi-lm-henvisning.henviser",
      "short" : "Den behandler der opretter og afsender",
      "definition" : "Den behandler der opretter og afsender",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-behandler"]
      }],
      "mapping" : [{
        "map" : "ServiceRequest.requester"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.afsenderOrganisation",
      "path" : "ehmi-lm-henvisning.afsenderOrganisation",
      "short" : "Afsendende organisation (klinik/praksis)",
      "definition" : "Afsendende organisation (klinik/praksis)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-organisation"]
      }],
      "mapping" : [{
        "map" : "ServiceRequest.requester (Organization)"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.modtagerOrganisation",
      "path" : "ehmi-lm-henvisning.modtagerOrganisation",
      "short" : "Modtagende organisation (visitator)",
      "definition" : "Modtagende organisation (visitator)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-organisation"]
      }],
      "mapping" : [{
        "map" : "ServiceRequest.performer"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.dokumentation",
      "path" : "ehmi-lm-henvisning.dokumentation",
      "short" : "Vedlagte kliniske bilag og resultater",
      "definition" : "Vedlagte kliniske bilag og resultater",
      "min" : 0,
      "max" : "*",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-klinisk-dokumentation"]
      }],
      "mapping" : [{
        "map" : "ServiceRequest.supportingInfo"
      }]
    },
    {
      "id" : "ehmi-lm-henvisning.booking",
      "path" : "ehmi-lm-henvisning.booking",
      "short" : "Tilknyttet booking ved accept",
      "definition" : "Tilknyttet booking ved accept",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-booking"]
      }],
      "mapping" : [{
        "map" : "ServiceRequest.basedOn (Appointment)"
      }]
    }]
  }
}

```
