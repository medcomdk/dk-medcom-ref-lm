# Meddelelseskonvolut - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Meddelelseskonvolut**

## Logical Model: Meddelelseskonvolut 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-meddelelseskonvolut | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:Meddelelseskonvolut |

 
Repræsenterer den tekniske meddelelsesomslag der transporterer kliniske ressourcer (Henvisning, Afgørelse mv.) via EHMI og eDelivery. Svarer til FHIR Bundle (type=message) med MessageHeader som første entry. 

# Entitet: Meddelelseskonvolut

**FSH LogicalModel:** `EhmiLmMeddelelseskonvolut` **Primær FHIR-ressource:** `Bundle` (type=message) + `MessageHeader` **User stories:** 1.1, 2.1

-------

## Beskrivelse

`Meddelelseskonvolut` repræsenterer den tekniske ompakning der transporterer kliniske FHIR-ressourcer (Henvisning, Visitationsafgørelse mv.) fra afsender til modtager via EHMI og eDelivery (AS4-protokollen).

Bundle-strukturen garanterer atomicitet: alle ressourcer i en meddelelse sendes og behandles samlet. `MessageHeader` er altid første entry og indeholder routing-information (afsender, modtager, EHMI-endpoint) og hændelsestype.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `meddelelsesId` | 1..1 | id | Unik UUID for denne meddelelse |
| `haendelsestype` | 1..1 | Coding | `ny-henvisning`·`annuller`·`opdater`·`kvittering` |
| `afsendelsestidspunkt` | 1..1 | dateTime | Tidspunkt for afsendelse |
| `afsender` | 1..1 | Reference(Organisation) | Afsendende organisation |
| `modtager` | 1..* | Reference(Organisation) | Modtagende organisation(er) |
| `fokus` | 1..* | Reference | Primær klinisk ressource (Henvisning, Afgørelse mv.) |
| `kildesystem` | 1..1 | string | Afsendende systems tekniske endpoint |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `meddelelsesId` | `Bundle.id`/`MessageHeader.id` | UUID v4 |
| `haendelsestype` | `MessageHeader.eventCoding` | Fra`EHMIMessageEventCS` |
| `afsendelsestidspunkt` | `Bundle.timestamp` |   |
| `afsender` | `MessageHeader.sender` | Reference til DkCoreOrganization |
| `modtager` | `MessageHeader.destination.receiver` | Reference til DkCoreOrganization |
| `fokus` | `MessageHeader.focus` | Reference til ServiceRequest el. Task |
| `kildesystem` | `MessageHeader.source.endpoint` | Teknisk endpoint URL |

-------

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

-------

## Relaterede entiteter

* **[Organisation](04-organisation.md)** — afsender og modtager
* **[Henvisning](01-henvisning.md)** — den primære kliniske payload
* **[Visitationsafgoerelse](06-visitationsafgoerelse.md)** — kan transporteres som fokus

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

### Visitatorens user stories

### User story 2.1 Modtage og kvittere for ny henvisning

> **User story:** Som visitator ønsker jeg automatisk at modtage og kvittere for indkomne henvisninger via FHIR, 
når en ny `ServiceRequest` ankommer i mit endpoint, 
så afsenderen hurtigt får bekræftet at henvisningen er modtaget korrekt.

 ![](UC-2-1-Modtage-kvittere.svg) 

Visitatoren modtager en indkommende FHIR-`Bundle` med en ny `ServiceRequest` og sender en teknisk kvittering (ACK) tilbage til afsendersystemet. Henvisningen registreres i visitationssystemet med status `active` eller `on-hold` afhængigt af triagekapacitet.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `Bundle`,`MessageHeader`,`ServiceRequest` |
| **Triggerhændelse:** | Indkommende henvisning i FHIR-endpoint |
| **Forrige trin:** | ←[1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning)**(afsendelse af ny henvisning)**·←[1.2 Tilknytte klinisk dokumentation](#user-story-12-tilknytte-klinisk-dokumentation)**(beriget henvisning modtages)**·←[2.5 Videresende](#user-story-25-videresende-til-anden-modtager)**(ny modtager starter modtagelsesflow)** |
| **Næste trin:** | →[2.2 Triagere og prioritere en henvisning](StructureDefinition-ehmi-lm-visitationsafgoerelse.md#user-story-22-triagere-og-prioritere-en-henvisning) |

**Usages:**

* This Logical Model is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-lm-meddelelseskonvolut.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-lm-meddelelseskonvolut.csv), [Excel](StructureDefinition-ehmi-lm-meddelelseskonvolut.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-lm-meddelelseskonvolut",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-meddelelseskonvolut",
  "version" : "0.1.0",
  "name" : "Meddelelseskonvolut",
  "title" : "Meddelelseskonvolut",
  "status" : "draft",
  "date" : "2026-06-25T17:09:01+02:00",
  "publisher" : "MedCom",
  "contact" : [{
    "name" : "MedCom",
    "telecom" : [{
      "system" : "url",
      "value" : "http://medcom.dk"
    }]
  }],
  "description" : "Repræsenterer den tekniske meddelelsesomslag der transporterer\nkliniske ressourcer (Henvisning, Afgørelse mv.) via EHMI og eDelivery.\nSvarer til FHIR Bundle (type=message) med MessageHeader som første entry.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-meddelelseskonvolut",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "ehmi-lm-meddelelseskonvolut",
      "path" : "ehmi-lm-meddelelseskonvolut",
      "short" : "Meddelelseskonvolut",
      "definition" : "Repræsenterer den tekniske meddelelsesomslag der transporterer\nkliniske ressourcer (Henvisning, Afgørelse mv.) via EHMI og eDelivery.\nSvarer til FHIR Bundle (type=message) med MessageHeader som første entry."
    },
    {
      "id" : "ehmi-lm-meddelelseskonvolut.meddelelsesId",
      "path" : "ehmi-lm-meddelelseskonvolut.meddelelsesId",
      "short" : "Unik UUID for denne meddelelse",
      "definition" : "Unik UUID for denne meddelelse",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "id"
      }],
      "mapping" : [{
        "map" : "Bundle.id | MessageHeader.id"
      }]
    },
    {
      "id" : "ehmi-lm-meddelelseskonvolut.haendelsestype",
      "path" : "ehmi-lm-meddelelseskonvolut.haendelsestype",
      "short" : "Hændelsestype: ny-henvisning | annuller | opdater | kvittering",
      "definition" : "Hændelsestype: ny-henvisning | annuller | opdater | kvittering",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Coding"
      }],
      "mapping" : [{
        "map" : "MessageHeader.eventCoding"
      }]
    },
    {
      "id" : "ehmi-lm-meddelelseskonvolut.afsendelsestidspunkt",
      "path" : "ehmi-lm-meddelelseskonvolut.afsendelsestidspunkt",
      "short" : "Tidspunkt for afsendelse",
      "definition" : "Tidspunkt for afsendelse",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mapping" : [{
        "map" : "Bundle.timestamp"
      }]
    },
    {
      "id" : "ehmi-lm-meddelelseskonvolut.afsender",
      "path" : "ehmi-lm-meddelelseskonvolut.afsender",
      "short" : "Afsendende organisation",
      "definition" : "Afsendende organisation",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-organisation"]
      }],
      "mapping" : [{
        "map" : "MessageHeader.sender"
      }]
    },
    {
      "id" : "ehmi-lm-meddelelseskonvolut.modtager",
      "path" : "ehmi-lm-meddelelseskonvolut.modtager",
      "short" : "Modtagende organisation(er)",
      "definition" : "Modtagende organisation(er)",
      "min" : 1,
      "max" : "*",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-organisation"]
      }],
      "mapping" : [{
        "map" : "MessageHeader.destination.receiver"
      }]
    },
    {
      "id" : "ehmi-lm-meddelelseskonvolut.fokus",
      "path" : "ehmi-lm-meddelelseskonvolut.fokus",
      "short" : "Primær klinisk ressource (Henvisning, Afgørelse mv.)",
      "definition" : "Primær klinisk ressource (Henvisning, Afgørelse mv.)",
      "min" : 1,
      "max" : "*",
      "type" : [{
        "code" : "Reference"
      }],
      "mapping" : [{
        "map" : "MessageHeader.focus"
      }]
    },
    {
      "id" : "ehmi-lm-meddelelseskonvolut.kildesystem",
      "path" : "ehmi-lm-meddelelseskonvolut.kildesystem",
      "short" : "Afsendende systems endpoint (teknisk)",
      "definition" : "Afsendende systems endpoint (teknisk)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }],
      "mapping" : [{
        "map" : "MessageHeader.source.endpoint"
      }]
    }]
  }
}

```
