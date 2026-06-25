# EHMI Referral MessageHeader - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **EHMI Referral MessageHeader**

## Resource Profile: EHMI Referral MessageHeader 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-referral-message-header | *Version*:0.1.0 |
| Draft as of 2026-06-16 | *Computable Name*:EHMIReferralMessageHeader |

 
MessageHeader for EHMI-baseret henvisningsmeddelelse. 

**Usages:**

* Use this Profile: [EHMI Referring Message Bundle](StructureDefinition-ehmi-referral-message-bundle.md) and [EHMI Referral Message Response Bundle](StructureDefinition-ehmi-referral-message-response-bundle.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-referral-message-header.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-referral-message-header.csv), [Excel](StructureDefinition-ehmi-referral-message-header.xlsx), [Schematron](StructureDefinition-ehmi-referral-message-header.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-referral-message-header",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-referral-message-header",
  "version" : "0.1.0",
  "name" : "EHMIReferralMessageHeader",
  "title" : "EHMI Referral MessageHeader",
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
  "description" : "MessageHeader for EHMI-baseret henvisningsmeddelelse.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "DK",
      "display" : "Denmark"
    }]
  }],
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "MessageHeader",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/MessageHeader",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "MessageHeader.id",
      "path" : "MessageHeader.id",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "MessageHeader.meta.profile",
      "path" : "MessageHeader.meta.profile",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "MessageHeader.event[x]",
      "path" : "MessageHeader.event[x]",
      "type" : [{
        "code" : "Coding"
      }],
      "mustSupport" : true,
      "binding" : {
        "strength" : "required",
        "valueSet" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/ValueSet/ehmi-message-event-vs"
      }
    },
    {
      "id" : "MessageHeader.destination",
      "path" : "MessageHeader.destination",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "MessageHeader.destination.endpoint",
      "path" : "MessageHeader.destination.endpoint",
      "mustSupport" : true
    },
    {
      "id" : "MessageHeader.destination.receiver",
      "path" : "MessageHeader.destination.receiver",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.dk/fhir/core/StructureDefinition/dk-core-organization"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "MessageHeader.sender",
      "path" : "MessageHeader.sender",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.dk/fhir/core/StructureDefinition/dk-core-organization"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "MessageHeader.source",
      "path" : "MessageHeader.source",
      "mustSupport" : true
    },
    {
      "id" : "MessageHeader.source.endpoint",
      "path" : "MessageHeader.source.endpoint",
      "mustSupport" : true
    },
    {
      "id" : "MessageHeader.focus",
      "path" : "MessageHeader.focus",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-service-request"]
      }],
      "mustSupport" : true
    }]
  }
}

```
