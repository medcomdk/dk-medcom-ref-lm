# EHMI/eDelivery Endpoint – Logisk Model - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **EHMI/eDelivery Endpoint – Logisk Model**

## Logical Model: EHMI/eDelivery Endpoint – Logisk Model 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmiendpoint | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:EhmiEndpointLM |

 
Konceptuel logisk model for et EHMI/eDelivery endpoint i dansk sundhedsvæsen. 

**Usages:**

* Use this Logical Model: [Kommunikator – Logisk Model](StructureDefinition-kommunikator.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmiendpoint.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmiendpoint.csv), [Excel](StructureDefinition-ehmiendpoint.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmiendpoint",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmiendpoint",
  "version" : "0.1.0",
  "name" : "EhmiEndpointLM",
  "title" : "EHMI/eDelivery Endpoint – Logisk Model",
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
  "description" : "Konceptuel logisk model for et EHMI/eDelivery endpoint i dansk sundhedsvæsen.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmiendpoint",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "ehmiendpoint",
      "path" : "ehmiendpoint",
      "short" : "EHMI/eDelivery Endpoint – Logisk Model",
      "definition" : "Konceptuel logisk model for et EHMI/eDelivery endpoint i dansk sundhedsvæsen."
    },
    {
      "id" : "ehmiendpoint.ident",
      "path" : "ehmiendpoint.ident",
      "short" : "GLN Identifier",
      "definition" : "GLN Identifier",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "ehmiendpoint.mimetype",
      "path" : "ehmiendpoint.mimetype",
      "short" : "fhr+json,fhir+xml",
      "definition" : "fhr+json,fhir+xml",
      "min" : 1,
      "max" : "*",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "ehmiendpoint.meddelelsestyper",
      "path" : "ehmiendpoint.meddelelsestyper",
      "short" : "hvilke meddelelsestyper understøttes",
      "definition" : "hvilke meddelelsestyper understøttes",
      "min" : 1,
      "max" : "*",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "ehmiendpoint.url",
      "path" : "ehmiendpoint.url",
      "short" : "URL for EHMI/eDelivery endpoint",
      "definition" : "URL for EHMI/eDelivery endpoint",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "url"
      }]
    }]
  }
}

```
