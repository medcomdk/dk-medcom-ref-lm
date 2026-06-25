# Behandler - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Behandler**

## Logical Model: Behandler 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-behandler | *Version*:0.1.0 |
| Draft as of 2026-06-16 | *Computable Name*:Behandler |

 
Repræsenterer en sundhedsprofessionel i rollen som enten henviser eller visitator. Svarer til FHIR Practitioner kombineret med PractitionerRole for at udtrykke rolle og tilknyttet organisation. 

# Entitet: Behandler

**FSH LogicalModel:** `EhmiLmBehandler` **Primær FHIR-ressource:** `Practitioner` + `PractitionerRole` **User stories:** Alle (opretter, afsender, triagerer, afgør)

-------

## Beskrivelse

`Behandler` repræsenterer en sundhedsprofessionel i flowet — enten som **henviser** (opretter og afsender en henvisning) eller som **visitator** (modtager, triagerer og afgør). FHIR adskiller person-identiteten (`Practitioner`) fra rollen og organisationstilknytningen (`PractitionerRole`).

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `autorisationsId` | 1..1 | Identifier | Autorisations-ID (Sundhedsstyrelsen) |
| `navn` | 1..1 | HumanName | Fulde navn |
| `speciale` | 0..1 | CodeableConcept | Fagligt speciale (SKS-klassifikation) |
| `rolle` | 1..1 | CodeableConcept | `henviser`·`visitator` |
| `organisation` | 1..1 | Reference(Organisation) | Tilknyttet organisation |
| `direkteKontakt` | 0..1 | ContactPoint | Telefon eller sikker mail |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `autorisationsId` | `Practitioner.identifier` | System: Autorisationsregisterets OID |
| `navn` | `Practitioner.name` |   |
| `speciale` | `PractitionerRole.specialty` | SKS-specialekodning |
| `rolle` | `PractitionerRole.code` | Lokalt eller nationalt rollekode-VS |
| `organisation` | `PractitionerRole.organization` | Reference til DkCoreOrganization |
| `direkteKontakt` | `Practitioner.telecom` |   |

-------

## Relaterede entiteter

* **[Organisation](04-organisation.md)** — behandlerens tilknytning
* **[Henvisning](01-henvisning.md)** — som afsender (`requester`)
* **[Visitationsafgoerelse](06-visitationsafgoerelse.md)** — som afgørende visitator
* **[Kommunikationsbesked](08-kommunikationsbesked.md)** — som afsender/modtager

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
| **Forrige trin:** | ←[2.2 Triagere og prioritere](#22-triagere-og-prioritere-en-henvisning)**(positiv afgørelse)**·←[3.5 Alternativ visitation](#user-story-35-aftale-om-alternativ-visitation)**(alternativt tilbud accepteres)**·←[3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog)**(afklaring munder ud i accept)** |
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
| **Forrige trin:** | ←[2.2 Triagere og prioritere](#22-triagere-og-prioritere-en-henvisning)**(negativ afgørelse)**·←[3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog)**(afklaring munder ud i afvisning)** |
| **Næste trin:** | →[3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser)**(henviser notificeres om afvisning)**·→[3.5 Aftale om alternativ visitation](#user-story-35-aftale-om-alternativ-visitation)**(hvis alternativ løsning bør afsøges)** |

**Usages:**

* Refer to this Logical Model: [Henvisning](StructureDefinition-ehmi-lm-henvisning.md), [KliniskDokumentation](StructureDefinition-ehmi-lm-klinisk-dokumentation.md), [Kommunikationsbesked](StructureDefinition-ehmi-lm-kommunikationsbesked.md) and [Visitationsafgoerelse](StructureDefinition-ehmi-lm-visitationsafgoerelse.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-lm-behandler.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-lm-behandler.csv), [Excel](StructureDefinition-ehmi-lm-behandler.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-lm-behandler",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-behandler",
  "version" : "0.1.0",
  "name" : "Behandler",
  "title" : "Behandler",
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
  "description" : "Repræsenterer en sundhedsprofessionel i rollen som enten\nhenviser eller visitator. Svarer til FHIR Practitioner kombineret\nmed PractitionerRole for at udtrykke rolle og tilknyttet organisation.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-behandler",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "ehmi-lm-behandler",
      "path" : "ehmi-lm-behandler",
      "short" : "Behandler",
      "definition" : "Repræsenterer en sundhedsprofessionel i rollen som enten\nhenviser eller visitator. Svarer til FHIR Practitioner kombineret\nmed PractitionerRole for at udtrykke rolle og tilknyttet organisation."
    },
    {
      "id" : "ehmi-lm-behandler.autorisationsId",
      "path" : "ehmi-lm-behandler.autorisationsId",
      "short" : "Autorisations-ID (Sundhedsstyrelsen)",
      "definition" : "Autorisations-ID (Sundhedsstyrelsen)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Identifier"
      }],
      "mapping" : [{
        "map" : "Practitioner.identifier (Autorisations-ID)"
      }]
    },
    {
      "id" : "ehmi-lm-behandler.navn",
      "path" : "ehmi-lm-behandler.navn",
      "short" : "Fulde navn",
      "definition" : "Fulde navn",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "HumanName"
      }],
      "mapping" : [{
        "map" : "Practitioner.name"
      }]
    },
    {
      "id" : "ehmi-lm-behandler.speciale",
      "path" : "ehmi-lm-behandler.speciale",
      "short" : "Fagligt speciale (SKS-klassifikation)",
      "definition" : "Fagligt speciale (SKS-klassifikation)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "mapping" : [{
        "map" : "PractitionerRole.specialty"
      }]
    },
    {
      "id" : "ehmi-lm-behandler.rolle",
      "path" : "ehmi-lm-behandler.rolle",
      "short" : "Rolle i flowet: henviser | visitator",
      "definition" : "Rolle i flowet: henviser | visitator",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "mapping" : [{
        "map" : "PractitionerRole.code"
      }]
    },
    {
      "id" : "ehmi-lm-behandler.organisation",
      "path" : "ehmi-lm-behandler.organisation",
      "short" : "Tilknyttet organisation",
      "definition" : "Tilknyttet organisation",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-organisation"]
      }],
      "mapping" : [{
        "map" : "PractitionerRole.organization"
      }]
    },
    {
      "id" : "ehmi-lm-behandler.direkteKontakt",
      "path" : "ehmi-lm-behandler.direkteKontakt",
      "short" : "Direkte kontaktoplysning (telefon/sikker mail)",
      "definition" : "Direkte kontaktoplysning (telefon/sikker mail)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "ContactPoint"
      }],
      "mapping" : [{
        "map" : "Practitioner.telecom"
      }]
    }]
  }
}

```
