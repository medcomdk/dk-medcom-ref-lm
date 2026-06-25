# Organisation - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Organisation**

## Logical Model: Organisation 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-organisation | *Version*:0.1.0 |
| Draft as of 2026-06-16 | *Computable Name*:Organisation |

 
Repræsenterer en sundhedsorganisation der enten afsender eller modtager henvisninger. Svarer til FHIR Organization profileret som DkCoreOrganization med SOR-kode og GLN som primære identifikatorer. 

# Entitet: Organisation

**FSH LogicalModel:** `EhmiLmOrganisation` **Primær FHIR-ressource:** `Organization` (DkCoreOrganization) **User stories:** 1.1, 2.1, 2.5

-------

## Beskrivelse

`Organisation` repræsenterer en sundhedsorganisation der enten afsender eller modtager henvisninger via EHMI. SOR-koden er den primære nationale identifikator, og EHMI-endpointet er den tekniske adresse i eDelivery-infrastrukturen.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `sorKode` | 1..1 | Identifier | SOR-kode (Sundhedsorganisationsregisteret) |
| `glnNummer` | 0..1 | Identifier | GLN-nummer (Global Location Number) |
| `ydernummer` | 0..1 | Identifier | Ydernummer (praksis-identifikator) |
| `navn` | 1..1 | string | Organisationens navn |
| `type` | 1..1 | CodeableConcept | `hospital`·`praksis`·`speciallaegepraksis`·`kommunal` |
| `adresse` | 0..1 | Address | Organisationens adresse |
| `ehmiEndpoint` | 1..1 | url | EHMI/eDelivery endpoint (AP-adresse) |
| `overordnetOrganisation` | 0..1 | Reference(Organisation) | Fx region eller hospital |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `sorKode` | `Organization.identifier` | System:`https://www.esundhed.dk/NamingSystem/SOR` |
| `glnNummer` | `Organization.identifier` | System: GLN OID |
| `ydernummer` | `Organization.identifier` | System: Ydernummer-OID |
| `navn` | `Organization.name` |   |
| `type` | `Organization.type` |   |
| `adresse` | `Organization.address` |   |
| `ehmiEndpoint` | `Organization.endpoint` | Reference til FHIR Endpoint-ressource med EHMI URL |
| `overordnetOrganisation` | `Organization.partOf` |   |

-------

## Relaterede entiteter

* **[Behandler](03-behandler.md)** — behandlere er tilknyttet en organisation
* **[Henvisning](01-henvisning.md)** — afsender og modtager-organisation
* **[Abonnement](10-abonnement.md)** — organisationen er abonnent
* **[Meddelelseskonvolut](11-meddelelseskonvolut.md)** — routing via SOR/EHMI

-------

## User stories

### Relevante user stories

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

**Usages:**

* Refer to this Logical Model: [Abonnement](StructureDefinition-ehmi-lm-abonnement.md), [Behandler](StructureDefinition-ehmi-lm-behandler.md), [Booking](StructureDefinition-ehmi-lm-booking.md), [Henvisning](StructureDefinition-ehmi-lm-henvisning.md)... Show 3 more, [Meddelelseskonvolut](StructureDefinition-ehmi-lm-meddelelseskonvolut.md), [Organisation](StructureDefinition-ehmi-lm-organisation.md) and [Statusnotifikation](StructureDefinition-ehmi-lm-statusnotifikation.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-lm-organisation.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-lm-organisation.csv), [Excel](StructureDefinition-ehmi-lm-organisation.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-lm-organisation",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-organisation",
  "version" : "0.1.0",
  "name" : "Organisation",
  "title" : "Organisation",
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
  "description" : "Repræsenterer en sundhedsorganisation der enten afsender eller modtager\nhenvisninger. Svarer til FHIR Organization profileret som DkCoreOrganization\nmed SOR-kode og GLN som primære identifikatorer.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-organisation",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "ehmi-lm-organisation",
      "path" : "ehmi-lm-organisation",
      "short" : "Organisation",
      "definition" : "Repræsenterer en sundhedsorganisation der enten afsender eller modtager\nhenvisninger. Svarer til FHIR Organization profileret som DkCoreOrganization\nmed SOR-kode og GLN som primære identifikatorer."
    },
    {
      "id" : "ehmi-lm-organisation.sorKode",
      "path" : "ehmi-lm-organisation.sorKode",
      "short" : "SOR-kode (Sundhedsorganisationsregisteret)",
      "definition" : "SOR-kode (Sundhedsorganisationsregisteret)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Identifier"
      }],
      "mapping" : [{
        "map" : "Organization.identifier (SOR)"
      }]
    },
    {
      "id" : "ehmi-lm-organisation.glnNummer",
      "path" : "ehmi-lm-organisation.glnNummer",
      "short" : "GLN-nummer (Global Location Number)",
      "definition" : "GLN-nummer (Global Location Number)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Identifier"
      }],
      "mapping" : [{
        "map" : "Organization.identifier (GLN)"
      }]
    },
    {
      "id" : "ehmi-lm-organisation.ydernummer",
      "path" : "ehmi-lm-organisation.ydernummer",
      "short" : "Ydernummer (praksis-identifikator)",
      "definition" : "Ydernummer (praksis-identifikator)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Identifier"
      }],
      "mapping" : [{
        "map" : "Organization.identifier (Ydernummer)"
      }]
    },
    {
      "id" : "ehmi-lm-organisation.navn",
      "path" : "ehmi-lm-organisation.navn",
      "short" : "Organisationens navn",
      "definition" : "Organisationens navn",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }],
      "mapping" : [{
        "map" : "Organization.name"
      }]
    },
    {
      "id" : "ehmi-lm-organisation.type",
      "path" : "ehmi-lm-organisation.type",
      "short" : "Type: hospital | praksis | speciallaegepraksis | ...",
      "definition" : "Type: hospital | praksis | speciallaegepraksis | ...",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "mapping" : [{
        "map" : "Organization.type"
      }]
    },
    {
      "id" : "ehmi-lm-organisation.adresse",
      "path" : "ehmi-lm-organisation.adresse",
      "short" : "Organisationens adresse",
      "definition" : "Organisationens adresse",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Address"
      }],
      "mapping" : [{
        "map" : "Organization.address"
      }]
    },
    {
      "id" : "ehmi-lm-organisation.ehmiEndpoint",
      "path" : "ehmi-lm-organisation.ehmiEndpoint",
      "short" : "EHMI/eDelivery endpoint (AP-adresse)",
      "definition" : "EHMI/eDelivery endpoint (AP-adresse)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "url"
      }],
      "mapping" : [{
        "map" : "Organization.endpoint (EHMI)"
      }]
    },
    {
      "id" : "ehmi-lm-organisation.overordnetOrganisation",
      "path" : "ehmi-lm-organisation.overordnetOrganisation",
      "short" : "Overordnet organisation (fx region)",
      "definition" : "Overordnet organisation (fx region)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-organisation"]
      }],
      "mapping" : [{
        "map" : "Organization.partOf"
      }]
    }]
  }
}

```
