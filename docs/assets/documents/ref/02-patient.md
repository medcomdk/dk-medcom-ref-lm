# 02 Patient - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **02 Patient**

## 02 Patient

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

* **[Henvisning](StructureDefinition-ehmi-lm-henvisning.md)** — patienten er subjekt for henvisningen
* **[Booking](StructureDefinition-ehmi-lm-booking.md)** — patienten er deltager i bookingen

