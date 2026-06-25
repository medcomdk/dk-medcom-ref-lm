# EHMI ServiceRequest – Henvisning - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **EHMI ServiceRequest – Henvisning**

## Resource Profile: EHMI ServiceRequest – Henvisning 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-service-request | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:EHMIServiceRequest |

 
Kerne-ressource der repræsenterer den kliniske henvisning. 

**Usages:**

* Use this Profile: [EHMI Referring Message Bundle](StructureDefinition-ehmi-referral-message-bundle.md) and [EHMI Referral Message Response Bundle](StructureDefinition-ehmi-referral-message-response-bundle.md)
* Refer to this Profile: [EHMI Referral MessageHeader](StructureDefinition-ehmi-referral-message-header.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-service-request.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-service-request.csv), [Excel](StructureDefinition-ehmi-service-request.xlsx), [Schematron](StructureDefinition-ehmi-service-request.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-service-request",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-service-request",
  "version" : "0.1.0",
  "name" : "EHMIServiceRequest",
  "title" : "EHMI ServiceRequest – Henvisning",
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
  "description" : "Kerne-ressource der repræsenterer den kliniske henvisning.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "DK",
      "display" : "Denmark"
    }]
  }],
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
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
  },
  {
    "identity" : "quick",
    "uri" : "http://siframework.org/cqf",
    "name" : "Quality Improvement and Clinical Knowledge (QUICK)"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "ServiceRequest",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/ServiceRequest",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "ServiceRequest.identifier",
      "path" : "ServiceRequest.identifier",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "system"
        }],
        "rules" : "open"
      },
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.identifier:localId",
      "path" : "ServiceRequest.identifier",
      "sliceName" : "localId",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "ServiceRequest.identifier:localId.system",
      "path" : "ServiceRequest.identifier.system",
      "min" : 1,
      "patternUri" : "http://example.dk/fhir/NamingSystem/local-referral-id"
    },
    {
      "id" : "ServiceRequest.identifier:sorReferralId",
      "path" : "ServiceRequest.identifier",
      "sliceName" : "sorReferralId",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "ServiceRequest.identifier:sorReferralId.system",
      "path" : "ServiceRequest.identifier.system",
      "min" : 1,
      "patternUri" : "https://www.esundhed.dk/NamingSystem/SOR-referral"
    },
    {
      "id" : "ServiceRequest.status",
      "path" : "ServiceRequest.status",
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.intent",
      "path" : "ServiceRequest.intent",
      "patternCode" : "order",
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.priority",
      "path" : "ServiceRequest.priority",
      "mustSupport" : true,
      "binding" : {
        "strength" : "required",
        "valueSet" : "http://hl7.org/fhir/ValueSet/request-priority"
      }
    },
    {
      "id" : "ServiceRequest.code",
      "path" : "ServiceRequest.code",
      "min" : 1,
      "mustSupport" : true,
      "binding" : {
        "strength" : "preferred",
        "valueSet" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/ValueSet/ehmi-referral-code-vs"
      }
    },
    {
      "id" : "ServiceRequest.subject",
      "path" : "ServiceRequest.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.dk/fhir/core/StructureDefinition/dk-core-patient"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.encounter",
      "path" : "ServiceRequest.encounter",
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.occurrence[x]",
      "path" : "ServiceRequest.occurrence[x]",
      "slicing" : {
        "discriminator" : [{
          "type" : "type",
          "path" : "$this"
        }],
        "ordered" : false,
        "rules" : "open"
      }
    },
    {
      "id" : "ServiceRequest.occurrence[x]:occurrenceDateTime",
      "path" : "ServiceRequest.occurrence[x]",
      "sliceName" : "occurrenceDateTime",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.authoredOn",
      "path" : "ServiceRequest.authoredOn",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.requester",
      "path" : "ServiceRequest.requester",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.dk/fhir/core/StructureDefinition/dk-core-practitioner",
        "http://hl7.org/fhir/StructureDefinition/PractitionerRole"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.performer",
      "path" : "ServiceRequest.performer",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.dk/fhir/core/StructureDefinition/dk-core-organization",
        "http://hl7.dk/fhir/core/StructureDefinition/dk-core-practitioner"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.reasonCode",
      "path" : "ServiceRequest.reasonCode",
      "mustSupport" : true,
      "binding" : {
        "strength" : "preferred",
        "valueSet" : "http://hl7.org/fhir/ValueSet/condition-code"
      }
    },
    {
      "id" : "ServiceRequest.reasonReference",
      "path" : "ServiceRequest.reasonReference",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Condition"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.supportingInfo",
      "path" : "ServiceRequest.supportingInfo",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Observation",
        "http://hl7.org/fhir/StructureDefinition/Condition",
        "http://hl7.org/fhir/StructureDefinition/DocumentReference"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.note",
      "path" : "ServiceRequest.note",
      "mustSupport" : true
    }]
  }
}

```
