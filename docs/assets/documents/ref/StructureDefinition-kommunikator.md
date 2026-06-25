# Kommunikator – Logisk Model - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Kommunikator – Logisk Model**

## Logical Model: Kommunikator – Logisk Model 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/kommunikator | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:KommunikatorLM |

 
Konceptuel logisk model for en Kommunikator i dansk sundhedsvæsen. 

**Usages:**

* Use this Logical Model: [Meddelelse – Logisk Model](StructureDefinition-meddelelse.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-kommunikator.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-kommunikator.csv), [Excel](StructureDefinition-kommunikator.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "kommunikator",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/kommunikator",
  "version" : "0.1.0",
  "name" : "KommunikatorLM",
  "title" : "Kommunikator – Logisk Model",
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
  "description" : "Konceptuel logisk model for en Kommunikator i dansk sundhedsvæsen.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/kommunikator",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "kommunikator",
      "path" : "kommunikator",
      "short" : "Kommunikator – Logisk Model",
      "definition" : "Konceptuel logisk model for en Kommunikator i dansk sundhedsvæsen."
    },
    {
      "id" : "kommunikator.sorKode",
      "path" : "kommunikator.sorKode",
      "short" : "SOR-kode for afsender",
      "definition" : "SOR-kode for afsender",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "kommunikator.navn",
      "path" : "kommunikator.navn",
      "short" : "Organisationsnavn",
      "definition" : "Organisationsnavn",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "kommunikator.yder",
      "path" : "kommunikator.yder",
      "short" : "Ydernummer (hvis relevant)",
      "definition" : "Ydernummer (hvis relevant)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "kommunikator.endpoint",
      "path" : "kommunikator.endpoint",
      "short" : "EHMI/eDelivery endpoint",
      "definition" : "EHMI/eDelivery endpoint",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmiendpoint"
      }]
    }]
  }
}

```
