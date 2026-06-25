# Visitationsafgoerelse - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Visitationsafgoerelse**

## Logical Model: Visitationsafgoerelse 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-visitationsafgoerelse | *Version*:0.1.0 |
| Draft as of 2026-06-16 | *Computable Name*:Visitationsafgoerelse |

 
Repræsenterer visitatorens formelle beslutning om en indkommende henvisning: accept, afvisning, videresendelse eller prioritetsændring. Svarer til FHIR Task med outcome og begrundelse. 

# Entitet: Visitationsafgoerelse

**FSH LogicalModel:** `EhmiLmVisitationsafgoerelse` **Primær FHIR-ressource:** `Task` **User stories:** 1.6, 2.2, 2.3, 2.4, 2.5, 2.6

-------

## Beskrivelse

`Visitationsafgoerelse` repræsenterer visitatorens formelle beslutning om en indkommende henvisning. Den dokumenterer udfaldet af triage-processen — accept, afvisning, videresendelse eller prioritetsændring — og udgør den primære mekanisme for at kommunikere afgørelsen tilbage til henviseren.

FHIR `Task` er valgt fordi den understøtter workflow-orienterede opgaver med status, prioritet, udfald og begrundelse.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `afgoerelseId` | 1..1 | Identifier | Unik identifikator for afgørelsen |
| `type` | 1..1 | code | `accept`·`afvisning`·`videresendelse`·`prioritetsaendring` |
| `status` | 1..1 | code | `requested`·`received`·`accepted`·`rejected`·`completed` |
| `prioritet` | 0..1 | code | `routine`·`urgent`·`asap`·`stat` |
| `begrundelse` | 0..1 | string | Faglig begrundelse for afgørelsen (fri tekst) |
| `aarsagskode` | 0..1 | CodeableConcept | Struktureret årsag (kapacitet, indikation, forkert spor) |
| `truffetDato` | 1..1 | dateTime | Tidspunkt for afgørelsen |
| `truffetAf` | 1..1 | Reference(Behandler) | Visitatoren der har truffet afgørelsen |
| `vedroererHenvisning` | 1..1 | Reference(Henvisning) | Den henvisning afgørelsen vedrører |
| `alternativtTilbud` | 0..1 | Reference(Henvisning) | Alternativt tilbud (ved videresendelse/3.5) |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `afgoerelseId` | `Task.identifier` |   |
| `type` | `Task.code` | Lokalt eller nationalt kodeset |
| `status` | `Task.status` | Bundet til`task-status`(required) |
| `prioritet` | `Task.priority` |   |
| `begrundelse` | `Task.note.text` |   |
| `aarsagskode` | `Task.statusReason` |   |
| `truffetDato` | `Task.executionPeriod.end` |   |
| `truffetAf` | `Task.owner` | Reference til Practitioner/PractitionerRole |
| `vedroererHenvisning` | `Task.focus` | Reference til ServiceRequest |
| `alternativtTilbud` | `Task.output` | Reference til ny/alternativ ServiceRequest |

-------

## Relaterede entiteter

* **[Henvisning](01-henvisning.md)** — den afgørelse vedrører
* **[Behandler](03-behandler.md)** — visitatoren der afgør
* **[Statusnotifikation](09-statusnotifikation.md)** — afgørelsen udløser notifikation
* **[Booking](07-booking.md)** — oprettes ved accept

-------

## User stories

### Visitatorens user stories

### User story 2.2 Triagere og prioritere en henvisning

> **User story:** Som visitator ønsker jeg at kunne foretage en struktureret triage af en modtaget henvisning og dokumentere mit udfald, 
når en ny eller opdateret henvisning er klar til klinisk vurdering, 
så prioriteringen er sporbar og ensartet på tværs af alle indkomne sager.

 ![](UC-2-2-Triagere-prioritere.svg) 

Visitatoren vurderer henvisningens faglige indhold, klassificerer hastegrad og prioriterer i forhold til øvrige indkomne henvisninger. Triage-udfaldet dokumenteres i en `Task`-ressource med udfald og begrundelse.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `Task`(triage-outcome, priority) |
| **Triggerhændelse:** | Ny eller opdateret henvisning klar til klinisk vurdering |
| **Forrige trin:** | ←[2.1 Modtage og kvittere](#user-story-21-modtage-og-kvittere-for-ny-henvisning)**(efter kvittering påbegyndes triage)**·←[1.3 Ændre en afsendt henvisning](#user-story-13-ændre-en-afsendt-henvisning)**(ændringsnotifikation modtaget)**·←[3.2 Besvare anmodning om supplement](#user-story-32-besvare-anmodning-om-supplement)**(supplement modtaget, triage genoptages)**·←[3.6 Korrektionsaftale](#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning)**(triage genoptages efter korrektion)** |
| **Næste trin:** | →[2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forløb)**(positiv afgørelse)**·→[2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning)**(negativ afgørelse)**·→[3.1 Anmode om supplerende oplysninger](#user-story-31-anmode-om-supplerende-oplysninger)**(grundlaget er utilstrækkeligt)**·→[2.6 Ændre prioritet](#user-story-26-ændre-prioritet-på-en-modtaget-henvisning)**(prioriteten justeres)** |

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

### Henviserens user stories

### User story 1.6 Modtage afgørelse fra visitatoren

> **User story:** Som henviser ønsker jeg automatisk at modtage visitatorens afgørelse i mit journalsystem, 
når visitatoren har truffet beslutning om accept, afvisning eller alternativt tilbud, 
så jeg hurtigt kan handle og orientere patienten.

 ![](UC-1-6-Modtage-afgoerelse.svg) 

Henviseren modtager visitatorens endelige afgørelse — accept, afvisning eller alternativt tilbud — og integrerer denne i eget journalsystem. Afgørelsen leveres som en `Task`-ressource eller notifikation med reference til den oprindelige `ServiceRequest`.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `Task`,`SubscriptionNotification` |
| **Triggerhændelse:** | Visitatoren har truffet afgørelse om henvisningen |
| **Forrige trin:** | ←[1.5 Monitorere status](#user-story-12-monitorere-status-på-afsendte-henvisninger)**(statusoverblikket leder hertil)**·←[3.4 Statusnotifikation](#user-story-34-statusnotifikation-til-henviser)**(notifikation udløser håndtering)** |
| **Næste trin:** | →[1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning)**(hvis afgørelsen er en afvisning og patienten skal viderehenvisies)**·**(Flowet afsluttes ved accept)** |

## Visitatorens user stories

Disse user stories udføres selvstændigt af visitatoren som led i modtagelse og behandling af indkomne henvisninger.

**Usages:**

* This Logical Model is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-lm-visitationsafgoerelse.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-lm-visitationsafgoerelse.csv), [Excel](StructureDefinition-ehmi-lm-visitationsafgoerelse.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-lm-visitationsafgoerelse",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-visitationsafgoerelse",
  "version" : "0.1.0",
  "name" : "Visitationsafgoerelse",
  "title" : "Visitationsafgoerelse",
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
  "description" : "Repræsenterer visitatorens formelle beslutning om en indkommende\nhenvisning: accept, afvisning, videresendelse eller prioritetsændring.\nSvarer til FHIR Task med outcome og begrundelse.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-visitationsafgoerelse",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "ehmi-lm-visitationsafgoerelse",
      "path" : "ehmi-lm-visitationsafgoerelse",
      "short" : "Visitationsafgoerelse",
      "definition" : "Repræsenterer visitatorens formelle beslutning om en indkommende\nhenvisning: accept, afvisning, videresendelse eller prioritetsændring.\nSvarer til FHIR Task med outcome og begrundelse."
    },
    {
      "id" : "ehmi-lm-visitationsafgoerelse.afgoerelseId",
      "path" : "ehmi-lm-visitationsafgoerelse.afgoerelseId",
      "short" : "Unik identifikator for afgørelsen",
      "definition" : "Unik identifikator for afgørelsen",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Identifier"
      }],
      "mapping" : [{
        "map" : "Task.identifier"
      }]
    },
    {
      "id" : "ehmi-lm-visitationsafgoerelse.type",
      "path" : "ehmi-lm-visitationsafgoerelse.type",
      "short" : "accept | afvisning | videresendelse | prioritetsaendring",
      "definition" : "accept | afvisning | videresendelse | prioritetsaendring",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "Task.code"
      }]
    },
    {
      "id" : "ehmi-lm-visitationsafgoerelse.status",
      "path" : "ehmi-lm-visitationsafgoerelse.status",
      "short" : "requested | received | accepted | rejected | completed",
      "definition" : "requested | received | accepted | rejected | completed",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "Task.status"
      }]
    },
    {
      "id" : "ehmi-lm-visitationsafgoerelse.prioritet",
      "path" : "ehmi-lm-visitationsafgoerelse.prioritet",
      "short" : "routine | urgent | asap | stat",
      "definition" : "routine | urgent | asap | stat",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "Task.priority"
      }]
    },
    {
      "id" : "ehmi-lm-visitationsafgoerelse.begrundelse",
      "path" : "ehmi-lm-visitationsafgoerelse.begrundelse",
      "short" : "Faglig begrundelse for afgørelsen",
      "definition" : "Faglig begrundelse for afgørelsen",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }],
      "mapping" : [{
        "map" : "Task.note.text"
      }]
    },
    {
      "id" : "ehmi-lm-visitationsafgoerelse.aarsagskode",
      "path" : "ehmi-lm-visitationsafgoerelse.aarsagskode",
      "short" : "Struktureret årsag (fx kapacitet, indikation, forkert spor)",
      "definition" : "Struktureret årsag (fx kapacitet, indikation, forkert spor)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "mapping" : [{
        "map" : "Task.statusReason"
      }]
    },
    {
      "id" : "ehmi-lm-visitationsafgoerelse.truffetDato",
      "path" : "ehmi-lm-visitationsafgoerelse.truffetDato",
      "short" : "Tidspunkt for afgørelsen",
      "definition" : "Tidspunkt for afgørelsen",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mapping" : [{
        "map" : "Task.executionPeriod.end"
      }]
    },
    {
      "id" : "ehmi-lm-visitationsafgoerelse.truffetAf",
      "path" : "ehmi-lm-visitationsafgoerelse.truffetAf",
      "short" : "Visitatoren der har truffet afgørelsen",
      "definition" : "Visitatoren der har truffet afgørelsen",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-behandler"]
      }],
      "mapping" : [{
        "map" : "Task.owner"
      }]
    },
    {
      "id" : "ehmi-lm-visitationsafgoerelse.vedroererHenvisning",
      "path" : "ehmi-lm-visitationsafgoerelse.vedroererHenvisning",
      "short" : "Den henvisning afgørelsen vedrører",
      "definition" : "Den henvisning afgørelsen vedrører",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-henvisning"]
      }],
      "mapping" : [{
        "map" : "Task.focus (ServiceRequest)"
      }]
    },
    {
      "id" : "ehmi-lm-visitationsafgoerelse.alternativtTilbud",
      "path" : "ehmi-lm-visitationsafgoerelse.alternativtTilbud",
      "short" : "Reference til alternativt tilbud (ved videresendelse)",
      "definition" : "Reference til alternativt tilbud (ved videresendelse)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-henvisning"]
      }],
      "mapping" : [{
        "map" : "Task.output (ServiceRequest reference)"
      }]
    }]
  }
}

```
