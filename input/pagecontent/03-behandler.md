# Entitet: Behandler

**FSH LogicalModel:** `EhmiLmBehandler`
**Primær FHIR-ressource:** `Practitioner` + `PractitionerRole`
**User stories:** Alle (opretter, afsender, triagerer, afgør)

---

## Beskrivelse

`Behandler` repræsenterer en sundhedsprofessionel i flowet — enten som
**henviser** (opretter og afsender en henvisning) eller som **visitator**
(modtager, triagerer og afgør). FHIR adskiller person-identiteten
(`Practitioner`) fra rollen og organisationstilknytningen (`PractitionerRole`).

---

## Attributter

| Attribut | Kardinalitet | Type | Beskrivelse |
|---|---|---|---|
| `autorisationsId` | 1..1 | Identifier | Autorisations-ID (Sundhedsstyrelsen) |
| `navn` | 1..1 | HumanName | Fulde navn |
| `speciale` | 0..1 | CodeableConcept | Fagligt speciale (SKS-klassifikation) |
| `rolle` | 1..1 | CodeableConcept | `henviser` · `visitator` |
| `organisation` | 1..1 | Reference(Organisation) | Tilknyttet organisation |
| `direkteKontakt` | 0..1 | ContactPoint | Telefon eller sikker mail |

---

## FHIR-mapping

| Logisk attribut | FHIR-element | Kommentar |
|---|---|---|
| `autorisationsId` | `Practitioner.identifier` | System: Autorisationsregisterets OID |
| `navn` | `Practitioner.name` | |
| `speciale` | `PractitionerRole.specialty` | SKS-specialekodning |
| `rolle` | `PractitionerRole.code` | Lokalt eller nationalt rollekode-VS |
| `organisation` | `PractitionerRole.organization` | Reference til DkCoreOrganization |
| `direkteKontakt` | `Practitioner.telecom` | |

---

## Relaterede entiteter

- **[Organisation](StructureDefinition-ehmi-lm-organisation.html)** — behandlerens tilknytning
- **[Henvisning](StructureDefinition-ehmi-lm-henvisning.html)** — som afsender (`requester`)
- **[Visitationsafgoerelse](StructureDefinition-ehmi-lm-visitationsafgoerelse.html)** — som afgørende visitator
- **[Kommunikationsbesked](StructureDefinition-ehmi-lm-kommunikationsbesked.html)** — som afsender/modtager
