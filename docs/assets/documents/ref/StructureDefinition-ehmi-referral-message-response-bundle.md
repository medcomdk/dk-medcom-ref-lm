# EHMI Referral Message Response Bundle - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **EHMI Referral Message Response Bundle**

## Resource Profile: EHMI Referral Message Response Bundle 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-referral-message-response-bundle | *Version*:0.1.0 |
| Draft as of 2026-06-16 | *Computable Name*:EHMIReferralMessageResponseBundle |

 
FHIR Bundle der repræsenterer en komplet henvisningsmeddelelse med response via EHMI. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-referral-message-response-bundle.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-referral-message-response-bundle.csv), [Excel](StructureDefinition-ehmi-referral-message-response-bundle.xlsx), [Schematron](StructureDefinition-ehmi-referral-message-response-bundle.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-referral-message-response-bundle",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-referral-message-response-bundle",
  "version" : "0.1.0",
  "name" : "EHMIReferralMessageResponseBundle",
  "title" : "EHMI Referral Message Response Bundle",
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
  "description" : "FHIR Bundle der repræsenterer en komplet henvisningsmeddelelse med response via EHMI.",
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
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Bundle",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Bundle",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Bundle",
      "path" : "Bundle"
    },
    {
      "id" : "Bundle.type",
      "path" : "Bundle.type",
      "patternCode" : "message"
    },
    {
      "id" : "Bundle.timestamp",
      "path" : "Bundle.timestamp",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Bundle.entry",
      "path" : "Bundle.entry",
      "slicing" : {
        "discriminator" : [{
          "type" : "profile",
          "path" : "resource"
        }],
        "ordered" : true,
        "rules" : "open"
      },
      "min" : 6,
      "mustSupport" : true
    },
    {
      "id" : "Bundle.entry:messageHeader",
      "path" : "Bundle.entry",
      "sliceName" : "messageHeader",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Bundle.entry:messageHeader.resource",
      "path" : "Bundle.entry.resource",
      "type" : [{
        "code" : "MessageHeader",
        "profile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-referral-message-header"]
      }]
    },
    {
      "id" : "Bundle.entry:serviceRequest",
      "path" : "Bundle.entry",
      "sliceName" : "serviceRequest",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Bundle.entry:serviceRequest.resource",
      "path" : "Bundle.entry.resource",
      "type" : [{
        "code" : "ServiceRequest",
        "profile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-service-request"]
      }]
    },
    {
      "id" : "Bundle.entry:patient",
      "path" : "Bundle.entry",
      "sliceName" : "patient",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Bundle.entry:patient.resource",
      "path" : "Bundle.entry.resource",
      "type" : [{
        "code" : "Patient",
        "profile" : ["http://hl7.dk/fhir/core/StructureDefinition/dk-core-patient"]
      }]
    },
    {
      "id" : "Bundle.entry:referringPractitioner",
      "path" : "Bundle.entry",
      "sliceName" : "referringPractitioner",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Bundle.entry:referringPractitioner.resource",
      "path" : "Bundle.entry.resource",
      "type" : [{
        "code" : "Practitioner",
        "profile" : ["http://hl7.dk/fhir/core/StructureDefinition/dk-core-practitioner"]
      }]
    },
    {
      "id" : "Bundle.entry:referringOrganization",
      "path" : "Bundle.entry",
      "sliceName" : "referringOrganization",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Bundle.entry:referringOrganization.resource",
      "path" : "Bundle.entry.resource",
      "type" : [{
        "code" : "Organization",
        "profile" : ["http://hl7.dk/fhir/core/StructureDefinition/dk-core-organization"]
      }]
    },
    {
      "id" : "Bundle.entry:receivingOrganization",
      "path" : "Bundle.entry",
      "sliceName" : "receivingOrganization",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Bundle.entry:receivingOrganization.resource",
      "path" : "Bundle.entry.resource",
      "type" : [{
        "code" : "Organization",
        "profile" : ["http://hl7.dk/fhir/core/StructureDefinition/dk-core-organization"]
      }]
    }]
  }
}

```
