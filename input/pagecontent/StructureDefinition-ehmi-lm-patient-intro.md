# Entitet: Patient

**FSH LogicalModel:** `EhmiLmPatient`
**Primær FHIR-ressource:** `Patient` (DkCorePatient)
**User stories:** Alle (implicit i 1.1, eksplicit berørt i alle flows)

---

## Beskrivelse

`Patient` repræsenterer den person der er genstand for henvisningen.
I dansk kontekst er CPR-nummeret den primære og autoritative identifikator.
Ressourcen afspejler dk-core-profilen for Patient og anvender de nationale
identifikatorer og adressestrukturer.

---

## Attributter

| Attribut | Kardinalitet | Type | Beskrivelse |
|---|---|---|---|
| `cpr` | 1..1 | Identifier | CPR-nummer (dansk national patientidentifikator) |
| `navn` | 1..1 | HumanName | Fulde navn |
| `foedselsdato` | 0..1 | date | Fødselsdato |
| `koen` | 0..1 | code | `male` · `female` · `other` · `unknown` |
| `adresse` | 0..1 | Address | Bopælsadresse |
| `telefon` | 0..* | ContactPoint | Kontakttelefon(er) |
| `kontaktperson.navn` | 1..1 | HumanName | Pårørendes eller kontaktpersonens navn |
| `kontaktperson.relation` | 1..1 | CodeableConcept | Relation til patient |
| `kontaktperson.telefon` | 0..1 | ContactPoint | Kontaktpersonens telefon |

---

## FHIR-mapping

| Logisk attribut | FHIR-element | Kommentar |
|---|---|---|
| `cpr` | `Patient.identifier` | System: `urn:oid:1.2.208.176.1.2` |
| `navn` | `Patient.name` | HumanName med `family` og `given` |
| `foedselsdato` | `Patient.birthDate` | Kan udledes af CPR |
| `koen` | `Patient.gender` | Kan udledes af CPR |
| `adresse` | `Patient.address` | Dansk adressestruktur |
| `telefon` | `Patient.telecom` | `system=phone` |
| `kontaktperson` | `Patient.contact` | Pårørende / værge |

---

## Relaterede entiteter

- **[Henvisning](01-henvisning.html)** — patienten er subjekt for henvisningen
- **[Booking](07-booking.html)** — patienten er deltager i bookingen


---

## User stories


### Relevante user stories


### User story 1.1 Oprette en ny henvisning

> **User story:** Som henviser ønsker jeg at kunne oprette og afsende en struktureret henvisning via FHIR, <br/>når jeg har truffet en klinisk beslutning om at viderehenvise en patient, <br/>så visitatoren modtager alle nødvendige oplysninger på et standardiseret format.

<p style="display: block;">
<img src="UC-1-1-Oprette-henvisning.svg" alt="UC-1-1" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

|---|
| Henviseren udfærdiger og afsender en ny henvisning til et modtagende tilbud. Henvisningen repræsenteres som en `ServiceRequest`-ressource med status `proposed` og sendes i en FHIR-`Bundle`. Henvisningen indeholder patientoplysninger, indikation, hastegrad og ønsket ydelse. |

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` |
| **Triggerhændelse:** | Klinisk beslutning om at henvise patient |
| **Næste trin:** |→ [1.2 Tilknytte klinisk dokumentation](#user-story-12-tilknytte-klinisk-dokumentation) *(hvis supplerende materiale er relevant)* · <br/>→ [2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(visitatorsiden modtager)* |
{: .grid}
