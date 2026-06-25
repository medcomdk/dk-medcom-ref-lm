# EHMI Referral Code ValueSet - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **EHMI Referral Code ValueSet**

## ValueSet: EHMI Referral Code ValueSet 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/ValueSet/ehmi-referral-code-vs | *Version*:0.1.0 |
| Draft as of 2026-06-16 | *Computable Name*:EHMIReferralCodeVS |

 
Ydelseskoder for EHMI-henvisninger – SKS procedurer og SNOMED CT. 

 **References** 

* [EHMI ServiceRequest – Henvisning](StructureDefinition-ehmi-service-request.md)

### Logical Definition (CLD)

 

### Expansion

No Expansion for this valueset (Unknown Code System)

-------

 Explanation of the columns that may appear on this page: 

| | |
| :--- | :--- |
| Level | A few code lists that FHIR defines are hierarchical - each code is assigned a level. In this scheme, some codes are under other codes, and imply that the code they are under also applies |
| System | The source of the definition of the code (when the value set draws in codes defined elsewhere) |
| Code | The code (used as the code in the resource instance) |
| Display | The display (used in the*display*element of a[Coding](http://hl7.org/fhir/R4/datatypes.html#Coding)). If there is no display, implementers should not simply display the code, but map the concept into their application |
| Definition | An explanation of the meaning of the concept |
| Comments | Additional notes about how to use the code |



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "ehmi-referral-code-vs",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/ValueSet/ehmi-referral-code-vs",
  "version" : "0.1.0",
  "name" : "EHMIReferralCodeVS",
  "title" : "EHMI Referral Code ValueSet",
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
  "description" : "Ydelseskoder for EHMI-henvisninger – SKS procedurer og SNOMED CT.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "DK",
      "display" : "Denmark"
    }]
  }],
  "compose" : {
    "include" : [{
      "system" : "http://snomed.info/sct",
      "filter" : [{
        "property" : "concept",
        "op" : "is-a",
        "value" : "3457005"
      }]
    },
    {
      "system" : "urn:oid:1.2.208.176.2.4"
    }]
  }
}

```
