# 04 Organisation - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **04 Organisation**

## 04 Organisation

# Entitet: Organisation

**FSH LogicalModel:** `EhmiLmOrganisation` **Primær FHIR-ressource:** `Organization` (DkCoreOrganization) **User stories:** 1.1, 2.1, 2.5

-------

## Beskrivelse

`Organisation` repræsenterer en sundhedsorganisation der enten afsender eller modtager henvisninger via EHMI. SOR-koden er den primære nationale identifikator, og EHMI-endpointet er den tekniske adresse i eDelivery-infrastrukturen.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `sorKode` | 1..1 | Identifier | SOR-kode (Sundhedsorganisationsregisteret) |
| `glnNummer` | 0..1 | Identifier | GLN-nummer (Global Location Number) |
| `ydernummer` | 0..1 | Identifier | Ydernummer (praksis-identifikator) |
| `navn` | 1..1 | string | Organisationens navn |
| `type` | 1..1 | CodeableConcept | `hospital`·`praksis`·`speciallaegepraksis`·`kommunal` |
| `adresse` | 0..1 | Address | Organisationens adresse |
| `ehmiEndpoint` | 1..1 | url | EHMI/eDelivery endpoint (AP-adresse) |
| `overordnetOrganisation` | 0..1 | Reference(Organisation) | Fx region eller hospital |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `sorKode` | `Organization.identifier` | System:`https://www.esundhed.dk/NamingSystem/SOR` |
| `glnNummer` | `Organization.identifier` | System: GLN OID |
| `ydernummer` | `Organization.identifier` | System: Ydernummer-OID |
| `navn` | `Organization.name` |   |
| `type` | `Organization.type` |   |
| `adresse` | `Organization.address` |   |
| `ehmiEndpoint` | `Organization.endpoint` | Reference til FHIR Endpoint-ressource med EHMI URL |
| `overordnetOrganisation` | `Organization.partOf` |   |

-------

## Relaterede entiteter

* **[Behandler](StructureDefinition-ehmi-lm-behandler.md)** — behandlere er tilknyttet en organisation
* **[Henvisning](StructureDefinition-ehmi-lm-henvisning.md)** — afsender og modtager-organisation
* **[Abonnement](StructureDefinition-ehmi-lm-abonnement.md)** — organisationen er abonnent
* **[Meddelelseskonvolut](StructureDefinition-ehmi-lm-meddelelseskonvolut.md)** — routing via SOR/EHMI

