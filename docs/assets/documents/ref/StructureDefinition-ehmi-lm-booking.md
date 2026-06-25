# Booking - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Booking**

## Logical Model: Booking 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-booking | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:Booking |

 
Repræsenterer en aftalt tid der oprettes ved accept af en henvisning. Knyttes til den accept-givne Henvisning og notificerer automatisk patienten og henviseren. Svarer til FHIR Appointment. 

# Entitet: Booking

**FSH LogicalModel:** `EhmiLmBooking` **Primær FHIR-ressource:** `Appointment` **User stories:** 2.3

-------

## Beskrivelse

`Booking` repræsenterer en aftalt tid der oprettes af visitatoren som direkte konsekvens af en positiv visitationsafgørelse. Bookingen knyttes til den accept-givne Henvisning og notificerer automatisk patienten og henviseren om det aftalte tidspunkt.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `bookingId` | 1..1 | Identifier | Unik identifikator for bookingen |
| `status` | 1..1 | code | `proposed`·`booked`·`arrived`·`fulfilled`·`cancelled` |
| `tidspunkt` | 1..1 | dateTime | Det aftalte tidspunkt |
| `varighed` | 0..1 | Duration | Forventet varighed i minutter |
| `fremmoedeType` | 0..1 | CodeableConcept | `fysisk`·`telefonisk`·`video` |
| `lokation` | 0..1 | Reference(Organisation) | Sted for fremmøde |
| `patient` | 1..1 | Reference(Patient) | Patienten der har fået tid |
| `relatertHenvisning` | 1..1 | Reference(Henvisning) | Den henvisning der har udløst bookingen |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `bookingId` | `Appointment.identifier` |   |
| `status` | `Appointment.status` | Bundet til`appointmentstatus`(required) |
| `tidspunkt` | `Appointment.start` |   |
| `varighed` | `Appointment.minutesDuration` |   |
| `fremmoedeType` | `Appointment.appointmentType` |   |
| `lokation` | `Appointment.participant` | `actor`= Location/Organization |
| `patient` | `Appointment.participant` | `actor`= Patient,`required`= required |
| `relatertHenvisning` | `Appointment.basedOn` | Reference til ServiceRequest |

-------

## Relaterede entiteter

* **[Henvisning](01-henvisning.md)** — bookingen er resultatet af en accepteret henvisning
* **[Patient](02-patient.md)** — patienten der har fået tid
* **[Organisation](04-organisation.md)** — stedet for fremmøde
* **[Visitationsafgoerelse](06-visitationsafgoerelse.md)** — accept-afgørelsen udløser booking

-------

## User stories

### Visitatorens user stories

### User story 2.3 Acceptere en henvisning og booke forløb

> **User story:** Som visitator ønsker jeg at kunne acceptere en henvisning og oprette en booking, 
når min visitationsafgørelse er positiv, 
så patienten får en tid og henviseren automatisk modtager bekræftelsen.

 ![](UC-2-3-Acceptere-booke.svg) 

Visitatoren accepterer henvisningen og opretter et forløb. Der bookes en tid, og `ServiceRequest`-status opdateres til `active`. En `Appointment`-ressource oprettes og linkes til henvisningen.

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `ServiceRequest`(active),`Appointment`(booked) |
| **Triggerhændelse:** | Positiv visitationsafgørelse |
| **Forrige trin:** | ←[2.2 Triagere og prioritere](StructureDefinition-ehmi-lm-visitationsafgoerelse.md#user-story-22-triagere-og-prioritere-en-henvisning)**(positiv afgørelse)**·←[3.5 Alternativ visitation](#user-story-35-aftale-om-alternativ-visitation)**(alternativt tilbud accepteres)**·←[3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog)**(afklaring munder ud i accept)** |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](StructureDefinition-ehmi-lm-statusnotifikation.html(#user-story-34-statusnotifikation-til-henviser)**(henviser notificeres om accept og booking)** |

**Usages:**

* Refer to this Logical Model: [Henvisning](StructureDefinition-ehmi-lm-henvisning.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-lm-booking.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-lm-booking.csv), [Excel](StructureDefinition-ehmi-lm-booking.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-lm-booking",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-booking",
  "version" : "0.1.0",
  "name" : "Booking",
  "title" : "Booking",
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
  "description" : "Repræsenterer en aftalt tid der oprettes ved accept af en henvisning.\nKnyttes til den accept-givne Henvisning og notificerer automatisk\npatienten og henviseren. Svarer til FHIR Appointment.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-booking",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "ehmi-lm-booking",
      "path" : "ehmi-lm-booking",
      "short" : "Booking",
      "definition" : "Repræsenterer en aftalt tid der oprettes ved accept af en henvisning.\nKnyttes til den accept-givne Henvisning og notificerer automatisk\npatienten og henviseren. Svarer til FHIR Appointment."
    },
    {
      "id" : "ehmi-lm-booking.bookingId",
      "path" : "ehmi-lm-booking.bookingId",
      "short" : "Unik identifikator for bookingen",
      "definition" : "Unik identifikator for bookingen",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Identifier"
      }],
      "mapping" : [{
        "map" : "Appointment.identifier"
      }]
    },
    {
      "id" : "ehmi-lm-booking.status",
      "path" : "ehmi-lm-booking.status",
      "short" : "proposed | booked | arrived | fulfilled | cancelled",
      "definition" : "proposed | booked | arrived | fulfilled | cancelled",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "Appointment.status"
      }]
    },
    {
      "id" : "ehmi-lm-booking.tidspunkt",
      "path" : "ehmi-lm-booking.tidspunkt",
      "short" : "Det aftalte tidspunkt",
      "definition" : "Det aftalte tidspunkt",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mapping" : [{
        "map" : "Appointment.start"
      }]
    },
    {
      "id" : "ehmi-lm-booking.varighed",
      "path" : "ehmi-lm-booking.varighed",
      "short" : "Forventet varighed",
      "definition" : "Forventet varighed",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Duration"
      }],
      "mapping" : [{
        "map" : "Appointment.minutesDuration"
      }]
    },
    {
      "id" : "ehmi-lm-booking.fremmoedeType",
      "path" : "ehmi-lm-booking.fremmoedeType",
      "short" : "Fremmødetype: fysisk | telefonisk | video",
      "definition" : "Fremmødetype: fysisk | telefonisk | video",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "mapping" : [{
        "map" : "Appointment.appointmentType"
      }]
    },
    {
      "id" : "ehmi-lm-booking.lokation",
      "path" : "ehmi-lm-booking.lokation",
      "short" : "Sted for fremmødet",
      "definition" : "Sted for fremmødet",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-organisation"]
      }],
      "mapping" : [{
        "map" : "Appointment.participant (Location/Organization)"
      }]
    },
    {
      "id" : "ehmi-lm-booking.patient",
      "path" : "ehmi-lm-booking.patient",
      "short" : "Patienten der har fået tid",
      "definition" : "Patienten der har fået tid",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-patient"]
      }],
      "mapping" : [{
        "map" : "Appointment.participant (Patient)"
      }]
    },
    {
      "id" : "ehmi-lm-booking.relatertHenvisning",
      "path" : "ehmi-lm-booking.relatertHenvisning",
      "short" : "Den henvisning der har udløst bookingen",
      "definition" : "Den henvisning der har udløst bookingen",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-henvisning"]
      }],
      "mapping" : [{
        "map" : "Appointment.basedOn (ServiceRequest)"
      }]
    }]
  }
}

```
