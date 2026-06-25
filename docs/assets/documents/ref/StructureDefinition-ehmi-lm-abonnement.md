# Abonnement - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Abonnement**

## Logical Model: Abonnement 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-abonnement | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:Abonnement |

 
Repræsenterer en abonnementsregistrering der definerer hvilke hændelser en abonnent (typisk henviseren) ønsker at modtage notifikationer om. Svarer til FHIR Subscription. 

# Entitet: Abonnement

**FSH LogicalModel:** `EhmiLmAbonnement` **Primær FHIR-ressource:** `Subscription` **User stories:** 1.5, 3.4

-------

## Beskrivelse

`Abonnement` repræsenterer en registrering der definerer hvilke hændelser (statusskift på Henvisninger) en abonnent ønsker at modtage notifikationer om. Typisk opretter henviserens system et abonnement umiddelbart efter afsendelse af en Henvisning, og annullerer det ved modtagelse af den endelige afgørelse.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `abonnementId` | 1..1 | Identifier | Unik identifikator for abonnementet |
| `status` | 1..1 | code | `requested`·`active`·`error`·`off` |
| `kriterie` | 1..1 | string | FHIR-søgekriterium (fx`ServiceRequest?requester=Organization/123`) |
| `kanal` | 1..1 | code | `rest-hook`·`message`·`email` |
| `endpoint` | 1..1 | url | URL/endpoint der modtager notifikationer (EHMI) |
| `abonnent` | 1..1 | Reference(Organisation) | Den organisation der abonnerer |
| `oprettetDato` | 1..1 | dateTime | Tidspunkt for oprettelse |
| `udloeber` | 0..1 | dateTime | Udløbstidspunkt (hvis midlertidigt) |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `abonnementId` | `Subscription.id` |   |
| `status` | `Subscription.status` |   |
| `kriterie` | `Subscription.criteria` | FHIR-søge-URL som string |
| `kanal` | `Subscription.channel.type` | `rest-hook`foretrækkes via EHMI |
| `endpoint` | `Subscription.channel.endpoint` | EHMI AP-adresse |
| `abonnent` | `Subscription.contact` | Reference til Organization |
| `oprettetDato` | `Subscription.meta.lastUpdated` |   |
| `udloeber` | `Subscription.end` |   |

-------

## Relaterede entiteter

* **[Organisation](04-organisation.md)** — abonnenten
* **[Statusnotifikation](09-statusnotifikation.md)** — notifikationer udløst af dette abonnement
* **[Henvisning](01-henvisning.md)** — den ressource der abonneres på

-------

## User stories

### Henviserens user stories

### User story 1.5 Monitorere status på afsendte henvisninger

> **User story:** Som henviser ønsker jeg løbende at kunne se status på mine afsendte og udestående henvisninger, 
når jeg har behov for overblik over patienternes videre forløb, 
så jeg kan følge op og informere patienterne korrekt.

 ![](UC-1-5-Monitorere-status.svg) 

Henviseren følger løbende op på status for egne udestående henvisninger. Dette kan ske via FHIR-subscription (push) eller ved periodisk polling mod visitatorens FHIR-endpoint.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `Subscription`,`SubscriptionStatus`,`ServiceRequest` |
| **Triggerhændelse:** | Behov for overblik over egne afsendte henvisninger |
| **Forrige trin:** | ←[1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning)**(efter afsendelse ønskes overblik)** |
| **Næste trin:** | →[1.6 Modtage afgørelse fra visitatoren](#user-story-16-modtage-afgørelse-fra-visitatoren)**(statusoverblikket leder til modtagelse af den endelige afgørelse)** |

### Udvekslingsdialog

### User story 3.4 Statusnotifikation til henviser

> **User story:** Som henviser ønsker jeg automatisk at modtage en notifikation, 
når status på en af mine henvisninger ændrer sig hos visitatoren, 
så jeg til enhver tid er opdateret om forløbet uden at skulle forespørge aktivt.

 ![](UC-3-4-Statusnotifikation.svg) 

Visitatoren notificerer automatisk henviseren ved statusskift på en afsendt henvisning — fx modtaget, under vurdering, accepteret eller afvist. Notifikationen leveres via FHIR-subscription og indeholder reference til den opdaterede `ServiceRequest`.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `SubscriptionNotification`,`ServiceRequest` |
| **Triggerhændelse:** | Ethvert statusskift på en aktiv henvisning hos visitatoren |
| **Forrige trin:** | ←[2.3 Acceptere og booke](#user-story-23-acceptere-en-henvisning-og-booke-forløb)**(accept udløser notifikation)**·←[2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning)**(afvisning udløser notifikation)**·←[2.6 Ændre prioritet](#26-ændre-prioritet-på-en-modtaget-henvisning)**(prioritetsændring udløser notifikation)** |
| **Næste trin:** | →[1.6 Modtage afgørelse fra visitatoren](#user-story-16-modtage-afgørelse-fra-visitatoren)**(notifikationen udløser håndtering af afgørelsen hos henviseren)** |

**Usages:**

* Refer to this Logical Model: [Statusnotifikation](StructureDefinition-ehmi-lm-statusnotifikation.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-lm-abonnement.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-lm-abonnement.csv), [Excel](StructureDefinition-ehmi-lm-abonnement.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-lm-abonnement",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-abonnement",
  "version" : "0.1.0",
  "name" : "Abonnement",
  "title" : "Abonnement",
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
  "description" : "Repræsenterer en abonnementsregistrering der definerer hvilke\nhændelser en abonnent (typisk henviseren) ønsker at modtage\nnotifikationer om. Svarer til FHIR Subscription.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-abonnement",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "ehmi-lm-abonnement",
      "path" : "ehmi-lm-abonnement",
      "short" : "Abonnement",
      "definition" : "Repræsenterer en abonnementsregistrering der definerer hvilke\nhændelser en abonnent (typisk henviseren) ønsker at modtage\nnotifikationer om. Svarer til FHIR Subscription."
    },
    {
      "id" : "ehmi-lm-abonnement.abonnementId",
      "path" : "ehmi-lm-abonnement.abonnementId",
      "short" : "Unik identifikator for abonnementet",
      "definition" : "Unik identifikator for abonnementet",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Identifier"
      }],
      "mapping" : [{
        "map" : "Subscription.id"
      }]
    },
    {
      "id" : "ehmi-lm-abonnement.status",
      "path" : "ehmi-lm-abonnement.status",
      "short" : "requested | active | error | off",
      "definition" : "requested | active | error | off",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "Subscription.status"
      }]
    },
    {
      "id" : "ehmi-lm-abonnement.kriterie",
      "path" : "ehmi-lm-abonnement.kriterie",
      "short" : "FHIR søgekriterium (fx ServiceRequest?requester=...)",
      "definition" : "FHIR søgekriterium (fx ServiceRequest?requester=...)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }],
      "mapping" : [{
        "map" : "Subscription.criteria"
      }]
    },
    {
      "id" : "ehmi-lm-abonnement.kanal",
      "path" : "ehmi-lm-abonnement.kanal",
      "short" : "Leveringskanal: rest-hook | message | email",
      "definition" : "Leveringskanal: rest-hook | message | email",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "Subscription.channel.type"
      }]
    },
    {
      "id" : "ehmi-lm-abonnement.endpoint",
      "path" : "ehmi-lm-abonnement.endpoint",
      "short" : "URL/endpoint der modtager notifikationer (EHMI)",
      "definition" : "URL/endpoint der modtager notifikationer (EHMI)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "url"
      }],
      "mapping" : [{
        "map" : "Subscription.channel.endpoint"
      }]
    },
    {
      "id" : "ehmi-lm-abonnement.abonnent",
      "path" : "ehmi-lm-abonnement.abonnent",
      "short" : "Den organisation der abonnerer",
      "definition" : "Den organisation der abonnerer",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-organisation"]
      }],
      "mapping" : [{
        "map" : "Subscription.contact (Organization)"
      }]
    },
    {
      "id" : "ehmi-lm-abonnement.oprettetDato",
      "path" : "ehmi-lm-abonnement.oprettetDato",
      "short" : "Tidspunkt for oprettelse af abonnementet",
      "definition" : "Tidspunkt for oprettelse af abonnementet",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mapping" : [{
        "map" : "Subscription.meta.lastUpdated"
      }]
    },
    {
      "id" : "ehmi-lm-abonnement.udloeber",
      "path" : "ehmi-lm-abonnement.udloeber",
      "short" : "Udløbstidspunkt (hvis midlertidigt)",
      "definition" : "Udløbstidspunkt (hvis midlertidigt)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mapping" : [{
        "map" : "Subscription.end"
      }]
    }]
  }
}

```
