# EHMI Message Event Codes - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **EHMI Message Event Codes**

## CodeSystem: EHMI Message Event Codes 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/CodeSystem/ehmi-message-event-cs | *Version*:0.1.0 |
| Draft as of 2026-06-16 | *Computable Name*:EHMIMessageEventCS |

 
Koder for meddelelseshaendelser i EHMI-meddelelseskommunikation. 

 This Code system is referenced in the content logical definition of the following value sets: 

* [EHMIMessageEventVS](ValueSet-ehmi-message-event-vs.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "ehmi-message-event-cs",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/CodeSystem/ehmi-message-event-cs",
  "version" : "0.1.0",
  "name" : "EHMIMessageEventCS",
  "title" : "EHMI Message Event Codes",
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
  "description" : "Koder for meddelelseshaendelser i EHMI-meddelelseskommunikation.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "DK",
      "display" : "Denmark"
    }]
  }],
  "content" : "complete",
  "count" : 4,
  "concept" : [{
    "code" : "new-referral",
    "display" : "Ny henvisning",
    "definition" : "Afsendelse af en ny henvisning"
  },
  {
    "code" : "cancel-referral",
    "display" : "Annuller henvisning",
    "definition" : "Tilbagetrækning af en tidligere sendt henvisning"
  },
  {
    "code" : "update-referral",
    "display" : "Opdater henvisning",
    "definition" : "Rettelse/tilfoejelse til eksisterende henvisning"
  },
  {
    "code" : "acknowledge",
    "display" : "Kvittering",
    "definition" : "Teknisk kvittering for modtagelse"
  }]
}

```
