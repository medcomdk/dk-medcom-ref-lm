# EHMI Acronyms & Glossary

> **Source:** [ehmi.dk](https://ehmi.dk/) — MedCom's Enhanced Healthcare Messaging Infrastructure  
> **Version:** 1.0.0  
> **Last updated:** June 2026

This glossary covers all relevant acronyms and terms used across the EHMI documentation and its sub-pages. Entries are sorted alphabetically.

---

## Acronyms

| Acronym | Full Name | Description | Domain | Relevant Links |
|---------|-----------|-------------|--------|----------------|
| **AP** | Access Point | The eDelivery component responsible for exchanging data between Corner 2 and Corner 3 in the 4-Corner Model. Can be built together with or stand-alone from EUA and MSH. | eDelivery | [eDelivery AP Specifications](https://ec.europa.eu/digital-building-blocks/wikis/display/DIGITAL/Access+Point+specifications) · [ehmiAP](https://ehmi.dk/assets/documents/ecore/ehmiAP/) |
| **AS4** | Applicability Statement 4 | An OASIS-defined messaging protocol used as the transport protocol within eDelivery networks (including PEPPOL). Defines how messages are securely exchanged between Access Points. | OASIS / eDelivery | [OASIS](https://www.oasis-open.org/) |
| **DDS** | Document Sharing Service | A national infrastructure for document sharing with an underlying repository structure based on IHE XDS, hosted on NSP. Collects sent messages from the sender's AP and exposes them in the national infrastructure for both healthcare professionals and citizens. | NSP | [NSP Documentation](https://www.nspop.dk/) |
| **DNS** | Domain Name System | Standard internet infrastructure used within the eDelivery 4-Corner Model to look up the address of the SML, which in turn provides the address of the SMP. | General IT | — |
| **EAS** | EHMI Addressing Service | A health addressing service that helps senders find the correct recipient. Draws information from authoritative sources (e.g., SOR) and returns structured recipient data to the requesting End User Application. Decouples user systems from authoritative sources. | EHMI | [EAS IG](https://build.fhir.org/ig/medcomdk/dk-ehmi-eas/) · [EAS page](https://ehmi.dk/assets/documents/eas/) |
| **ebXML** | Electronic Business using eXtensible Markup Language | A family of XML-based standards maintained by OASIS for electronic business messaging. Underpins some of the eDelivery/PEPPOL specifications. | OASIS | [OASIS](https://www.oasis-open.org/) |
| **EDS** | EHMI Delivery Status (Track'n'Trace) | The delivery status component that collects and exposes the delivery status of sent messages at selected points along the delivery path in near real-time. Enables both healthcare professionals and citizens to follow a message's progress. Implemented as a FHIR AuditEvent-based server. | EHMI | [EDS IG](https://build.fhir.org/ig/medcomdk/dk-ehmi-eds/) · [EDS page](https://ehmi.dk/assets/documents/eds/) |
| **EER** | EHMI Endpoint Register | An organizational register of FHIR messaging and document sharing endpoints linked to the national SOR register. Serves as the authoritative source for SMP registrations, EDS client Devices, and endpoint-to-organization relations. Also feeds the EHMI Addressing Service. | EHMI | [EER IG](https://build.fhir.org/ig/medcomdk/dk-ehmi-eer/) · [EER page](https://ehmi.dk/assets/documents/eer/) |
| **EDIFACT** | Electronic Data Interchange For Administration, Commerce and Transport | A United Nations standard for electronic data interchange. One of the message format types that can be wrapped in an SBDH/ehmiSBDH envelope. | UN/CEFACT | — |
| **EHMI** | Enhanced Healthcare Messaging Infrastructure | MedCom's new healthcare messaging infrastructure built on top of eDelivery. Adds health-specific services (EAS, EDS, EER) and the ehmiSBDH envelope on top of the eDelivery network. Modernizes security, transparency, robustness, and interoperability of clinical message exchange in Denmark. | EHMI | [ehmi.dk](https://ehmi.dk/) |
| **EOJ** | Municipal Emergency/Homecare System (DA: Elektronisk Omsorgsjournalsystem) | The IT system used by Danish municipal emergency/homecare services. Acts as an EUA sending HomeCareObservation FHIR messages in the EHMI production pilot. | Danish Healthcare | [MedCom13 project](https://medcom.dk/projekter/kommunale-proevesvar-paa-ny-infrastruktur/) |
| **EUA** | End User Application | The system used by end users (health professionals) to create and receive messages. In EHMI, the EUA is responsible for composing/consuming the clinical message content and sends FHIR Acknowledgements. Can be built together with MSH and AP. | EHMI | [ehmiEUA](https://ehmi.dk/assets/documents/ecore/ehmiEUA/) |
| **FHIR** | Fast Healthcare Interoperability Resources | An HL7 international standard for exchanging healthcare information electronically. EHMI uses FHIR for message formats, AuditEvents (EDS), endpoint registers (EER), and addressing (EAS). | HL7 | [HL7 FHIR](https://hl7.org/fhir/) |
| **GLN** | Global Location Number | A GS1 identifier used to uniquely identify physical and organisational locations. Used in EHMI/EER as a foreign key linking SOR organisational units to messaging endpoints. | GS1 | [GS1](https://www.gs1.org/) |
| **GS1** | Global Standards 1 (originally EAN International) | The international organisation responsible for GLN numbers and the original SBDH specification. | GS1 | [gs1.org](https://www.gs1.org/) |
| **HL7** | Health Level Seven International | International standards organisation producing health IT interoperability standards, including FHIR, used throughout EHMI. | HL7 | [hl7.org](https://www.hl7.org/) |
| **IG** | Implementation Guide | A formal specification published in the HL7 FHIR standard format, describing how FHIR resources are used in a specific context. EHMI publishes separate IGs for EDS, EAS, EER, and ehmiSBDH. | HL7 / FHIR | [EHMI IGs on build.fhir.org](https://build.fhir.org/ig/medcomdk/) |
| **IHE** | Integrating the Healthcare Enterprise | International organisation that creates healthcare interoperability profiles. EHMI relies on IHE XDS for document sharing on NSP. | IHE | [ihe.net](https://www.ihe.net/) |
| **LPS** | General Medical Practice System (DA: Lægepraksissystem) | The IT system used by Danish general practitioners. Acts as a receiver EUA in the EHMI production pilot for HomeCareObservation messages. | Danish Healthcare | [MedCom13 project](https://medcom.dk/projekter/kommunale-proevesvar-paa-ny-infrastruktur/) |
| **MSH** | Message Service Handler | The EHMI component responsible for wrapping clinical messages into the ehmiSBDH envelope. Can be a module within an EUA or AP, or a stand-alone application. MSHs communicate logically with each other through the metadata content in ehmiSBDH envelopes. | EHMI | [ehmiMSH](https://ehmi.dk/assets/documents/ecore/ehmiMSH/) |
| **NSIS** | National Standard for Identities and Security (DA: National Standard for Identiteters Sikringsniveauer) | Danish national standard defining levels of identity assurance. EHMI security requires NSIS level "significant" (equivalent to NIST level 3–4) for access to personally identifiable information. | Danish Security | — |
| **NSP** | National Service Platform (DA: Den Nationale Serviceplatform) | The Danish national infrastructure platform for health data services, hosting e.g. the XDS Document Sharing index and national consent/treatment relation services. | Danish Healthcare IT | [nspop.dk](https://www.nspop.dk/) |
| **OASIS** | Organization for the Advancement of Structured Information Standards | The standards organisation responsible for specifications of AS4, SML, SMP, and ebXML used in eDelivery. | OASIS | [oasis-open.org](https://www.oasis-open.org/) |
| **OIO-XML** | Object-oriented Interface, XML-based (DA: Offentlig Information Online) | A Danish XML-based standard for public sector data exchange. One of the message format types that can be wrapped in an SBDH/ehmiSBDH envelope alongside EDIFACT and FHIR. | Danish Public Sector | — |
| **PEPPOL** | Pan-European Public Procurement On-Line | A network and set of specifications (including SBDH, AS4, SML, SMP) for cross-border electronic document exchange. EHMI's eDelivery layer is based on PEPPOL infrastructure. | PEPPOL | [peppol.eu](https://peppol.eu/) |
| **SBD** | Standard Business Document | The complete wrapper object consisting of the SBDH header and the binary payload (the actual message content) within an ehmiSBDH envelope. | PEPPOL / GS1 | [PEPPOL SBDH envelope](https://docs.peppol.eu/edelivery/envelope/Peppol-EDN-Business-Message-Envelope-2.0.1-2023-08-17.pdf) |
| **SBDH** | Standard Business Document Header | A PEPPOL/GS1-defined envelope header that carries metadata for routing and processing a message in an eDelivery context. Can contain different message format types (EDIFACT, OIO-XML, FHIR). The basis for ehmiSBDH. | PEPPOL / GS1 | [PEPPOL SBDH envelope](https://docs.peppol.eu/edelivery/envelope/Peppol-EDN-Business-Message-Envelope-2.0.1-2023-08-17.pdf) |
| **SDN** | Health Data Network (DA: Sundhedsdatanettet) | The Danish national health data network over which EHMI messages are transported via eDelivery. | Danish Healthcare IT | [MedCom SDN page](https://medcom.dk/systemforvaltning/sundhedsdatanettet-sdn/) |
| **SML** | Service Metadata Locator | An eDelivery/PEPPOL directory (DNS-based) used by a sending AP (Corner 2) to find the address of the SMP that holds the receiving system's capabilities. | eDelivery / PEPPOL | [OASIS](https://www.oasis-open.org/) |
| **SMP** | Service Metadata Provider | An eDelivery/PEPPOL service that stores the receiver's capabilities (supported message types, AP addresses). Queried by the sending AP to verify receiver capabilities and find the receiving AP address. ehmiSMP is EHMI's profile of SMP. | eDelivery / PEPPOL | [ehmiSMP](https://ehmi.dk/assets/documents/ecore/ehmiSMP/) · [OASIS](https://www.oasis-open.org/) |
| **SOR** | Danish Healthcare Organisation Register (DA: Sundhedsvæsenets Organisationsregister) | The authoritative Danish register of healthcare organisations, units, and their physical locations. Used as the primary organisational identifier in EER (SORID) and as a data source in EAS. | Danish Healthcare IT | — |
| **XDS** | Cross-Enterprise Document Sharing | An IHE integration profile for sharing documents across healthcare enterprises. EHMI uses XDS (via NSP/DDS) for the secondary document sharing flow where sent messages are deposited in the national document sharing infrastructure. | IHE | [ihe.net](https://www.ihe.net/) |

---

## EHMI-specific Component Terms

| Term | Description | Relevant Links |
|------|-------------|----------------|
| **4-Corner Model** | The eDelivery/PEPPOL routing model: Corner 1 = Sender system; Corner 2 = Sender's AP; Corner 3 = Receiver's AP; Corner 4 = Receiver system. Corner 2 queries SML/DNS → SMP to find Corner 3, then delivers the message. | [eDelivery](https://ec.europa.eu/digital-building-blocks/wikis/display/DIGITAL/eDelivery) |
| **ehmiAck / ehmiEnvelopeReceipt** | EHMI Envelope Receipt. An acknowledgement sent from the receiver's MSH back to the sender's MSH at the eDelivery envelope level, confirming receipt of the ehmiSBDH envelope. Distinct from the FHIR-level Acknowledgement sent between EUAs. | [EHMI Core](https://ehmi.dk/assets/documents/ecore/) |
| **ehmiSBDH** | EHMI's customized profile of the PEPPOL SBDH envelope. Used between MSHs to carry message metadata, reliable messaging data, XDS document sharing metadata, and EDS delivery status triggers across the eDelivery network. | [ehmiSBDH IG](https://build.fhir.org/ig/medcomdk/dk-ehmi-sbdh/index.html) · [ehmiSBDH page](https://ehmi.dk/assets/documents/ecore/ehmiSBDH/) |
| **ehmiSMP** | EHMI's profile of the Service Metadata Provider. Specifies how AP capabilities and message routing metadata are registered and queried within EHMI's eDelivery network. | [ehmiSMP](https://ehmi.dk/assets/documents/ecore/ehmiSMP/) |
| **EdsBasicDeliveryStatus** | An EDS registration type for messages without patient data (e.g., MedCom Acknowledgements). Used by EDS Clients to register delivery status without including patient identifiers. | [EDS IG](https://build.fhir.org/ig/medcomdk/dk-ehmi-eds/) |
| **EdsPatientDeliveryStatus** | An EDS registration type for messages that contain patient data (e.g., normal MedCom clinical messages). Includes patient reference alongside delivery status data. | [EDS IG](https://build.fhir.org/ig/medcomdk/dk-ehmi-eds/) |
| **HomeCareObservation** | A new MedCom FHIR message standard for municipal test responses (e.g., blood samples taken by homecare services), sent from municipal EOJ systems to general practitioner LPS systems. The primary message type tested in the EHMI production pilot. | [MedCom13 project](https://medcom.dk/projekter/kommunale-proevesvar-paa-ny-infrastruktur/) |
| **MinLog** | Danish national citizen log service. Under EHMI security requirements, healthcare professionals' access to citizens' personal data must be viewable by citizens via MinLog. | — |
| **VANSEnvelope** | The predecessor envelope format used on MedCom's legacy VANS network. ehmiSBDH handles the same reliable messaging responsibilities for the EHMI network that VANSEnvelope provided on the VANS network. | [MedCom Governance for Reliable Messaging](https://medcomdk.github.io/MedCom-FHIR-Communication/assets/documents/020_Governance-for-Reliable-Messaging-in-general.html) |

---

## About

This glossary is compiled from [ehmi.dk](https://ehmi.dk/) and its sub-pages, maintained by [MedCom](https://www.medcom.dk/).  
Questions: [ehmi@medcom.dk](mailto:ehmi@medcom.dk) · Issues: [GitHub Issues for EHMI®](https://github.com/medcomdk/ehmi/issues)

*"EHMI® is the registered trademark of MedCom and is used with the permission of MedCom."*
