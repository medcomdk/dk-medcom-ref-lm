# Patient – Logisk Model - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Patient – Logisk Model**

## Logical Model: Patient – Logisk Model 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/patient | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:PatientLM |

 
Konceptuel logisk model for en Patient i dansk sundhedsvæsen. 

**Usages:**

* Use this Logical Model: [Henvisningsmeddelelse – Logisk Model](StructureDefinition-henvisningsmeddelelse.md) and [Henvisningsmeddelelse Response – Logisk Model](StructureDefinition-henvisningsmeddelelserespons.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-patient.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-patient.csv), [Excel](StructureDefinition-patient.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "patient",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/patient",
  "version" : "0.1.0",
  "name" : "PatientLM",
  "title" : "Patient – Logisk Model",
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
  "description" : "Konceptuel logisk model for en Patient i dansk sundhedsvæsen.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/patient",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "patient",
      "path" : "patient",
      "short" : "Patient – Logisk Model",
      "definition" : "Konceptuel logisk model for en Patient i dansk sundhedsvæsen."
    },
    {
      "id" : "patient.cpr",
      "path" : "patient.cpr",
      "short" : "CPR-nummer",
      "definition" : "CPR-nummer",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "patient.navn",
      "path" : "patient.navn",
      "short" : "Fulde navn",
      "definition" : "Fulde navn",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "HumanName"
      }]
    },
    {
      "id" : "patient.adresse",
      "path" : "patient.adresse",
      "short" : "Bopaelasdresse",
      "definition" : "Bopaelasdresse",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Address"
      }]
    },
    {
      "id" : "patient.telefon",
      "path" : "patient.telefon",
      "short" : "Kontakttelefon",
      "definition" : "Kontakttelefon",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "ContactPoint"
      }]
    }]
  }
}

```
