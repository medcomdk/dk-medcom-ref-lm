# Patient - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Patient**

## Logical Model: Patient 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-patient | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:Patient |

 
Repræsenterer den patient der viderehenvises. Svarer til FHIR Patient profileret som DkCorePatient med dansk CPR-nummer som primær identifikator. 

# Entitet: Patient

**FSH LogicalModel:** `EhmiLmPatient` **Primær FHIR-ressource:** `Patient` (DkCorePatient) **User stories:** Alle (implicit i 1.1, eksplicit berørt i alle flows)

-------

## Beskrivelse

`Patient` repræsenterer den person der er genstand for henvisningen. I dansk kontekst er CPR-nummeret den primære og autoritative identifikator. Ressourcen afspejler dk-core-profilen for Patient og anvender de nationale identifikatorer og adressestrukturer.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `cpr` | 1..1 | Identifier | CPR-nummer (dansk national patientidentifikator) |
| `navn` | 1..1 | HumanName | Fulde navn |
| `foedselsdato` | 0..1 | date | Fødselsdato |
| `koen` | 0..1 | code | `male`·`female`·`other`·`unknown` |
| `adresse` | 0..1 | Address | Bopælsadresse |
| `telefon` | 0..* | ContactPoint | Kontakttelefon(er) |
| `kontaktperson.navn` | 1..1 | HumanName | Pårørendes eller kontaktpersonens navn |
| `kontaktperson.relation` | 1..1 | CodeableConcept | Relation til patient |
| `kontaktperson.telefon` | 0..1 | ContactPoint | Kontaktpersonens telefon |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `cpr` | `Patient.identifier` | System:`urn:oid:1.2.208.176.1.2` |
| `navn` | `Patient.name` | HumanName med`family`og`given` |
| `foedselsdato` | `Patient.birthDate` | Kan udledes af CPR |
| `koen` | `Patient.gender` | Kan udledes af CPR |
| `adresse` | `Patient.address` | Dansk adressestruktur |
| `telefon` | `Patient.telecom` | `system=phone` |
| `kontaktperson` | `Patient.contact` | Pårørende / værge |

-------

## Relaterede entiteter

* **[Henvisning](01-henvisning.md)** — patienten er subjekt for henvisningen
* **[Booking](07-booking.md)** — patienten er deltager i bookingen

-------

## User stories

### Relevante user stories

### User story 1.1 Oprette en ny henvisning

> **User story:** Som henviser ønsker jeg at kunne oprette og afsende en struktureret henvisning via FHIR, 
når jeg har truffet en klinisk beslutning om at viderehenvise en patient, 
så visitatoren modtager alle nødvendige oplysninger på et standardiseret format.

 ![](UC-1-1-Oprette-henvisning.svg) 

| |
| :--- |
| Henviseren udfærdiger og afsender en ny henvisning til et modtagende tilbud. Henvisningen repræsenteres som en`ServiceRequest`-ressource med status`proposed`og sendes i en FHIR-`Bundle`. Henvisningen indeholder patientoplysninger, indikation, hastegrad og ønsket ydelse. |

| | |
| :--- | :--- |
| **Primær FHIR-ressource:** | `ServiceRequest` |
| **Triggerhændelse:** | Klinisk beslutning om at henvise patient |
| **Næste trin:** | →[1.2 Tilknytte klinisk dokumentation](#user-story-12-tilknytte-klinisk-dokumentation)**(hvis supplerende materiale er relevant)**·→[2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning)**(visitatorsiden modtager)** |

**Usages:**

* Refer to this Logical Model: [Booking](StructureDefinition-ehmi-lm-booking.md) and [Henvisning](StructureDefinition-ehmi-lm-henvisning.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-ehmi-lm-patient.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ehmi-lm-patient.csv), [Excel](StructureDefinition-ehmi-lm-patient.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ehmi-lm-patient",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-patient",
  "version" : "0.1.0",
  "name" : "Patient",
  "title" : "Patient",
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
  "description" : "Repræsenterer den patient der viderehenvises. Svarer til FHIR Patient\nprofileret som DkCorePatient med dansk CPR-nummer som primær identifikator.",
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
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/ehmi-lm-patient",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "ehmi-lm-patient",
      "path" : "ehmi-lm-patient",
      "short" : "Patient",
      "definition" : "Repræsenterer den patient der viderehenvises. Svarer til FHIR Patient\nprofileret som DkCorePatient med dansk CPR-nummer som primær identifikator."
    },
    {
      "id" : "ehmi-lm-patient.cpr",
      "path" : "ehmi-lm-patient.cpr",
      "short" : "CPR-nummer (dansk national patientidentifikator)",
      "definition" : "CPR-nummer (dansk national patientidentifikator)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Identifier"
      }],
      "mapping" : [{
        "map" : "Patient.identifier (urn:oid:1.2.208.176.1.2)"
      }]
    },
    {
      "id" : "ehmi-lm-patient.navn",
      "path" : "ehmi-lm-patient.navn",
      "short" : "Fulde navn",
      "definition" : "Fulde navn",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "HumanName"
      }],
      "mapping" : [{
        "map" : "Patient.name"
      }]
    },
    {
      "id" : "ehmi-lm-patient.foedselsdato",
      "path" : "ehmi-lm-patient.foedselsdato",
      "short" : "Fødselsdato",
      "definition" : "Fødselsdato",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "date"
      }],
      "mapping" : [{
        "map" : "Patient.birthDate"
      }]
    },
    {
      "id" : "ehmi-lm-patient.koen",
      "path" : "ehmi-lm-patient.koen",
      "short" : "Køn: male | female | other | unknown",
      "definition" : "Køn: male | female | other | unknown",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }],
      "mapping" : [{
        "map" : "Patient.gender"
      }]
    },
    {
      "id" : "ehmi-lm-patient.adresse",
      "path" : "ehmi-lm-patient.adresse",
      "short" : "Bopælsadresse",
      "definition" : "Bopælsadresse",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Address"
      }],
      "mapping" : [{
        "map" : "Patient.address"
      }]
    },
    {
      "id" : "ehmi-lm-patient.telefon",
      "path" : "ehmi-lm-patient.telefon",
      "short" : "Kontakttelefon(er)",
      "definition" : "Kontakttelefon(er)",
      "min" : 0,
      "max" : "*",
      "type" : [{
        "code" : "ContactPoint"
      }],
      "mapping" : [{
        "map" : "Patient.telecom"
      }]
    },
    {
      "id" : "ehmi-lm-patient.kontaktperson",
      "path" : "ehmi-lm-patient.kontaktperson",
      "short" : "Pårørende eller anden kontakt",
      "definition" : "Pårørende eller anden kontakt",
      "min" : 0,
      "max" : "*",
      "type" : [{
        "code" : "BackboneElement"
      }],
      "mapping" : [{
        "map" : "Patient.contact"
      }]
    },
    {
      "id" : "ehmi-lm-patient.kontaktperson.navn",
      "path" : "ehmi-lm-patient.kontaktperson.navn",
      "short" : "Kontaktpersonens navn",
      "definition" : "Kontaktpersonens navn",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "HumanName"
      }]
    },
    {
      "id" : "ehmi-lm-patient.kontaktperson.relation",
      "path" : "ehmi-lm-patient.kontaktperson.relation",
      "short" : "Relation til patient (pårørende, værge mv.)",
      "definition" : "Relation til patient (pårørende, værge mv.)",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "ehmi-lm-patient.kontaktperson.telefon",
      "path" : "ehmi-lm-patient.kontaktperson.telefon",
      "short" : "Kontaktpersonens telefon",
      "definition" : "Kontaktpersonens telefon",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "ContactPoint"
      }]
    }]
  }
}

```
