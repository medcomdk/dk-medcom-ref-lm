# Statusnotifikation - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Statusnotifikation**

## Logical Model: Statusnotifikation 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-statusnotifikation | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:Statusnotifikation |

 
Repræsenterer en automatisk notifikation der sendes til en abonnent (typisk henviseren) ved statusændring på en aktiv henvisning. Svarer til FHIR SubscriptionNotification / SubscriptionStatus (R4B/R5-mønster implementeret via MedCom-notifikationsmodel i R4). 

# Entitet: Statusnotifikation

**FSH LogicalModel:** `EhmiLmStatusnotifikation` **Primær FHIR-ressource:** `SubscriptionNotification` / `SubscriptionStatus` **User stories:** 1.5, 1.6, 2.6, 3.4

-------

## Beskrivelse

`Statusnotifikation` repræsenterer en automatisk push-notifikation der sendes til en abonnent (typisk henviseren) ved et statusskift på en aktiv Henvisning. Notifikationen indeholder en reference til den opdaterede ressource og udløser håndtering hos modtageren.

I FHIR R4 implementeres dette via `Subscription`-ressourcen kombineret med en notifikations-`Bundle` der transporteres via EHMI. I R4B/R5 er dette formaliseret som `SubscriptionStatus`.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `notifikationsId` | 1..1 | Identifier | Unik identifikator for notifikationen |
| `type` | 1..1 | code | `handshake`·`heartbeat`·`event-notification`·`query-status` |
| `udloestAfStatus` | 1..1 | code | Den nye status der udløste notifikationen |
| `tidspunkt` | 1..1 | dateTime | Tidspunkt for notifikationen |
| `abonnement` | 1..1 | Reference(Abonnement) | Det abonnement der udløste notifikationen |
| `vedroererHenvisning` | 1..1 | Reference(Henvisning) | Den ændrede Henvisning |
| `modtager` | 1..1 | Reference(Organisation) | Modtagende organisation (abonnenten) |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `notifikationsId` | `Bundle.identifier` | Notification-bundle |
| `type` | `SubscriptionStatus.type` |   |
| `udloestAfStatus` | `SubscriptionStatus.notificationEvent.focus` | Via ServiceRequest.status |
| `tidspunkt` | `SubscriptionStatus.notificationEvent.timestamp` |   |
| `abonnement` | `SubscriptionStatus.subscription` |   |
| `vedroererHenvisning` | `SubscriptionStatus.notificationEvent.focus` | Reference til ServiceRequest |
| `modtager` | `Subscription.channel.endpoint` | Abonnentens EHMI-endpoint |

-------

## Relaterede entiteter

* **[Abonnement](10-abonnement.md)** — det abonnement der udløser notifikationen
* **[Henvisning](01-henvisning.md)** — den ressource der ændres
* **[Organisation](04-organisation.md)** — modtageren af notifikationen

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

### Visitatorens user stories

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
| **Forrige trin:** | ←[2.3 Acceptere og booke](#user-story-23-acceptere-en-henvisning-og-booke-forløb)**(accept udløser notifikation)**·←[2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning)**(afvisning udløser notifikation)**·←[2.6 Ændre prioritet](#user-story-26-ændre-prioritet-på-en-modtaget-henvisning)**(prioritetsændring udløser notifikation)** |
| **Næste trin:** | →[1.6 Modtage afgørelse fra visitatoren](#user-story-16-modtage-afgørelse-fra-visitatoren)**(notifikationen udløser håndtering af afgørelsen hos henviseren)** |

**Usages:**

* This Logical Model is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-lm-statusnotifikation.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-lm-statusnotifikation.csv), [Excel](StructureDefinition-ehmi-lm-statusnotifikation.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-lm-statusnotifikation",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-statusnotifikation",
  "version" : "0.1.0",
  "name" : "Statusnotifikation",
  "title" : "Statusnotifikation",
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
  "description" : "Repræsenterer en automatisk notifikation der sendes til en abonnent\n(typisk henviseren) ved statusændring på en aktiv henvisning.\nSvarer til FHIR SubscriptionNotification / SubscriptionStatus (R4B/R5-mønster\nimplementeret via MedCom-notifikationsmodel i R4).",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-statusnotifikation",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "ehmi-lm-statusnotifikation",
      "path" : "ehmi-lm-statusnotifikation",
      "short" : "Statusnotifikation",
      "definition" : "Repræsenterer en automatisk notifikation der sendes til en abonnent\n(typisk henviseren) ved statusændring på en aktiv henvisning.\nSvarer til FHIR SubscriptionNotification / SubscriptionStatus (R4B/R5-mønster\nimplementeret via MedCom-notifikationsmodel i R4)."
    },
    {
      "id" : "ehmi-lm-statusnotifikation.notifikationsId",
      "path" : "ehmi-lm-statusnotifikation.notifikationsId",
      "short" : "Unik identifikator for notifikationen",
      "definition" : "Unik identifikator for notifikationen",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Identifier"
      }],
      "mapping" : [{
        "map" : "Bundle.identifier (notification-bundle)"
      }]
    },
    {
      "id" : "ehmi-lm-statusnotifikation.type",
      "path" : "ehmi-lm-statusnotifikation.type",
      "short" : "handshake | heartbeat | event-notification | query-status",
      "definition" : "handshake | heartbeat | event-notification | query-status",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "SubscriptionStatus.type"
      }]
    },
    {
      "id" : "ehmi-lm-statusnotifikation.udloestAfStatus",
      "path" : "ehmi-lm-statusnotifikation.udloestAfStatus",
      "short" : "Den nye status der udløste notifikationen",
      "definition" : "Den nye status der udløste notifikationen",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "SubscriptionStatus.notificationEvent.focus (ServiceRequest.status)"
      }]
    },
    {
      "id" : "ehmi-lm-statusnotifikation.tidspunkt",
      "path" : "ehmi-lm-statusnotifikation.tidspunkt",
      "short" : "Tidspunkt for notifikationen",
      "definition" : "Tidspunkt for notifikationen",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mapping" : [{
        "map" : "SubscriptionStatus.notificationEvent.timestamp"
      }]
    },
    {
      "id" : "ehmi-lm-statusnotifikation.abonnement",
      "path" : "ehmi-lm-statusnotifikation.abonnement",
      "short" : "Det abonnement der udløste notifikationen",
      "definition" : "Det abonnement der udløste notifikationen",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-abonnement"]
      }],
      "mapping" : [{
        "map" : "SubscriptionStatus.subscription"
      }]
    },
    {
      "id" : "ehmi-lm-statusnotifikation.vedroererHenvisning",
      "path" : "ehmi-lm-statusnotifikation.vedroererHenvisning",
      "short" : "Den ændrede henvisning",
      "definition" : "Den ændrede henvisning",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-henvisning"]
      }],
      "mapping" : [{
        "map" : "SubscriptionStatus.notificationEvent.focus"
      }]
    },
    {
      "id" : "ehmi-lm-statusnotifikation.modtager",
      "path" : "ehmi-lm-statusnotifikation.modtager",
      "short" : "Modtagende organisation (abonnenten)",
      "definition" : "Modtagende organisation (abonnenten)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-organisation"]
      }],
      "mapping" : [{
        "map" : "Subscription.channel.endpoint (abonnentens endpoint)"
      }]
    }]
  }
}

```
