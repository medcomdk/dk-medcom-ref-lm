# Kommunikationsbesked - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Kommunikationsbesked**

## Logical Model: Kommunikationsbesked 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-kommunikationsbesked | *Version*:0.1.0 |
| Draft as of 2026-06-16 | *Computable Name*:Kommunikationsbesked |

 
Repræsenterer en struktureret besked i den løbende dialog mellem henviser og visitator. Bruges til supplement-anmodninger, faglig afklaring, alternativ visitation og korrektionsaftaler. Svarer til FHIR Communication eller CommunicationRequest. 

# Entitet: Kommunikationsbesked

**FSH LogicalModel:** `EhmiLmKommunikationsbesked` **Primær FHIR-ressource:** `Communication`, `CommunicationRequest` **User stories:** 3.1, 3.2, 3.3, 3.5, 3.6

-------

## Beskrivelse

`Kommunikationsbesked` repræsenterer enhver struktureret besked der udveksles direkte mellem henviser og visitator som led i dialogen om en konkret henvisning. Det dækker fem scenarier:

| | | |
| :--- | :--- | :--- |
| Anmodning om supplement (3.1) | `anmodning` | `CommunicationRequest` |
| Svar på supplement (3.2) | `svar` | `Communication` |
| Faglig afklaringsdialog (3.3) | `afklaring` | `Communication`(tråd) |
| Aftale om alternativ visitation (3.5) | `afklaring` | `Communication` |
| Korrektionsaftale (3.6) | `korrektionsaftale` | `Communication` |

Dialogtråde (3.3) modelleres som kæder af `Communication`-ressourcer bundet sammen via `inResponseTo`-feltet.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `beskedId` | 1..1 | Identifier | Unik identifikator for beskeden |
| `type` | 1..1 | code | `anmodning`·`svar`·`afklaring`·`notifikation`·`korrektionsaftale` |
| `status` | 1..1 | code | `preparation`·`in-progress`·`completed`·`entered-in-error` |
| `emne` | 0..1 | string | Kort emne eller titel |
| `indhold` | 1..1 | string | Beskedens tekstindhold |
| `sendt` | 1..1 | dateTime | Afsendelsestidspunkt |
| `afsender` | 1..1 | Reference(Behandler) | Den der har afsendt beskeden |
| `modtager` | 1..* | Reference(Behandler) | Den eller de der modtager beskeden |
| `svarPaa` | 0..1 | Reference(Kommunikationsbesked) | Reference til den besked der besvares |
| `vedroererHenvisning` | 1..1 | Reference(Henvisning) | Den henvisning kommunikationen vedrører |
| `bilag` | 0..* | Reference(KliniskDokumentation) | Eventuelle vedlagte dokumenter |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `beskedId` | `Communication.identifier` |   |
| `type` | `Communication.category` | Lokalt kodeset for beskedtype |
| `status` | `Communication.status` |   |
| `emne` | `Communication.topic` |   |
| `indhold` | `Communication.payload.contentString` |   |
| `sendt` | `Communication.sent` |   |
| `afsender` | `Communication.sender` |   |
| `modtager` | `Communication.recipient` |   |
| `svarPaa` | `Communication.inResponseTo` | Knytter tråden (3.3) |
| `vedroererHenvisning` | `Communication.basedOn` | Reference til ServiceRequest |
| `bilag` | `Communication.payload` | `contentReference`til DocumentReference |

For supplement-**anmodninger** (3.1) anvendes `CommunicationRequest` hvor `CommunicationRequest.basedOn` refererer til `ServiceRequest`.

-------

## Relaterede entiteter

* **[Henvisning](01-henvisning.md)** — alle beskeder vedrører en konkret henvisning
* **[Behandler](03-behandler.md)** — afsender og modtager
* **[KliniskDokumentation](05-klinisk-dokumentation.md)** — vedlagte bilag

-------

## User stories

### Udvekslingsdialog

### User story 3.1 Anmode om supplerende oplysninger

> **User story:** Som visitator ønsker jeg at kunne sende en struktureret anmodning om supplerende oplysninger til henviseren, 
når grundlaget for triage er utilstrækkeligt, 
så jeg kan træffe en fagligt forsvarlig visitationsafgørelse uden at afvise unødigt.

 ![](UC-3-1-Anmode-supplement.svg) 

Visitatoren mangler oplysninger for at kunne triagere og sender en struktureret anmodning til henviseren om at supplere med konkrete kliniske data — fx blodprøveresultater, BMI, medicinliste eller tidligere forløb.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `CommunicationRequest`(fra visitator til henviser) |
| **Triggerhændelse:** | Utilstrækkeligt grundlag for visitationsafgørelse |
| **Forrige trin:** | ←[2.2 Triagere og prioritere](StructureDefinition-ehmi-lm-visitationsafgoerelse.md#user-story-22-triagere-og-prioritere-en-henvisning)**(utilstrækkeligt grundlag for triage)** |
| **Næste trin:** | →[3.2 Besvare anmodning om supplement](#user-story-32-besvare-anmodning-om-supplement) |

### User story 3.2 Besvare anmodning om supplement

> **User story:** Som henviser ønsker jeg at kunne besvare en supplement-anmodning med de efterspurgte kliniske oplysninger, 
når visitatoren har bedt om yderligere data, 
så visitatoren hurtigt kan genoptage og afslutte triage-processen.

 ![](UC-3-2-Besvare-supplement.svg) 

Henviseren modtager en supplement-anmodning og besvarer denne ved at sende de efterspurgte oplysninger. Svaret sendes som en `Communication`-ressource med reference til den oprindelige `CommunicationRequest` og til `ServiceRequest`.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `Communication`(reply, in-response-to) |
| **Triggerhændelse:** | Modtagelse af CommunicationRequest fra visitatoren |
| **Forrige trin:** | ←[3.1 Anmode om supplerende oplysninger](#user-story-31-anmode-om-supplerende-oplysninger)**(supplement anmodet)** |
| **Næste trin:** | →[2.2 Triagere og prioritere en henvisning](StructureDefinition-ehmi-lm-visitationsafgoerelse.md#user-story-22-triagere-og-prioritere-en-henvisning)**(visitatoren genoptager triage med det modtagne supplement)**·→[3.3 Faglig afklaring i dialog](#user-story-33-faglig-afklaring-i-dialog)**(hvis svaret afføder yderligere spørgsmål)** |

### User story 3.3 Faglig afklaring i dialog

> **User story:** Som henviser og visitator ønsker vi begge at kunne føre en struktureret faglig dialog om en konkret henvisning, 
når indikation, egnethed eller behandlingsvalg er uklart, 
så vi i fællesskab kan nå frem til den rigtige afgørelse for patienten uden at skulle bruge andre kommunikationskanaler.

 ![](UC-3-3-Faglig-afklaring.svg) 

Henviser og visitator udveksler kliniske spørgsmål og svar for at afklare indikation, behandlingsegnethed eller alternativ tilgang — uden at dette nødvendigvis afklares i én besked. Dialogen føres som en kæde af `Communication`-ressourcer med indbyrdes referencer.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `Communication`(thread med in-response-to-kæde) |
| **Triggerhændelse:** | Faglig uklarhed der kræver mere end én udveksling |
| **Forrige trin:** | ←[3.2 Besvare anmodning om supplement](#user-story-32-besvare-anmodning-om-supplement)**(svaret afføder yderligere spørgsmål)** |
| **Næste trin:** | →[2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forløb)**(afklaring munder ud i accept)**·→[2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning)**(afklaring munder ud i afvisning)** |

### User story 3.5 Aftale om alternativ visitation

> **User story:** Som visitator ønsker jeg at kunne indlede en dialog med henviseren om et alternativt tilbud, 
når jeg ikke kan imødekomme den primære henvisning, 
så patienten ikke ender i en blindgyde og vi i fællesskab finder en løsning.

 ![](UC-3-5-Alternativ-visitation.svg) 

Henviser og visitator forhandler i fællesskab om et alternativt tilbud, 
når det primære visitationsspor ikke er muligt. Dialogen foregår via `Communication`, og den resulterende aftale dokumenteres i en `Task` med reference til det alternative tilbud.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `Communication`,`Task`,`ServiceRequest`(alternativ) |
| **Triggerhændelse:** | Afvisning kombineret med behov for at finde alternativ løsning for patienten |
| **Forrige trin:** | ←[2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning)**(afvisning kombineret med søgning efter alternativ)** |
| **Næste trin:** | →[1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning)**(nyt alternativt tilbud kræver ny henvisning)**·→[2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forløb)**(alternativt tilbud accepteres)** |

### User story 3.6 Korrektionsaftale om fejl i afsendt henvisning

> **User story:** Som visitator ønsker jeg at kunne kontakte henviseren og aftale en korrektion, 
når jeg opdager en fejl i en modtaget henvisning, 
så fejlen rettes på en koordineret og sporbar måde uden at vi mister historikken.

 ![](UC-3-6-Korrektionsaftale.svg) 

Visitatoren opdager en fejl i en modtaget henvisning — fx forkert CPR-nummer, forkert ydelseskode eller manglende samtykkedokumentation — og indleder en dialog med henviseren om korrektion. Korrektionen aftales via `Communication`-besked og gennemføres med en efterfølgende opdatering af `ServiceRequest`.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `Communication`,`ServiceRequest`(korrektion) |
| **Triggerhændelse:** | Fejl opdaget under modtagelse eller triage hos visitatoren |
| **Forrige trin:** | ←[2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning)**(fejl opdaget, korrektionsdiolog indledes)** |
| **Næste trin:** | →[1.3 Ændre en afsendt henvisning](#user-story-13-ændre-en-afsendt-henvisning)**(henviser retter og sender)**·→[2.2 Triagere og prioritere en henvisning](StructureDefinition-ehmi-lm-visitationsafgoerelse.md#user-story-22-triagere-og-prioritere-en-henvisning)**(visitatoren genoptager triage efter korrektion)** |

**Usages:**

* Refer to this Logical Model: [Kommunikationsbesked](StructureDefinition-ehmi-lm-kommunikationsbesked.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-lm-kommunikationsbesked.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-lm-kommunikationsbesked.csv), [Excel](StructureDefinition-ehmi-lm-kommunikationsbesked.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-lm-kommunikationsbesked",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-kommunikationsbesked",
  "version" : "0.1.0",
  "name" : "Kommunikationsbesked",
  "title" : "Kommunikationsbesked",
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
  "description" : "Repræsenterer en struktureret besked i den løbende dialog mellem\nhenviser og visitator. Bruges til supplement-anmodninger, faglig\nafklaring, alternativ visitation og korrektionsaftaler.\nSvarer til FHIR Communication eller CommunicationRequest.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "DK",
      "display" : "Denmark"
    }]
  }],
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "fhir-r4",
    "uri" : "http://hl7.org/fhir",
    "name" : "RIM Mapping"
  }],
  "kind" : "logical",
  "abstract" : false,
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-kommunikationsbesked",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "ehmi-lm-kommunikationsbesked",
      "path" : "ehmi-lm-kommunikationsbesked",
      "short" : "Kommunikationsbesked",
      "definition" : "Repræsenterer en struktureret besked i den løbende dialog mellem\nhenviser og visitator. Bruges til supplement-anmodninger, faglig\nafklaring, alternativ visitation og korrektionsaftaler.\nSvarer til FHIR Communication eller CommunicationRequest."
    },
    {
      "id" : "ehmi-lm-kommunikationsbesked.beskedId",
      "path" : "ehmi-lm-kommunikationsbesked.beskedId",
      "short" : "Unik identifikator for beskeden",
      "definition" : "Unik identifikator for beskeden",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Identifier"
      }],
      "mapping" : [{
        "map" : "Communication.identifier"
      }]
    },
    {
      "id" : "ehmi-lm-kommunikationsbesked.type",
      "path" : "ehmi-lm-kommunikationsbesked.type",
      "short" : "anmodning | svar | afklaring | notifikation | korrektionsaftale",
      "definition" : "anmodning | svar | afklaring | notifikation | korrektionsaftale",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "Communication.category | CommunicationRequest.category"
      }]
    },
    {
      "id" : "ehmi-lm-kommunikationsbesked.status",
      "path" : "ehmi-lm-kommunikationsbesked.status",
      "short" : "preparation | in-progress | completed | entered-in-error",
      "definition" : "preparation | in-progress | completed | entered-in-error",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "Communication.status"
      }]
    },
    {
      "id" : "ehmi-lm-kommunikationsbesked.emne",
      "path" : "ehmi-lm-kommunikationsbesked.emne",
      "short" : "Kort emne eller titel",
      "definition" : "Kort emne eller titel",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }],
      "mapping" : [{
        "map" : "Communication.topic"
      }]
    },
    {
      "id" : "ehmi-lm-kommunikationsbesked.indhold",
      "path" : "ehmi-lm-kommunikationsbesked.indhold",
      "short" : "Beskedens tekstindhold",
      "definition" : "Beskedens tekstindhold",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }],
      "mapping" : [{
        "map" : "Communication.payload.contentString"
      }]
    },
    {
      "id" : "ehmi-lm-kommunikationsbesked.sendt",
      "path" : "ehmi-lm-kommunikationsbesked.sendt",
      "short" : "Afsendelsestidspunkt",
      "definition" : "Afsendelsestidspunkt",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mapping" : [{
        "map" : "Communication.sent"
      }]
    },
    {
      "id" : "ehmi-lm-kommunikationsbesked.afsender",
      "path" : "ehmi-lm-kommunikationsbesked.afsender",
      "short" : "Den der har afsendt beskeden",
      "definition" : "Den der har afsendt beskeden",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-behandler"]
      }],
      "mapping" : [{
        "map" : "Communication.sender"
      }]
    },
    {
      "id" : "ehmi-lm-kommunikationsbesked.modtager",
      "path" : "ehmi-lm-kommunikationsbesked.modtager",
      "short" : "Den eller de der modtager beskeden",
      "definition" : "Den eller de der modtager beskeden",
      "min" : 1,
      "max" : "*",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-behandler"]
      }],
      "mapping" : [{
        "map" : "Communication.recipient"
      }]
    },
    {
      "id" : "ehmi-lm-kommunikationsbesked.svarPaa",
      "path" : "ehmi-lm-kommunikationsbesked.svarPaa",
      "short" : "Reference til den besked der besvares",
      "definition" : "Reference til den besked der besvares",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-kommunikationsbesked"]
      }],
      "mapping" : [{
        "map" : "Communication.inResponseTo"
      }]
    },
    {
      "id" : "ehmi-lm-kommunikationsbesked.vedroererHenvisning",
      "path" : "ehmi-lm-kommunikationsbesked.vedroererHenvisning",
      "short" : "Den henvisning kommunikationen vedrører",
      "definition" : "Den henvisning kommunikationen vedrører",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-henvisning"]
      }],
      "mapping" : [{
        "map" : "Communication.basedOn (ServiceRequest)"
      }]
    },
    {
      "id" : "ehmi-lm-kommunikationsbesked.bilag",
      "path" : "ehmi-lm-kommunikationsbesked.bilag",
      "short" : "Eventuelle vedlagte dokumenter",
      "definition" : "Eventuelle vedlagte dokumenter",
      "min" : 0,
      "max" : "*",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-klinisk-dokumentation"]
      }],
      "mapping" : [{
        "map" : "Communication.payload (Attachment/Reference)"
      }]
    }]
  }
}

```
