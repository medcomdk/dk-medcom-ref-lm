# Henvisning – Logisk Model - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Henvisning – Logisk Model**

## Logical Model: Henvisning – Logisk Model 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henvisning | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:HenvisningLM |

 
Konceptuel logisk model for en Henvisning i dansk sundhedsvæsen. 

**Usages:**

* Use this Logical Model: [Henvisningsmeddelelse – Logisk Model](StructureDefinition-henvisningsmeddelelse.md) and [Henvisningsmeddelelse Response – Logisk Model](StructureDefinition-henvisningsmeddelelserespons.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-henvisning.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-henvisning.csv), [Excel](StructureDefinition-henvisning.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "henvisning",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henvisning",
  "version" : "0.1.0",
  "name" : "HenvisningLM",
  "title" : "Henvisning – Logisk Model",
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
  "description" : "Konceptuel logisk model for en Henvisning i dansk sundhedsvæsen.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "DK",
      "display" : "Denmark"
    }]
  }],
  "fhirVersion" : "4.0.1",
  "kind" : "logical",
  "abstract" : false,
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henvisning",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "henvisning",
      "path" : "henvisning",
      "short" : "Henvisning – Logisk Model",
      "definition" : "Konceptuel logisk model for en Henvisning i dansk sundhedsvæsen."
    },
    {
      "id" : "henvisning.oprettetDato",
      "path" : "henvisning.oprettetDato",
      "short" : "Dato for oprettelse",
      "definition" : "Dato for oprettelse",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }]
    },
    {
      "id" : "henvisning.prioritet",
      "path" : "henvisning.prioritet",
      "short" : "routine | urgent | asap | stat",
      "definition" : "routine | urgent | asap | stat",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }]
    },
    {
      "id" : "henvisning.ydelseskode",
      "path" : "henvisning.ydelseskode",
      "short" : "Kode for oensket ydelse/specialale",
      "definition" : "Kode for oensket ydelse/specialale",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "henvisning.indikation",
      "path" : "henvisning.indikation",
      "short" : "Klinisk indikation",
      "definition" : "Klinisk indikation",
      "min" : 1,
      "max" : "*",
      "type" : [{
        "code" : "BackboneElement"
      }]
    },
    {
      "id" : "henvisning.indikation.diagnose",
      "path" : "henvisning.indikation.diagnose",
      "short" : "Diagnosekode (SKS/SNOMED CT)",
      "definition" : "Diagnosekode (SKS/SNOMED CT)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "henvisning.indikation.friTekst",
      "path" : "henvisning.indikation.friTekst",
      "short" : "Uddybende klinisk tekst",
      "definition" : "Uddybende klinisk tekst",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "henvisning.anamnese",
      "path" : "henvisning.anamnese",
      "short" : "Relevant sygehistorie",
      "definition" : "Relevant sygehistorie",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "henvisning.aktuelleProblemer",
      "path" : "henvisning.aktuelleProblemer",
      "short" : "Aktuelle problemstillinger",
      "definition" : "Aktuelle problemstillinger",
      "min" : 0,
      "max" : "*",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "henvisning.medicin",
      "path" : "henvisning.medicin",
      "short" : "Aktuel medicinliste (reference eller fri tekst)",
      "definition" : "Aktuel medicinliste (reference eller fri tekst)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "henvisning.paraklinik",
      "path" : "henvisning.paraklinik",
      "short" : "Vedlagte undersøgelser",
      "definition" : "Vedlagte undersøgelser",
      "min" : 0,
      "max" : "*",
      "type" : [{
        "code" : "BackboneElement"
      }]
    },
    {
      "id" : "henvisning.paraklinik.type",
      "path" : "henvisning.paraklinik.type",
      "short" : "observation | documentReference",
      "definition" : "observation | documentReference",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }]
    },
    {
      "id" : "henvisning.paraklinik.reference",
      "path" : "henvisning.paraklinik.reference",
      "short" : "Reference til FHIR-ressource",
      "definition" : "Reference til FHIR-ressource",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference"
      }]
    },
    {
      "id" : "henvisning.oensketTidspunkt",
      "path" : "henvisning.oensketTidspunkt",
      "short" : "Oensket tidspunkt for undersoegelse",
      "definition" : "Oensket tidspunkt for undersoegelse",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }]
    }]
  }
}

```
