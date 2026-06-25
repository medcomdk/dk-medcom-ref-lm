# Meddelelse – Logisk Model - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Meddelelse – Logisk Model**

## Logical Model: Meddelelse – Logisk Model 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/meddelelse | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:MeddelelseLM |

 
Konceptuel logisk model for en Meddelelse i dansk sundhedsvæsen. 

**Usages:**

* Use this Logical Model: [Henvisningsmeddelelse – Logisk Model](StructureDefinition-henvisningsmeddelelse.md) and [Henvisningsmeddelelse Response – Logisk Model](StructureDefinition-henvisningsmeddelelserespons.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-meddelelse.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-meddelelse.csv), [Excel](StructureDefinition-meddelelse.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "meddelelse",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/meddelelse",
  "version" : "0.1.0",
  "name" : "MeddelelseLM",
  "title" : "Meddelelse – Logisk Model",
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
  "description" : "Konceptuel logisk model for en Meddelelse i dansk sundhedsvæsen.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/meddelelse",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "meddelelse",
      "path" : "meddelelse",
      "short" : "Meddelelse – Logisk Model",
      "definition" : "Konceptuel logisk model for en Meddelelse i dansk sundhedsvæsen."
    },
    {
      "id" : "meddelelse.messageId",
      "path" : "meddelelse.messageId",
      "short" : "Unik meddelelsesidentifikator (UUID)",
      "definition" : "Unik meddelelsesidentifikator (UUID)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "id"
      }]
    },
    {
      "id" : "meddelelse.timestamp",
      "path" : "meddelelse.timestamp",
      "short" : "Afsendelsestidspunkt",
      "definition" : "Afsendelsestidspunkt",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }]
    },
    {
      "id" : "meddelelse.haendelse",
      "path" : "meddelelse.haendelse",
      "short" : "Haendelsestype (ny/annuller/opdater)",
      "definition" : "Haendelsestype (ny/annuller/opdater)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Coding"
      }]
    },
    {
      "id" : "meddelelse.afsender",
      "path" : "meddelelse.afsender",
      "short" : "Afsendende organisation",
      "definition" : "Afsendende organisation",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/kommunikator"
      }]
    },
    {
      "id" : "meddelelse.modtager",
      "path" : "meddelelse.modtager",
      "short" : "Modtagende organisation",
      "definition" : "Modtagende organisation",
      "min" : 1,
      "max" : "*",
      "type" : [{
        "code" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/kommunikator"
      }]
    }]
  }
}

```
