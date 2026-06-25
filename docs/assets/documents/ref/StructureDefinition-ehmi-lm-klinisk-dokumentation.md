# KliniskDokumentation - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **KliniskDokumentation**

## Logical Model: KliniskDokumentation 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-klinisk-dokumentation | *Version*:0.1.0 |
| Draft as of 2026-06-16 | *Computable Name*:KliniskDokumentation |

 
Repræsenterer supplerende klinisk materiale der knyttes til en Henvisning for at understøtte visitators beslutningsgrundlag. Kan være laboratoriesvar, billeddiagnostik, epikriser eller andre dokumenter. Svarer til FHIR DocumentReference, DiagnosticReport eller Observation. 

# Entitet: KliniskDokumentation

**FSH LogicalModel:** `EhmiLmKliniskDokumentation` **Primær FHIR-ressource:** `DocumentReference`, `DiagnosticReport`, `Observation` **User stories:** 1.2

-------

## Beskrivelse

`KliniskDokumentation` repræsenterer supplerende klinisk materiale der knyttes til en Henvisning for at styrke visitators beslutningsgrundlag. Det kan være laboratoriesvar, billeddiagnostik, epikriser, medicinlister eller andre relevante dokumenter.

Valget af FHIR-ressource afhænger af dokumenttypen:

* **`DocumentReference`** — epikriser, PDF-dokumenter, medicinliste, samtykke
* **`DiagnosticReport`** — laboratoriesvar, billeddiagnostik med strukturerede fund
* **`Observation`** — enkeltmålinger (BMI, blodtryk, blodsukker mv.)

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `dokumentId` | 1..1 | Identifier | Unik identifikator for dokumentet |
| `type` | 1..1 | CodeableConcept | `labsvar`·`billeddiagnostik`·`epikrise`·`medicin`·`andet` |
| `titel` | 0..1 | string | Dokumentets titel eller emne |
| `dato` | 1..1 | dateTime | Dato/tidspunkt for dokumentet |
| `indhold` | 0..1 | Attachment | Dokumentindholdet (base64 eller ekstern URL) |
| `forfatter` | 0..1 | Reference(Behandler) | Den der har udstedt/registreret dokumentet |
| `relatertHenvisning` | 1..1 | Reference(Henvisning) | Den henvisning dokumentet er knyttet til |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `dokumentId` | `DocumentReference.identifier`/`DiagnosticReport.identifier` |   |
| `type` | `DocumentReference.type`/`DiagnosticReport.code` |   |
| `titel` | `DocumentReference.description` |   |
| `dato` | `DocumentReference.date`/`DiagnosticReport.effectiveDateTime` |   |
| `indhold` | `DocumentReference.content.attachment` | MIME-type + base64 eller URL |
| `forfatter` | `DocumentReference.author`/`DiagnosticReport.performer` |   |
| `relatertHenvisning` | `ServiceRequest.supportingInfo` | Referencen sættes på ServiceRequest |

-------

## Relaterede entiteter

* **[Henvisning](01-henvisning.md)** — dokumentationen er knyttet til en henvisning
* **[Behandler](03-behandler.md)** — forfatter til dokumentet
* **[Kommunikationsbesked](08-kommunikationsbesked.md)** — kan vedhæftes en besked som bilag

-------

## User stories

### Henviserens user stories

### User story 1.2 Tilknytte klinisk dokumentation

> **User story:** Som henviser ønsker jeg at kunne vedhæfte relevant klinisk dokumentation til en eksisterende henvisning, 
når jeg vurderer at visitatoren har brug for supplerende materiale for at træffe en god afgørelse, 
så beslutningsgrundlaget er samlet ét sted.

 ![](UC-1-2-Tilknytte-dokumentation.svg) 

| |
| :--- |
| Henviseren vedhæfter supplerende klinisk materiale til en eksisterende henvisning — fx laboratoriesvar, billeddiagnostik eller tidligere epikriser. Materialet knyttes til`ServiceRequest`-ressourcen via referencer til`DiagnosticReport`,`Media`eller`DocumentReference`. |

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `DiagnosticReport`,`Media`,`DocumentReference` |
| **Triggerhændelse:** | Behov for at understøtte klinisk beslutningsgrundlag |
| **Forrige trin:** | ←[1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning)**(hvis supplerende materiale er relevant)** |
| **Næste trin:** | →[2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning)**(visitatoren modtager den berigede henvisning)** |

### Udvekslingsdialog

### User story 3.2 Besvare anmodning om supplement

> **User story:** Som henviser ønsker jeg at kunne besvare en supplement-anmodning med de efterspurgte kliniske oplysninger, 
når visitatoren har bedt om yderligere data, 
så visitatoren hurtigt kan genoptage og afslutte triage-processen.

 ![](UC-3-2-Besvare-supplement.svg) 

Henviseren modtager en supplement-anmodning og besvarer denne ved at sende de efterspurgte oplysninger. Svaret sendes som en `Communication`-ressource med reference til den oprindelige `CommunicationRequest` og til `ServiceRequest`.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `Communication`(reply, in-response-to) |
| **Triggerhændelse:** | Modtagelse af CommunicationRequest fra visitatoren |
| **Forrige trin:** | ←[3.1 Anmode om supplerende oplysninger](#user-story-31-anmode-om-supplerende-oplysninger)**(supplement anmodet)** |
| **Næste trin:** | →[2.2 Triagere og prioritere en henvisning](StructureDefinition-ehmi-lm-visitationsafgoerelse.md#user-story-22-triagere-og-prioritere-en-henvisning)**(visitatoren genoptager triage med det modtagne supplement)**·→[3.3 Faglig afklaring i dialog](#user-story-33-faglig-afklaring-i-dialog)**(hvis svaret afføder yderligere spørgsmål)** |

**Usages:**

* Refer to this Logical Model: [Henvisning](StructureDefinition-ehmi-lm-henvisning.md) and [Kommunikationsbesked](StructureDefinition-ehmi-lm-kommunikationsbesked.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-lm-klinisk-dokumentation.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-lm-klinisk-dokumentation.csv), [Excel](StructureDefinition-ehmi-lm-klinisk-dokumentation.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-lm-klinisk-dokumentation",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-klinisk-dokumentation",
  "version" : "0.1.0",
  "name" : "KliniskDokumentation",
  "title" : "KliniskDokumentation",
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
  "description" : "Repræsenterer supplerende klinisk materiale der knyttes til en\nHenvisning for at understøtte visitators beslutningsgrundlag.\nKan være laboratoriesvar, billeddiagnostik, epikriser eller andre dokumenter.\nSvarer til FHIR DocumentReference, DiagnosticReport eller Observation.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-klinisk-dokumentation",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "ehmi-lm-klinisk-dokumentation",
      "path" : "ehmi-lm-klinisk-dokumentation",
      "short" : "KliniskDokumentation",
      "definition" : "Repræsenterer supplerende klinisk materiale der knyttes til en\nHenvisning for at understøtte visitators beslutningsgrundlag.\nKan være laboratoriesvar, billeddiagnostik, epikriser eller andre dokumenter.\nSvarer til FHIR DocumentReference, DiagnosticReport eller Observation."
    },
    {
      "id" : "ehmi-lm-klinisk-dokumentation.dokumentId",
      "path" : "ehmi-lm-klinisk-dokumentation.dokumentId",
      "short" : "Unik identifikator for dokumentet",
      "definition" : "Unik identifikator for dokumentet",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Identifier"
      }],
      "mapping" : [{
        "map" : "DocumentReference.identifier | DiagnosticReport.identifier"
      }]
    },
    {
      "id" : "ehmi-lm-klinisk-dokumentation.type",
      "path" : "ehmi-lm-klinisk-dokumentation.type",
      "short" : "Dokumenttype: labsvar | billeddiagnostik | epikrise | medicin | andet",
      "definition" : "Dokumenttype: labsvar | billeddiagnostik | epikrise | medicin | andet",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "mapping" : [{
        "map" : "DocumentReference.type | DiagnosticReport.code"
      }]
    },
    {
      "id" : "ehmi-lm-klinisk-dokumentation.titel",
      "path" : "ehmi-lm-klinisk-dokumentation.titel",
      "short" : "Dokumentets titel eller emne",
      "definition" : "Dokumentets titel eller emne",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }],
      "mapping" : [{
        "map" : "DocumentReference.description"
      }]
    },
    {
      "id" : "ehmi-lm-klinisk-dokumentation.dato",
      "path" : "ehmi-lm-klinisk-dokumentation.dato",
      "short" : "Dato/tidspunkt for dokumentet",
      "definition" : "Dato/tidspunkt for dokumentet",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mapping" : [{
        "map" : "DocumentReference.date | DiagnosticReport.effectiveDateTime"
      }]
    },
    {
      "id" : "ehmi-lm-klinisk-dokumentation.indhold",
      "path" : "ehmi-lm-klinisk-dokumentation.indhold",
      "short" : "Selve dokumentindholdet (base64 eller URL)",
      "definition" : "Selve dokumentindholdet (base64 eller URL)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Attachment"
      }],
      "mapping" : [{
        "map" : "DocumentReference.content.attachment"
      }]
    },
    {
      "id" : "ehmi-lm-klinisk-dokumentation.forfatter",
      "path" : "ehmi-lm-klinisk-dokumentation.forfatter",
      "short" : "Den der har udstedt/registreret dokumentet",
      "definition" : "Den der har udstedt/registreret dokumentet",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-behandler"]
      }],
      "mapping" : [{
        "map" : "DocumentReference.author | DiagnosticReport.performer"
      }]
    },
    {
      "id" : "ehmi-lm-klinisk-dokumentation.relatertHenvisning",
      "path" : "ehmi-lm-klinisk-dokumentation.relatertHenvisning",
      "short" : "Den henvisning dokumentet er knyttet til",
      "definition" : "Den henvisning dokumentet er knyttet til",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-henvisning"]
      }],
      "mapping" : [{
        "map" : "ServiceRequest.supportingInfo"
      }]
    }]
  }
}

```
