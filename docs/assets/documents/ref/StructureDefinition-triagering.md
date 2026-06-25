# Triagering – Logisk Model - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Triagering – Logisk Model**

## Logical Model: Triagering – Logisk Model 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/triagering | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:TriageringLM |

 
Konceptuel logisk model for en Triagering i dansk sundhedsvæsen. 

**Usages:**

* Use this Logical Model: [Henvisningsmeddelelse Response – Logisk Model](StructureDefinition-henvisningsmeddelelserespons.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-triagering.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-triagering.csv), [Excel](StructureDefinition-triagering.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "triagering",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/triagering",
  "version" : "0.1.0",
  "name" : "TriageringLM",
  "title" : "Triagering – Logisk Model",
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
  "description" : "Konceptuel logisk model for en Triagering i dansk sundhedsvæsen.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/triagering",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "triagering",
      "path" : "triagering",
      "short" : "Triagering – Logisk Model",
      "definition" : "Konceptuel logisk model for en Triagering i dansk sundhedsvæsen."
    },
    {
      "id" : "triagering.Triagering",
      "path" : "triagering.Triagering",
      "short" : "Under triage | Triageret til akut | Triageret til rutine | Afvist",
      "definition" : "Under triage | Triageret til akut | Triageret til rutine | Afvist",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }]
    },
    {
      "id" : "triagering.TriageringsKommentar",
      "path" : "triagering.TriageringsKommentar",
      "short" : "Eventuelle kommentarer fra modtageren vedrørende triageringen",
      "definition" : "Eventuelle kommentarer fra modtageren vedrørende triageringen",
      "min" : 1,
      "max" : "*",
      "type" : [{
        "code" : "string"
      }]
    }]
  }
}

```
