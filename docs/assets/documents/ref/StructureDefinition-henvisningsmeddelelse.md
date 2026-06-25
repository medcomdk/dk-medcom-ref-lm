# Henvisningsmeddelelse – Logisk Model - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Henvisningsmeddelelse – Logisk Model**

## Logical Model: Henvisningsmeddelelse – Logisk Model 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henvisningsmeddelelse | *Version*:0.1.0 |
| Draft as of 2026-06-16 | *Computable Name*:HenvisningsmeddelelseLM |

 
Konceptuel logisk model for en henvisningsmeddelelse i dansk sundhedsvæsen. 

**Usages:**

* This Logical Model is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-henvisningsmeddelelse.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-henvisningsmeddelelse.csv), [Excel](StructureDefinition-henvisningsmeddelelse.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "henvisningsmeddelelse",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henvisningsmeddelelse",
  "version" : "0.1.0",
  "name" : "HenvisningsmeddelelseLM",
  "title" : "Henvisningsmeddelelse – Logisk Model",
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
  "description" : "Konceptuel logisk model for en henvisningsmeddelelse i dansk sundhedsvæsen.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henvisningsmeddelelse",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "henvisningsmeddelelse",
      "path" : "henvisningsmeddelelse",
      "short" : "Henvisningsmeddelelse – Logisk Model",
      "definition" : "Konceptuel logisk model for en henvisningsmeddelelse i dansk sundhedsvæsen."
    },
    {
      "id" : "henvisningsmeddelelse.Meddelelse",
      "path" : "henvisningsmeddelelse.Meddelelse",
      "short" : "Meddelelseskonvolut",
      "definition" : "Meddelelseskonvolut",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/meddelelse"
      }]
    },
    {
      "id" : "henvisningsmeddelelse.Meddelelse.Henvisning",
      "path" : "henvisningsmeddelelse.Meddelelse.Henvisning",
      "short" : "Klinisk henvisning (ServiceRequest)",
      "definition" : "Klinisk henvisning (ServiceRequest)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henvisning"
      }]
    },
    {
      "id" : "henvisningsmeddelelse.Meddelelse.Patient",
      "path" : "henvisningsmeddelelse.Meddelelse.Patient",
      "short" : "Patientinformation",
      "definition" : "Patientinformation",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/patient"
      }]
    },
    {
      "id" : "henvisningsmeddelelse.Meddelelse.Henviser",
      "path" : "henvisningsmeddelelse.Meddelelse.Henviser",
      "short" : "Henvisende behandler",
      "definition" : "Henvisende behandler",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henviser"
      }]
    }]
  }
}

```
