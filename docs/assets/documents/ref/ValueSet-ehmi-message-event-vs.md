# EHMI Message Event ValueSet - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **EHMI Message Event ValueSet**

## ValueSet: EHMI Message Event ValueSet 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/ValueSet/ehmi-message-event-vs | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:EHMIMessageEventVS |

 
ValueSet over gyldige meddelelseshaendelser til brug i MessageHeader.eventCoding. 

 **References** 

* [EHMI Referral MessageHeader](StructureDefinition-ehmi-referral-message-header.md)

### Logical Definition (CLD)

 

### Expansion

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
  "id" : "ehmi-message-event-vs",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/ValueSet/ehmi-message-event-vs",
  "version" : "0.1.0",
  "name" : "EHMIMessageEventVS",
  "title" : "EHMI Message Event ValueSet",
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
  "description" : "ValueSet over gyldige meddelelseshaendelser til brug i MessageHeader.eventCoding.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "DK",
      "display" : "Denmark"
    }]
  }],
  "compose" : {
    "include" : [{
      "system" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/CodeSystem/ehmi-message-event-cs"
    }]
  }
}

```
