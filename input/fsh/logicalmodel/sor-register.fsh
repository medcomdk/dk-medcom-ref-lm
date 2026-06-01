/*
// Logisk model for Sundhedsvæsenets OrganisationsRegister (SOR).
// Denne model beskriver organisatoriske enheder, relationer og service poster i SOR.

Logical: SOROrganizationRelationship
//Parent: http://hl7.org/fhir/StructureDefinition/Logical
Id: SOROrganizationRelationship
Title: "SOR Organization Relationship"
Description: "Relation mellem SOR-enheder, fx tilknytning, samarbejde eller over- og underordnede forhold."
* relationshipType 1..1 CodeableConcept "Type af relation mellem enheder"
* targetOrganization 1..1 Reference(Organization) "Den relaterede organisatoriske enhed"
* startDate 0..1 date "Startdato for relationen"
* endDate 0..1 date "Slutdato for relationen"
* notes 0..1 string "Yderligere oplysninger om relationen"
*/