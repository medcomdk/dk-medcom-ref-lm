# Henviser – Logisk Model - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Henviser – Logisk Model**

## Logical Model: Henviser – Logisk Model 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henviser | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:HenviserLM |

 
Konceptuel logisk model for en Henviser i dansk sundhedsvæsen. 

**Usages:**

* Use this Logical Model: [Henvisningsmeddelelse – Logisk Model](StructureDefinition-henvisningsmeddelelse.md) and [Henvisningsmeddelelse Response – Logisk Model](StructureDefinition-henvisningsmeddelelserespons.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-henviser.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-henviser.csv), [Excel](StructureDefinition-henviser.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "henviser",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henviser",
  "version" : "0.1.0",
  "name" : "HenviserLM",
  "title" : "Henviser – Logisk Model",
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
  "description" : "Konceptuel logisk model for en Henviser i dansk sundhedsvæsen.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henviser",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "henviser",
      "path" : "henviser",
      "short" : "Henviser – Logisk Model",
      "definition" : "Konceptuel logisk model for en Henviser i dansk sundhedsvæsen."
    },
    {
      "id" : "henviser.autorisationsId",
      "path" : "henviser.autorisationsId",
      "short" : "Autorisations-ID",
      "definition" : "Autorisations-ID",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "henviser.navn",
      "path" : "henviser.navn",
      "short" : "Behandlerens navn",
      "definition" : "Behandlerens navn",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "HumanName"
      }]
    },
    {
      "id" : "henviser.speciale",
      "path" : "henviser.speciale",
      "short" : "Speciale/rolle",
      "definition" : "Speciale/rolle",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "henviser.kontakt",
      "path" : "henviser.kontakt",
      "short" : "Direkte kontakt til henviser",
      "definition" : "Direkte kontakt til henviser",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "ContactPoint"
      }]
    }]
  }
}

```
