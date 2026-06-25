# Henvisningsmeddelelse Response – Logisk Model - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Henvisningsmeddelelse Response – Logisk Model**

## Logical Model: Henvisningsmeddelelse Response – Logisk Model 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henvisningsmeddelelserespons | *Version*:0.1.0 |
| Draft as of 2026-06-16 | *Computable Name*:HenvisningsmeddelelseResponseLM |

 
Konceptuel logisk model for en henvisningsmeddelelse med response i dansk sundhedsvæsen. Der er brug for udddybning af henvisningen før den kan endeligt triageres 

**Usages:**

* This Logical Model is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-henvisningsmeddelelserespons.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-henvisningsmeddelelserespons.csv), [Excel](StructureDefinition-henvisningsmeddelelserespons.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "henvisningsmeddelelserespons",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henvisningsmeddelelserespons",
  "version" : "0.1.0",
  "name" : "HenvisningsmeddelelseResponseLM",
  "title" : "Henvisningsmeddelelse Response – Logisk Model",
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
  "description" : "Konceptuel logisk model for en henvisningsmeddelelse med response i dansk sundhedsvæsen. Der er brug for udddybning af henvisningen før den kan endeligt triageres",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henvisningsmeddelelserespons",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "henvisningsmeddelelserespons",
      "path" : "henvisningsmeddelelserespons",
      "short" : "Henvisningsmeddelelse Response – Logisk Model",
      "definition" : "Konceptuel logisk model for en henvisningsmeddelelse med response i dansk sundhedsvæsen. Der er brug for udddybning af henvisningen før den kan endeligt triageres"
    },
    {
      "id" : "henvisningsmeddelelserespons.Meddelelse",
      "path" : "henvisningsmeddelelserespons.Meddelelse",
      "short" : "Meddelelseskonvolut",
      "definition" : "Meddelelseskonvolut",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/meddelelse"
      }]
    },
    {
      "id" : "henvisningsmeddelelserespons.Meddelelse.Henvisning",
      "path" : "henvisningsmeddelelserespons.Meddelelse.Henvisning",
      "short" : "Klinisk henvisning (ServiceRequest)",
      "definition" : "Klinisk henvisning (ServiceRequest)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henvisning"
      }]
    },
    {
      "id" : "henvisningsmeddelelserespons.Meddelelse.Patient",
      "path" : "henvisningsmeddelelserespons.Meddelelse.Patient",
      "short" : "Patientinformation",
      "definition" : "Patientinformation",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/patient"
      }]
    },
    {
      "id" : "henvisningsmeddelelserespons.Meddelelse.Henviser",
      "path" : "henvisningsmeddelelserespons.Meddelelse.Henviser",
      "short" : "Henvisende behandler",
      "definition" : "Henvisende behandler",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/henviser"
      }]
    },
    {
      "id" : "henvisningsmeddelelserespons.Meddelelse.Triagering",
      "path" : "henvisningsmeddelelserespons.Meddelelse.Triagering",
      "short" : "Triageringsbesked",
      "definition" : "Triageringsbesked",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/triagering"
      }]
    }]
  }
}

```
